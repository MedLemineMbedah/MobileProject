import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:starter_architecture_flutter_firebase/app/home/job_entries/job_entries_page.dart';
 import 'package:starter_architecture_flutter_firebase/app/home/projet/edit_job_page.dart';
import 'package:starter_architecture_flutter_firebase/app/home/projet/job_list_tile.dart';
import 'package:starter_architecture_flutter_firebase/app/home/projet/list_items_builder.dart';
import 'package:starter_architecture_flutter_firebase/app/home/models/projet.dart';
import 'package:alert_dialogs/alert_dialogs.dart';
import 'package:starter_architecture_flutter_firebase/app/top_level_providers.dart';
import 'package:starter_architecture_flutter_firebase/constants/strings.dart';
import 'package:pedantic/pedantic.dart';
import 'package:starter_architecture_flutter_firebase/services/firestore_database.dart';

final jobsStreamProvider = StreamProvider.autoDispose<List<projet>>((ref) {
  final database = ref.watch(databaseProvider)!;
  return database.jobsStream();
});

// watch database
class ProjetPage extends ConsumerWidget {
  Future<void> _delete(BuildContext context, WidgetRef ref, projet job) async {
    try {
      final database = ref.read<FirestoreDatabase?>(databaseProvider)!;
      await database.deleteJob(job);
    } catch (e) {
      unawaited(showExceptionAlertDialog(
        context: context,
        title: 'Operation failed',
        exception: e,
      ));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.jobs),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => EditJobPage.show(context),
          ),
        ],
      ),
      body: _buildContents(context, ref),
    );
  }

  Widget _buildContents(BuildContext context, WidgetRef ref) {
    final jobsAsyncValue = ref.watch(jobsStreamProvider);
    return ListItemsBuilder<projet>(
      data: jobsAsyncValue,
      itemBuilder: (context, projet) => Dismissible(
        key: Key('job-${projet.id}'),
        background: Container(color: Colors.red),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) => _delete(context, ref, projet),
        child: JobListTileP(
          job: projet,
          onTap: () => EditJobPage.show(
              context,
              job: projet,
            ),
        ),
      ),
    );
  }
}
