import 'package:flutter/material.dart';
import 'package:flutter_foodybite/core/viewmodels/authviewmodel.dart';
import 'package:flutter_foodybite/widgets/profile.dart';
import 'package:stacked/stacked.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthViewModel>.reactive(
      viewModelBuilder: () => AuthViewModel(),
      // onModelReady: () =>  ,
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
            body: Profile(
          img: "assets/food11.jpeg",
          username: model.getCurrentUser.username,
          email: model.getCurrentUser.email,
        )),
      ),
    );
  }
}
