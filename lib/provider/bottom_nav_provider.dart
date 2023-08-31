import 'package:flutter/material.dart';

class BottomNavProvider extends ChangeNotifier {

  int page = 0;

  onPageChanged(int currentPage) {
    page = currentPage;
    notifyListeners();
  }

  
}
