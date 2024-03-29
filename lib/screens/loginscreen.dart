import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_foodybite/core/models/authstate.dart';
import 'package:flutter_foodybite/core/viewmodels/authviewmodel.dart';
import 'package:flutter_foodybite/screens/main_screen.dart';
import 'package:flutter_foodybite/screens/signup.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:rest_app/services/auth_services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

class SignIn extends StatefulWidget {
  final Function toogleView;
  SignIn({this.toogleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = "", password = "";

  /// For Fingerprint & FaceId Local Auth
  TextEditingController email_controller;
  TextEditingController pass_controller;
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  String _authorizedOrNot = "Not Authorized";
  List<BiometricType> _availableBiometricTypes = List<BiometricType>();
  bool _canCheckBiometric = false;

  bool _loading = false;
  String error;

  @override
  void initState() {
    email_controller = TextEditingController();
    email_controller.addListener(() {
      setState(() {});
    });

    pass_controller = TextEditingController();
    pass_controller.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    email_controller.dispose();
    pass_controller.dispose();
    super.dispose();
  }

  Future<void> checkBiometrics() async {
    bool canCheckBiometric = false;
    try {
      canCheckBiometric = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
  }

  Future<void> _getListOfBiometricTypes() async {
    List<BiometricType> listofBiometrics;
    try {
      listofBiometrics = await _localAuthentication.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _availableBiometricTypes = listofBiometrics;
    });
  }

  Future<void> _authorizeNow() async {
    bool isAuthorized = false;
    try {
      isAuthorized = await _localAuthentication.authenticateWithBiometrics(
        localizedReason: "Please authenticate to complete your transaction",
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      if (isAuthorized) {
        _authorizedOrNot = "Authorized";
      } else {
        _authorizedOrNot = "Not Authorized";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthViewModel>.reactive(
        viewModelBuilder: () => AuthViewModel(),
        // onModelReady: () =>  ,
        builder: (context, model, child) {
          //todo Try Login remove from here, Auto Sign in in the Splash Screen Page
          // tryLogin(context, model);

          return GestureDetector(
            child: Scaffold(
                body: _loading
                    ? Container(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      )
                    : SingleChildScrollView(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                height: double.infinity,
                                child: Image.asset(
                                  "assets/background.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Center(
                                        child: Image.asset(
                                      "assets/logo.png",
                                      height: 30,
                                      width: 30,
                                      alignment: Alignment.center,
                                    )),
                                    SizedBox(
                                      height: 13,
                                    ),
                                    Text(
                                      "FoodyBite",
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              fontSize: 27,
                                              color: Colors.white,
                                              letterSpacing: 1)),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      width: 180,
                                      child: Text(
                                        "UENR Campus",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              color: Colors.white54,
                                              letterSpacing: 0.6,
                                              fontSize: 11),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Text(
                                      "Join",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          letterSpacing: 1,
                                          fontSize: 23,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "You'r Delicios meal is Waiting 😋",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                              color: Colors.white70,
                                              letterSpacing: 1,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 45),
                                      child: Column(
                                        children: <Widget>[
                                          TextFormField(
                                            controller: email_controller,
                                            style:
                                                TextStyle(color: Colors.white),
                                            validator: (val) => val.isEmpty
                                                ? "Enter Valid Email"
                                                : null,
                                            decoration: InputDecoration(
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white)),
                                              hintText: "Email",
                                              hintStyle: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 15),
                                            ),
                                            onSaved: (val) {
                                              email = val;
                                            },
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          TextFormField(
                                            controller: pass_controller,
                                            style:
                                                TextStyle(color: Colors.white),
                                            obscureText: true,
                                            validator: (val) => val.isEmpty
                                                ? "Enter Password"
                                                : null,
                                            decoration: InputDecoration(
                                              enabled: true,
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white)),
                                              hintText: "Password",
                                              hintStyle: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 15),
                                            ),
                                            onSaved: (val) {
                                              password = val;
                                            },
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              // print(
                                              //     "${email_controller.text} and ${pass_controller.text}");
                                              AuthState auth =
                                                  await model.login(
                                                      email_controller.text,
                                                      pass_controller.text);

                                              if (auth == AuthState.EXISTING ||
                                                  auth == AuthState.NEW) {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            MainScreen()));
                                              } else if (auth ==
                                                  AuthState.ERROR) {
                                                print(
                                                    "Error Credentials Doesnt Match");
                                              }
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: double.infinity,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 0),
                                              height: 50,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Text(
                                                "SUBMIT",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        letterSpacing: 1)),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "OR",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white60),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                        onTap: () async {
                                          checkBiometrics();
                                          if (_canCheckBiometric) {
                                            await _authorizeNow();
                                            if (_authorizedOrNot ==
                                                "Authorized") {
                                              // _authService.signInAnom();

                                            } else {
                                              cantCheckBiometricsDialog(
                                                  context);
                                            }
                                          } else {
                                            cantCheckBiometricsDialog(context);
                                          }
                                        },
                                        child: Image.asset(
                                          "assets/fingerprint.png",
                                          height: 36,
                                          width: 36,
                                        )),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // Navigator.of(context).push(
                                        //     MaterialPageRoute(
                                        //         builder: (BuildContext context) =>
                                        //             SignUp()));
                                      },
                                      child: Text(
                                        "Don't have an account?",
                                        style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 13,
                                                decoration:
                                                    TextDecoration.underline,
                                                letterSpacing: 0.5)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
          );
        });
  }
}

Future<void> tryLogin(BuildContext context, AuthViewModel model) async {
  AuthState auth = await model.checkLogin();
  if (auth == AuthState.EXISTING) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => MainScreen()));
  }
}

Future<void> cantCheckBiometricsDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('No Biometrics Found'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Can not login with Biometrics'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
