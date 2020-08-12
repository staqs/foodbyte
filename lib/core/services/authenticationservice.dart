import 'dart:convert';

import 'package:flutter_foodybite/core/models/authstate.dart';
import 'package:flutter_foodybite/core/models/food.dart';
import 'package:flutter_foodybite/core/models/order.dart';
import 'package:flutter_foodybite/core/models/users.dart';
import 'package:flutter_foodybite/core/services/graphql_client_api.dart';
import 'package:flutter_foodybite/core/services/service_locator.dart';
import 'package:flutter_foodybite/core/utils/mutations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:observable_ish/value/value.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class AuthService with ReactiveServiceMixin {
  GraphQLClient cl = GraphQLClientAPI.clientToQuery();
  List<User> _users = [];

  // User currentUser = null;

  RxValue<User> currentUser = RxValue<User>(initial: null);

  User get getCurrentUser => currentUser.value;

  AuthService() {
    print("Auth Service started");
  }

  Future<AuthState> login(String username, String password) async {
    print("User Logging In");

    QueryResult dl = await cl.query(
      QueryOptions(document: Mutations.login, variables: {
        "email": username,
        "password": password,
      }),
    );

    print(dl.data as Map);

    if (!dl.hasException) {
      print("has no error");

      for (var item in dl.data['allCustomers']) {
        print(item.data);
        String id = item.data["id"];
        String username = item.data["name"];
        String email = item.data["email"];
        String pass = item.data["password"];

        if (email == username && password == pass) {
          // Save User Credentials
          User user = new User(
            id: id,
            username: username,
            password: pass,
            email: email,
          );

          currentUser.value = user;
          saveUser(user);
          // Log User In
          return AuthState.EXISTING;
        }
      }

      // Create New User and Send State

      // CallSignUp
      return signup(username, password);
    } else {
      print(dl.exception);
      print("User Credentials not Found");
    }

    return AuthState.ERROR;
  }

  Future<AuthState> signup(String email, String password) async {
    print("User Signing Up");

    QueryResult dl = await cl.query(
      QueryOptions(document: Mutations.signup, variables: {
        "username": email,
        "email": email,
        "password": password,
      }),
    );

    // print(dl.data as Map);

    if (!dl.hasException) {
      print("has no error");

      //  dl.data['allCustomers'])
      // print(item.data);

      print(dl.data['createCustomer'].data);
      String id = dl.data['createCustomer'].data["id"];
      String username = dl.data['createCustomer'].data["name"];
      String email = dl.data['createCustomer'].data["email"];
      String pass = dl.data['createCustomer'].data["password"];

      User user =
          new User(id: id, username: username, email: email, password: pass);
      saveUser(user);
      currentUser.value = user;

      return AuthState.NEW;
      // }
      // print(dl.data.toString());
      // for(int i=0; i<dl.data["allCustomers"] )

      // print("User Details");

      return AuthState.ERROR;
    } else {
      print(dl.exception);

      print("User Credentials not Found");
    }

    return AuthState.ERROR;
  }

  Future<String> getSaved(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("username", user.username);
    prefs.setString("email", user.email);
    prefs.setString("password", user.password);
  }

  Future<AuthState> isLoggedIn() async {
    // String username = await getSaved("username");
    String password = await getSaved("password");
    String email = await getSaved("email");

    if (password == null && email == null) {
      print("User not logged in");

      return AuthState.ERROR;
    }

    return await login(email, password);
  }
}
