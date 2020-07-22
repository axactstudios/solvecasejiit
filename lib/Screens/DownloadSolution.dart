import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
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
          ? Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Subjects',
                    style: GoogleFonts.k2d(
                        color: Color(0xFFDAD4EF),
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 2, crossAxisCount: 2),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: subjects.length,
                      itemBuilder: (BuildContext, index) {
                        var item = subjects[index];
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: InkWell(
                            onTap: () {
                              _scaffoldKey.currentState
                                  .showBottomSheet((context) {
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
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black54,
                                        offset: Offset.zero,
                                        blurRadius: 10,
                                        spreadRadius: 5)
                                  ],
                                  color: Color(0xFFF99E16).withOpacity(0.9),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Text(
                                subjects[index],
                                textAlign: TextAlign.center,
                                style: GoogleFonts.k2d(fontSize: 24),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: GFLoader(
              type: GFLoaderType.ios,
            )),
    );
  }
}
