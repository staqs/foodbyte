// * Abstract Class that allows Other Implementation services to read data easily.
import 'package:flutter/material.dart';

///  Extended Classes will have to implement these methods
///  * Visit the below Link for more
///  <https://medium.com/flutter-community/creating-services-to-do-the-work-in-your-flutter-app-93d6c4aa7697/>.

abstract class NewsService {
  List getAllNews();
  List getAllJokes();
  List getAllExecutives();
  List getAllHealthTips();
  List getAllArticles();
  List getAllSpokenWords();
  List getAllSecurityTips();
  List getAllHallOfFames();
  bool getState();
  
  Future<List> getCurrentNews();
  Future<List> getNews(String category);
  Future<void> updateNews();
  Future<void> upDateAll();
  Future<void> updateArticles();
  Future<void> updateJokes();
  Future<void> getExecutives();
  Future<void> updateSpokenWords();
  Future<void> updateHealthTips();
  Future<void> updateWallOfFame();
  Future<void> updateSecurityTips();
  Future<void> updateAnnouncements();
  Future<void> updateCalender();


  Future<void> checkConnectionState();
  Future<void> saveSingleDB(String filename, obj);

  Future<void> showNotification(BuildContext context);
}
