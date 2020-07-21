import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsInput extends StatefulWidget {
  @override
  _DetailsInputState createState() => _DetailsInputState();
}

class _DetailsInputState extends State<DetailsInput> {
  List<String> colleges = ['JIIT', 'Jaypee Sector 128'];
  List<String> semester = ['1', '2', '3', '4'];
  List<String> stream = ['CSE', 'ECE', 'Biotech'];
  String dropdownValue = 'JIIT';
  String dropdownValue1 = '1';
  String dropdownValue2 = 'CSE';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4A4A4A),
      body: SafeArea(
        child: Container(
          color: Color(0xFF4A4A4A),
          padding: EdgeInsets.all(20),
          child: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Name',
                      border: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      enabledBorder: InputBorder.none),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Enrollment Number',
                      border: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      enabledBorder: InputBorder.none),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField(
                  iconEnabledColor: Color(0xFFF99E16),
                  value: dropdownValue,
                  icon: Icon(Icons.arrow_downward),
                  decoration: InputDecoration(
                    focusColor: Color(0xFFF99E16),
                    labelStyle:
                        TextStyle(color: Color(0xFFF99E16), fontSize: 17),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFF99E16), width: 3.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  items: colleges.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Select type';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField(
                  iconEnabledColor: Color(0xFFF99E16),
                  value: dropdownValue1,
                  icon: Icon(Icons.arrow_downward),
                  decoration: InputDecoration(
                    focusColor: Colors.black,
                    labelStyle: TextStyle(color: Colors.black, fontSize: 17),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFF99E16), width: 3.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  items: semester.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue1 = newValue;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Select type';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField(
                  iconEnabledColor: Color(0xFFF99E16),
                  value: dropdownValue2,
                  icon: Icon(Icons.arrow_downward),
                  decoration: InputDecoration(
                    focusColor: Colors.black,
                    labelStyle: TextStyle(color: Colors.black, fontSize: 17),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFF99E16), width: 3.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  items: stream.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue2 = newValue;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Select type';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    print('skdhgsds');
                    await prefs.setString(
                        'college', dropdownValue.toLowerCase());
                    await prefs.setString(
                        'semester', dropdownValue1.toLowerCase());
                    await prefs.setString(
                        'stream', dropdownValue2.toLowerCase());
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Color(0xFFF99E16))),
                    child: Text('Enter'),
                  ),
                )
                // Add TextFormFields and RaisedButton here.
              ])),
        ),
      ),
    );
  }
}
