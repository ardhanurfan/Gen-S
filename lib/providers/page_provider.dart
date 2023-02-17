import 'package:flutter/cupertino.dart';

class PageProvider extends ChangeNotifier {
  int _page = 0;
  int _homePage = 0;

  int get page => _page;
  int get homePage => _homePage;

  set setPage(int index) {
    _page = index;
    notifyListeners();
  }

  set setHomePage(int index) {
    _homePage = index;
    notifyListeners();
  }
}
