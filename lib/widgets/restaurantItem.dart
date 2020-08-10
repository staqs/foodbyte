import 'package:flutter/material.dart';
import 'package:flutter_foodybite/core/models/category.dart';
import 'package:flutter_foodybite/core/models/restaurant.dart';
import 'package:flutter_foodybite/screens/categories_screen.dart';
import 'package:flutter_foodybite/screens/restaurantsscreen.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurant cat;
  const RestaurantItem({Key key, this.cat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => RestaurantScreen(cat))),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Stack(
            children: <Widget>[
              Image.asset(
                cat.image,
                height: MediaQuery.of(context).size.height / 6,
                width: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    // Add one stop for each color. Stops should increase from 0 to 1
                    stops: [0.2, 0.7],
                    colors: [
                      Color.fromARGB(100, 0, 0, 0),
                      Color.fromARGB(100, 0, 0, 0),
                    ],
                    // stops: [0.0, 0.1],
                  ),
                ),
                height: MediaQuery.of(context).size.height / 6,
                width: MediaQuery.of(context).size.height,
              ),
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height / 6,
                  width: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.all(1),
                  constraints: BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  child: Center(
                    child: Text(
                      cat.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
