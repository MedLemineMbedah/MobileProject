// import 'package:flutter_test/flutter_test.dart';
// import 'package:starter_architecture_flutter_firebase/app/home/models/projet.dart';

// void main() {
//   group('fromMap', () {
//     test('null data', () {
//       expect(
//           () => projet.fromMap(null, 'abc'), throwsA(isInstanceOf<StateError>()));
//     });
//     test('job with all properties', () {
//       final job = projet.fromMap(const {
//         'name': 'Blogging',
//         'ratePerHour': 10,
//       }, 'abc');
//       expect(job, const projet(name: 'Blogging', debut: null,fin: null, id: 'abc'));
//     });

//     test('missing name', () {
//       expect(
//           () => projet.fromMap(const {
//                 'ratePerHour': 10,
//               }, 'abc'),
//           throwsA(isInstanceOf<StateError>()));
//     });
//   });

//   group('toMap', () {
//     test('valid name, ratePerHour', () {
//       const projet1 = projet(name: 'Blogging', ratePerHour: 10, id: 'abc');
//       expect(projet1.toMap(), {
//         'name': 'Blogging',
//         'ratePerHour': 10,
//       });
//     });
//   });

//   group('equality', () {
//     test('different properties, equality returns false', () {
//       const job1 = projet(name: 'Blogging', ratePerHour: 10, id: 'abc');
//       const job2 = projet(name: 'Blogging', ratePerHour: 5, id: 'abc');
//       expect(job1 == job2, false);
//     });
//     test('same properties, equality returns true', () {
//       const job1 = projet(name: 'Blogging', ratePerHour: 10, id: 'abc');
//       const job2 = projet(name: 'Blogging', ratePerHour: 10, id: 'abc');
//       expect(job1 == job2, true);
//     });
//   });
// }
