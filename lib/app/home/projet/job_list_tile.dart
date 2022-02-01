import 'package:flutter/material.dart';
import 'package:starter_architecture_flutter_firebase/app/home/models/projet.dart';

class JobListTileP extends StatelessWidget {
  const JobListTileP({Key? key, required this.job, this.onTap,})
      : super(key: key);
  final projet job;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(job.name),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
