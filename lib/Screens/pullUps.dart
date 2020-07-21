import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solvecasejiit/classes/solutions.dart';
import 'package:url_launcher/url_launcher.dart';

class PullUp extends StatefulWidget {
  String college, sem, branch, sub;
  double height, width;
  PullUp(
      this.college, this.sem, this.branch, this.sub, this.height, this.width);
  @override
  _PullUpState createState() => _PullUpState();
}

class _PullUpState extends State<PullUp> {
  List<Solutions> solutions = [];
  getSolutions(college, sem, branch, sub) {
    DatabaseReference subRef = FirebaseDatabase.instance
        .reference()
        .child(college)
        .child('Sem$sem')
        .child(branch)
        .child(sub);
    subRef.once().then((DataSnapshot snap) {
      solutions.clear();
      var KEYS = snap.value.keys;
      var DATA = snap.value;
      for (var key in KEYS) {
        if (key != 'SubName') {
          Solutions a = Solutions(DATA[key]["Name"], DATA[key]["Url"]);
          solutions.add(a);
        }
      }
      setState(() {
        print(solutions.length);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getSolutions(widget.college, widget.sem, widget.branch, widget.sub);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 30.0, // soften the shadow
              spreadRadius: 3.0, //extend the shadow
              offset: Offset(
                0.0, // Move to right 10  horizontally
                0.0, // Move to bottom 10 Vertically
              ),
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: EdgeInsets.fromLTRB(20, 20, 20, 40),
      padding: EdgeInsets.all(15),
      height: widget.height,
      width: widget.width,
      child: solutions.length != 0
          ? ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: solutions.length,
              itemBuilder: (BuildContext, index) {
                return InkWell(
                  onTap: () {
                    _launchURL(solutions[index].url);
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
                                    solutions[index].name,
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

  _launchURL(url1) async {
    var url = url1;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
