import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class projet extends Equatable {
  const projet({required this.id, required this.name, required this.debut, required this.fin});
  final String id;
  final String name;
  final DateTime debut;
  final DateTime fin;
  

  @override
  List<Object> get props => [id, name, debut,fin];

  @override
  bool get stringify => true;

  factory projet.fromMap(Map<String, dynamic>? data, String documentId) {
    if (data == null) {
      throw StateError('missing data for jobId: $documentId');
    }
    final name = data['name'] as String?;
    if (name == null) {
      throw StateError('missing name for jobId: $documentId');
    }
    final debut = data['debut'] as DateTime?;
     if (debut == null) {
      throw StateError('missing date debut for jobId: $documentId');
    }
   
    final fin = data['fin'] as DateTime?;
     if (fin == null) {
      throw StateError('missing date fin for jobId: $documentId');
    }
   

    return projet(id: documentId, name: name, debut: debut,fin: fin);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'debut': debut,
      'fin': debut,
    };
  }
}
