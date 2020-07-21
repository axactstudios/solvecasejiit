import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:solvecasejiit/classes/solutions.dart';

class PullUp extends StatefulWidget {
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
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(
                      color: Theme.MyColors.themeColor,
                      fontFamily: 'nunito',
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    size: 40,
                  ),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          child: Image.network(
                            imageUrl,
                            alignment: Alignment.center,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Presented by',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'nunito',
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        imageBy,
                        style: TextStyle(
                            color: Theme.MyColors.themeColor,
                            fontFamily: 'nunito',
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Description-',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'nunito',
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        description,
                        style: TextStyle(
                            color: Color(0xFF808080),
                            fontFamily: 'nunito',
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
