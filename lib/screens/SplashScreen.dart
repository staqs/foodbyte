import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodybite/core/models/authstate.dart';
import 'package:flutter_foodybite/core/utils/colors.dart';
import 'package:flutter_foodybite/core/viewmodels/authviewmodel.dart';
import 'package:flutter_foodybite/screens/home.dart';
import 'package:flutter_foodybite/screens/loginscreen.dart';
import 'package:flutter_foodybite/screens/main_screen.dart';
import 'package:flutter_foodybite/widgets/delayed_animation.dart';
import 'package:stacked/stacked.dart';

class SplashScreen extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  double _scale;
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    _scale = 1 - _controller.value;
    return ViewModelBuilder<AuthViewModel>.reactive(
        viewModelBuilder: () => AuthViewModel(),
        // onModelReady: () =>  ,
        builder: (context, model, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
                backgroundColor: MyColors.github,
                body: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        AvatarGlow(
                          endRadius: 90,
                          duration: Duration(seconds: 2),
                          glowColor: Colors.white24,
                          repeat: true,
                          repeatPauseDuration: Duration(seconds: 2),
                          startDelay: Duration(seconds: 1),
                          child: Material(
                              elevation: 8.0,
                              shape: CircleBorder(),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[100],
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(45)),
                                  child: !model.isBusy
                                      ? model.getCurrentUser == null
                                          ? Image.asset(
                                              "assets/food11.jpeg",
                                              height: 90,
                                              width: 90,
                                              fit: BoxFit.cover,
                                            )
                                          : CircleAvatar(
                                              radius: 48,
                                              // backgroundColor:
                                              //     Colors.grey.shade800,
                                              child: Text(
                                                "${model.getCurrentUser.username.substring(0, 1).toUpperCase()}",
                                                style: TextStyle(fontSize: 50),
                                              ),
                                            )
                                      : Image.asset(
                                          "assets/food11.jpeg",
                                          height: 90,
                                          width: 90,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                radius: 50.0,
                              )),
                        ),
                        DelayedAnimation(
                          child: Text(
                            !model.isBusy
                                ? model.getCurrentUser == null
                                    ? "Hi There"
                                    : "Hi ${model.getCurrentUser.username}"
                                : "Hi Buddy",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 35.0,
                                color: color),
                          ),
                          delay: delayedAmount + 1000,
                        ),
                        DelayedAnimation(
                          child: Text(
                            "I'm FoodyBite",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 35.0,
                                color: color),
                          ),
                          delay: delayedAmount + 2000,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        DelayedAnimation(
                          child: Text(
                            "Your New Personal",
                            style: TextStyle(fontSize: 20.0, color: color),
                          ),
                          delay: delayedAmount + 3000,
                        ),
                        DelayedAnimation(
                          child: Text(
                            "Food Odering App",
                            style: TextStyle(fontSize: 20.0, color: color),
                          ),
                          delay: delayedAmount + 3000,
                        ),
                        SizedBox(
                          height: 100.0,
                        ),
                        DelayedAnimation(
                          child: GestureDetector(
                            onTapDown: _onTapDown,
                            onTapUp: _onTapUp,
                            child: Transform.scale(
                              scale: _scale,
                              child: _animatedButtonUI(model),
                            ),
                          ),
                          delay: delayedAmount + 4000,
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        DelayedAnimation(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) => SignIn()));
                            },
                            child: Text(
                              "Use A different Account".toUpperCase(),
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: color),
                            ),
                          ),
                          delay: delayedAmount + 5000,
                        ),
                      ],
                    ),
                  ),
                )
                //  Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     Text('Tap on the Below Button',style: TextStyle(color: Colors.grey[400],fontSize: 20.0),),
                //     SizedBox(
                //       height: 20.0,
                //     ),
                //      Center(

                //   ),
                //   ],

                // ),
                ),
          );
        });
  }

  Widget _animatedButtonUI(AuthViewModel model) {
    return InkWell(
      onTap: () async {
        AuthState auth = await model.checkLogin();
        if (auth == AuthState.EXISTING) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => MainScreen()));
        } else {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) => SignIn()));
        }
      },
      child: Container(
        height: 60,
        width: 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            'Hi Foodybite',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8185E2),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
