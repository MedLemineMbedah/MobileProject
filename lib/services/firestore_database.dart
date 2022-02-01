import 'dart:async';

import 'package:firestore_service/firestore_service.dart';
import 'package:starter_architecture_flutter_firebase/app/home/models/projet.dart';
import 'package:starter_architecture_flutter_firebase/services/firestore_path.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase {
  FirestoreDatabase({required this.uid});
  final String uid;

  final _service = FirestoreService.instance;

  Future<void> setJob(projet job) => _service.setData(
        path: FirestorePath.job(uid, job.id),
        data: job.toMap(),
      );

  Future<void> deleteJob(projet job) async {
    // delete where entry.jobId == job.jobId
    await _service.deleteData(path: FirestorePath.job(uid, job.id));
  }

  // Stream<List<pro>> jobStream({required String jobId}) => _service.documentStream(
  //       path: FirestorePath.job(uid, jobId),
  //       builder: (data, documentId) => projet.fromMap(data, documentId),
  //     );

Stream<List<projet>> jobsStream() => _service.collectionStream(
        path: FirestorePath.jobs(uid),
        builder: (data, documentId) => projet.fromMap(data, documentId),
      );

  // Stream<List<projet>> jobsStream() => _service.collectionStream(
  //       path: FirestorePath.jobs(uid),
  //       builder: (data, documentId) => projet.fromMap(data, documentId),
  //     );

}
