import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aplicacion_petbia/data/model/record.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

class FirebaseController extends GetxController {
  var _records = <Record>[].obs;
  final CollectionReference baby =
      FirebaseFirestore.instance.collection('imagePost');
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('ImagePost').snapshots();
  late StreamSubscription<Object?> streamSubscription;

  suscribeUpdates() async {
    logInfo('suscribeLocationUpdates');
    streamSubscription = _usersStream.listen((event) {
      logInfo('Got new item from fireStore');
      _records.clear();
      event.docs.forEach((element) {
        _records.add(Record.fromSnapshot(element));
      });
      print('Got ${_records.length}');
    });
  }

  unsuscribeUpdates() {
    streamSubscription.cancel();
  }

  List<Record> get entries => _records;

  addEntry(name) {
    baby
        .add({'name': name, 'votes': 0})
        .then((value) => print("Baby added"))
        .catchError((onError) => print("Failed to add baby $onError"));
  }

  updateEntry(Record record) {
    record.reference.update({'votes': record.votes + 1});
  }

  deleteEntry(Record record) {
    record.reference.delete();
  }
}
