import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solvecasejiit/Screens/DetailsInput.dart';
import 'package:solvecasejiit/Screens/DownloadSolution.dart';
import 'package:solvecasejiit/Screens/Others.dart';
import 'package:solvecasejiit/Screens/StudyMaterial.dart';
import 'package:solvecasejiit/Screens/VideoLectures.dart';

void main() {
  runApp(MyApp());
}

String semester = '', college = '', stream = '';
getDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  college = prefs.getString('college');
  semester = prefs.getString('semester');
  stream = prefs.getString('stream');
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(college);
    return MaterialApp(
      home: college.isEmpty ? DetailsInput() : Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget _child;

  @override
  void initState() {
    _child = DownloadSolutions();
    super.initState();
  }

  @override
  Widget build(context) {
    // Build a simple container that switches content based of off the selected navigation item
    return MaterialApp(
      home: Container(
        color: Color(0xFF4A4A4A),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Color(0xFF33312E),
            extendBody: true,
            body: _child,
            bottomNavigationBar: FluidNavBar(
              icons: [
                FluidNavBarIcon(
                    iconPath: "assets/arrow.svg",
                    backgroundColor: Color(0xFF4A4A4A),
                    extras: {"label": "home"}),
//                FluidNavBarIcon(
//                    iconPath: "assets/arrow.svg",
//                    backgroundColor: Color(0xFF4A4A4A),
//                    extras: {"label": "bookmark"}),
//                FluidNavBarIcon(
//                    iconPath: "assets/arrow.svg",
//                    backgroundColor: Color(0xFF4A4A4A),
//                    extras: {"label": "partner"}),
                FluidNavBarIcon(
                    iconPath: "assets/more.svg",
                    backgroundColor: Color(0xFF4A4A4A),
                    extras: {"label": "conference"}),
              ],
              onChange: _handleNavigationChange,
              style: FluidNavBarStyle(
                  barBackgroundColor: Color(0xFF4A4A4A),
                  iconUnselectedForegroundColor: Color(0xFFF99E16),
                  iconSelectedForegroundColor: Color(0xFFF99E16)),
              scaleFactor: 3,
              itemBuilder: (icon, item) => Semantics(
                label: icon.extras["label"],
                child: item,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = DownloadSolutions();
          break;
//        case 1:
//          _child = VideoLectures();
//          break;
//        case 2:
//          _child = StudyMaterial();
          break;
        case 4:
          _child = Others();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 500),
        child: _child,
      );
    });
  }
}
