import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DownloadSolutions extends StatefulWidget {
  @override
  _DownloadSolutionsState createState() => _DownloadSolutionsState();
}

class _DownloadSolutionsState extends State<DownloadSolutions> {
  List<String> subjects = [];
  getSubjects(college, sem, branch) {
    DatabaseReference subRef = FirebaseDatabase.instance
        .reference()
        .child(college)
        .child('Sem$sem')
        .child(branch);
    subRef.once().then((DataSnapshot snap) {
      subjects.clear();
      var KEYS = snap.value.keys;
      var DATA = snap.value;
      for (var key in KEYS) {
        subjects.add(DATA[key]["SubName"]);
      }
      setState(() {
        print(subjects.length);
      });
    });
  }

  getSolutions(college, sem, branch) {
    getSubjects(college, sem, branch);
    DatabaseReference subRef = FirebaseDatabase.instance
        .reference()
        .child(college)
        .child('Sem$sem')
        .child(branch);
    subRef.once().then((DataSnapshot snap) {
      subjects.clear();
      var KEYS = snap.value.keys;
      var DATA = snap.value;
      for (var key in KEYS) {
        subjects.add(DATA[key]["SubName"]);
      }
      setState(() {
        print(subjects.length);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getSolutions('JIIT', '1', 'biotech');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF33312E),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[],
        ),
      ),
    );
  }
}
