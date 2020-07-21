import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solvecasejiit/Screens/pullUps.dart';
import 'package:solvecasejiit/classes/solutions.dart';

class DownloadSolutions extends StatefulWidget {
  @override
  _DownloadSolutionsState createState() => _DownloadSolutionsState();
}

class _DownloadSolutionsState extends State<DownloadSolutions> {
  List<String> subjects = [];
  List<Solutions> solutions = [];
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

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getSubjects('JIIT', '1', 'biotech');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFF33312E),
      body: subjects.length != 0
          ? ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: subjects.length,
              itemBuilder: (BuildContext, index) {
                var item = subjects[index];
                return InkWell(
                  onTap: () {
                    _scaffoldKey.currentState.showBottomSheet((context) {
                      return StatefulBuilder(
                          builder: (context, StateSetter state) {
                        return PullUp(
                            'JIIT',
                            '1',
                            'biotech',
                            'Maths',
                            MediaQuery.of(context).size.height,
                            MediaQuery.of(context).size.width);
                      });
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFF4A4A4A),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Container(
                                  child: Text(
                                    subjects[index],
                                    style: GoogleFonts.k2d(fontSize: 24),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(child: Text('Loading')),
    );
  }
}
