import 'package:flutter/material.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/constant.dart';

class SignUpSuccessful extends StatefulWidget {
  @override
  _SignUpSuccessfulState createState() => _SignUpSuccessfulState();
}

class _SignUpSuccessfulState extends State<SignUpSuccessful> {
  bool value = false;
  var _chronicDisease = [
    'Chronic Disease',
    'Chronic kidney disease',
    'Diabetes',
    'Cancer',
    'Heart Condition',
    'Virus C',
    'Alzheimer\'s'
  ];

  Map<String, bool> values = {
    'Chronic Disease': false,
    'Chronic kidney disease': false,
    'Diabetes': false,
    'Cancer': false,
    'Heart Condition': false,
    'Virus C': false,
    'Alzheimer\'s': false,
  };

  var _currentItemSelected = 'Chronic Disease';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 100.0, left: 20),
              child: Text(
                "Complete your profile",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: primaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 150, left: 120),
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    color: grey, borderRadius: BorderRadius.circular(150)),
                child: CircleAvatar(
                  radius: 50,
                  child: IconButton(
                      icon: Icon(Icons.camera_enhance),
                      iconSize: 70,
                      color: Colors.white,
                      onPressed: null),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 330.0, left: 20, right: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      child: TextField(
                        decoration: InputDecoration(
                          errorBorder: InputBorder.none,
                          border: InputBorder.none,
//                        icon: Icon(
//                          Icons.location_on,
//                          color: grey,
//                        ),
                          labelText: "   Address",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      child: TextFormField(
                        decoration: InputDecoration(
                          errorBorder: InputBorder.none,
                          border: InputBorder.none,
//                        icon: Icon(
//                          Icons.healing,
//                          color: secondary,
//                        ),

                          labelText: "   Blood Type",
                        ),
                      ),
                    ),
//                  SizedBox(height: 10,),
//                  Container(
//                    height: 60,
//                    alignment: Alignment.centerLeft,
//                    decoration: kBoxDecorationStyle,
//
//                    child: DropdownButtonFormField<String>(
//                      decoration: InputDecoration.collapsed(hintText: ''),
//                      items: _chronicDisease.map((String dropDownStringItem) {
//
//                        return DropdownMenuItem<String>(
//                          value: dropDownStringItem,
//                          child: Text(dropDownStringItem),
//                        );
//                      }).toList(),
//                      onChanged: (String newValueSelected){
//
//                        setState(() {
//                          this._currentItemSelected=newValueSelected;
//                        });
//                      },
//                      value: _currentItemSelected,
//                    ),
//                  ),
                    SizedBox(
                      height: 10,
                    ),

                    Container(
                      decoration: kBoxDecorationStyle,
                      child: CheckboxListTile(
                        value: value,
                        onChanged: onChange,
                        title: Text("Chronic Disease"),
                      ),
                    ),

//                    Container(
//                      alignment: Alignment.centerLeft,
//                      decoration: kBoxDecorationStyle,
//                      child: TextFormField(
//                        decoration: InputDecoration(
//                            border: OutlineInputBorder(
//                                borderRadius: BorderRadius.circular(15)),
//
////                        icon: Icon(
////                          Icons.report_problem,
////                          color: secondary,
////                        ),
//                            labelText: "Chronic Disease",
//                            labelStyle: kLabelStyle),
//                      ),
//                    ),

                    SizedBox(
                      height: 10,
                    ),

                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: kBoxDecorationStyle,
                      child: TextFormField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.contact_phone,
                            color: grey,
                          ),
                          errorBorder: InputBorder.none,
                          border: InputBorder.none,

//                        icon: Icon(
//                          Icons.contact_phone,
//                          color: grey,
//                        ),
                          labelText: "   Edit Emergency Contacts",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 30, left: 70.0, bottom: 10, right: 70),
                      child: Container(
                        height: 50.0,
                        width: 300,
                        child: Material(
                          borderRadius: BorderRadius.circular(30.0),
                          shadowColor: secondary,
                          color: primaryColor,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: () {
                              // Validate returns true if the form is valid, otherwise false.
                              if (_formKey.currentState.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.

                              }
                            },
                            child: Center(
                              child: Text(
                                'Continue',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onChange(bool newVal) {
    setState(() {
      value = newVal;
    });
    if (newVal == true) {
      ChoronicDisease(true);
    }
  }

  Widget ChoronicDisease(bool val) {
    ListView(
      children: values.keys.map((String key) {
        return CheckboxListTile(
          title: Text("ChoronicDisease"),
          value: values[key],
          onChanged: (bool value) {
            setState(() {
              values[key] = value;
            });
          },
        );
      }).toList(),
    );
  }
}
