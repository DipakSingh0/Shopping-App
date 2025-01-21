import 'package:flutter/material.dart';

class ProductNotifier extends ChangeNotifier {
  int _activePage = 0;

  List<dynamic> _shoesSizes = [];


  int get activePage => _activePage;

  set activePage(int newIndex){
    _activePage = newIndex;
    notifyListeners();
  }

  List<dynamic> get shoesSizes => _shoesSizes ;

set shoesSizes(List<dynamic> newSizes) {
  _shoesSizes = newSizes;
  notifyListeners();
}

void toggleCheck(int index){
  for(int i=0; i < _shoesSizes.length ; i++){
    if(i == index){
      _shoesSizes[index]['isSelected'] = !_shoesSizes[index]['isSelected'];
  }
}
}

}