import 'package:flutter/cupertino.dart';

class SortByProvider extends ChangeNotifier {
  int _current = 0;

  int get sortBy => _current;

  set setSortBy(int index) {
    _current = index;
    notifyListeners();
  }
}
