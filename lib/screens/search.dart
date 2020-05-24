import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_safety/componants/mediaQuery.dart';
import 'package:personal_safety/screens/home.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class Search extends StatefulWidget {
  Search({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with TickerProviderStateMixin {
  SharedPreferences prefs;

  int circle1Radius = 110, circle2Radius = 130, circle3Radius = 150;

  AnimationController _circle1FadeController, _circle1SizeController;
  Animation<double> _radiusAnimation, _fadeAnimation;

  CancelAlertDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: Color(0xffFF2B56),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Cancel Request",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                children: <Widget>[
                  Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "A facility operator was about to accept your request, are sure you want to cancel the pending request?",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w300),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                      height: 50.0,
                      width: 200,
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30),
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text(
                          "cancel",
                          style:
                              TextStyle(color: Color(0xffFF2B56), fontSize: 18),
                        ),
                      ))
                ],
              ),
            ],
          )),
    );
  }

  alertDialog() {
    return Container(
      height: 200,
      width: displayWidth(context),
      child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: GetColorBasedOnState(),
          content: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        prefs == null
                            ? "Requesting"
                            : prefs.getString("activerequeststate"),
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                  Container(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      iconSize: 20,
                      color: Colors.white,
                      icon: Icon(Icons.close),
                      onPressed: () {
                        //Navigator.pop(context);
                        CancelAlertDialog();
                      },
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Find a near facility to help you out.",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w300),
                      )),
                ],
              ),
            ],
          )),
    );
  }

  @override
  void initState() {
    super.initState();

    SetPrefs();

    const Secs = const Duration(seconds: 2);
    new Timer.periodic(Secs, (Timer t) => DoSearchAnimation());
  }

  void SetPrefs() async {
    if (prefs == null) prefs = await SharedPreferences.getInstance();
  }

  double beginValue = 100,
      endValue = 150,
      beginFade = 1,
      endFade = 0.2,
      tmpValue,
      tmpValue2;

  Color GetColorBasedOnState() {
    SetPrefs();

    Color toReturn = Color.fromRGBO(255, 43, 86, 1.0);

    if (prefs == null)
      toReturn = Color.fromRGBO(255, 43, 86, 1.0); //Reddish
    else {
      String state = prefs.getString("activerequeststate");

      print("Switching on state " + state.toString());

      switch (state) {
        case "Searching":
          toReturn = Color.fromRGBO(255, 43, 86, 1.0); //Reddish

          break;

        case "Pending":
          toReturn = Color.fromRGBO(255, 174, 0, 1.0); //Orange

          break;

        case "Accepted":
          toReturn = Color.fromRGBO(30, 204, 18, 1.0); //Green

          break;
      }
    }

    return toReturn;
  }

  Color requestColor = Color.fromRGBO(255, 43, 86, 1.0);

  void DoSearchAnimation() async {
    _circle1FadeController = new AnimationController(
        duration: new Duration(milliseconds: 2000), vsync: this);

    _circle1SizeController = new AnimationController(
        duration: new Duration(milliseconds: 2000), vsync: this);

    _radiusAnimation = new Tween<double>(begin: beginValue, end: endValue)
        .animate(new CurvedAnimation(
            curve: Curves.easeInSine, parent: _circle1SizeController));

    _fadeAnimation = new Tween<double>(begin: beginFade, end: endFade).animate(
        new CurvedAnimation(
            curve: Curves.easeInSine, parent: _circle1FadeController));

    _circle1SizeController.addListener(() {
      this.setState(() {});
    });

    _circle1FadeController.addListener(() {
      this.setState(() {});
    });

    _circle1FadeController.forward();
    _circle1SizeController.forward();

    tmpValue = beginValue;
    beginValue = endValue;
    endValue = tmpValue;

    tmpValue2 = beginFade;
    beginFade = endFade;
    endFade = tmpValue2;
  }

  @override
  int _cIndex = 0;

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage("assets/images/SOS_Background.png"),
            fit: BoxFit.fill)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: <Widget>[
                Center(
                  child: Container(
                    child: CircleAvatar(
                      child: SvgPicture.asset(
                        "assets/images/pin.svg",
                        color: Colors.white,
                        width: 100,
                        height: 150,
                      ),
                      radius: _radiusAnimation == null
                          ? beginValue
                          : _radiusAnimation.value,
                      backgroundColor: GetColorBasedOnState().withOpacity(
                          _fadeAnimation == null ? 1 : _fadeAnimation.value),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 580),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: alertDialog(),
                  ),
                ),
              ],
            ),
//
        )
      ),
    );
  }
}
