import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/app/home/models/projet.dart';
import 'package:alert_dialogs/alert_dialogs.dart';
import 'package:starter_architecture_flutter_firebase/app/top_level_providers.dart';
import 'package:starter_architecture_flutter_firebase/routing/app_router.dart';
import 'package:starter_architecture_flutter_firebase/services/firestore_database.dart';
import 'package:pedantic/pedantic.dart';
import 'package:starter_architecture_flutter_firebase/constants/BasicDateField.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class EditJobPage extends ConsumerStatefulWidget {
  const EditJobPage({Key? key, this.job}) : super(key: key);
  final projet? job;

  static Future<void> show(BuildContext context, {projet? job}) async {
    await Navigator.of(context, rootNavigator: true).pushNamed(
      AppRoutes.editJobPage,
      arguments: job,
    );
  }
  
  @override
  _EditJobPageState createState() => _EditJobPageState();
}

class _EditJobPageState extends ConsumerState<EditJobPage> {
  final _formKey = GlobalKey<FormState>();

  String? _name;
  DateTime? debut;
  DateTime? fin;
  late TextEditingController _debutController,_finController,_nameController;

  @override
  void initState() {
    super.initState();
    if (widget.job != null) {
      _name = widget.job?.name;
      debut = widget.job?.debut;
       fin = widget.job?.fin;
      _debutController = TextEditingController(text:debut.toString() );
      _finController = TextEditingController(text:fin.toString() );
      _nameController = TextEditingController(text:_name );
     
    }else{
       _nameController = TextEditingController(text:'' );
        _debutController = TextEditingController(text:DateTime.now().toString() );
      _finController = TextEditingController(text:DateTime.now().toString()  );
    }
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
    //  print(_debutController.text);
      // return;
      try {
        final database = ref.read<FirestoreDatabase?>(databaseProvider)!;
        final jobs = await database.jobsStream().first;
        final allLowerCaseNames =
            jobs.map((job) => job.name.toLowerCase()).toList();
        if (widget.job != null) {
          allLowerCaseNames.remove(widget.job!.name.toLowerCase());
        }
        if (allLowerCaseNames.contains(_name?.toLowerCase())) {
          unawaited(showAlertDialog(
            context: context,
            title: 'Name already used',
            content: 'Please choose a different job name',
            defaultActionText: 'OK',
          ));
        } else {
          final id = widget.job?.id ?? documentIdFromCurrentDate();
          final job =
              projet(id: id, name: _name ?? '', debut: debut! ,fin: fin!);
          await database.setJob(job);
          Navigator.of(context).pop();
        }
      } catch (e) {
        unawaited(showExceptionAlertDialog(
          context: context,
          title: 'Operation failed',
          exception: e,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(widget.job == null ? 'New Job' : 'Edit Job'),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Save',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: () => _submit(),
          ),
        ],
      ),
      body: _buildContents(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        controller: _nameController ,
        
        decoration: const InputDecoration(labelText: 'Job name'),
        keyboardAppearance: Brightness.light,
        
        validator: (value) =>
            (value ?? '').isNotEmpty ? null : 'Name can\'t be empty',
        
      ),
      Column(children: <Widget>[
      Text('date debut'),
      DateTimeField(
        format:DateFormat(),
         controller: _debutController,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
      },
     
      ),
    ]),
     Column(children: <Widget>[
      Text('date fin'),
      DateTimeField(
        controller: _finController,
        format: DateFormat(),
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
      },
    
      ),
    ]),
 
    ];
  }
}
