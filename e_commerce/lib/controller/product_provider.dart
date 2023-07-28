import 'package:e_commerce/models/sneakers_model.dart';
import 'package:e_commerce/services/helper.dart';
import 'package:flutter/material.dart';

class ProductNotifier extends ChangeNotifier {
  int _activepage = 0;
  List<dynamic> _shoeSizes = [];
  List<String> _sizes = [];
  late Future<Sneakers> sneaker;


  int get activepage => _activepage;
  List<dynamic> get shoeSizes => _shoeSizes;
  List<String> get sizes => _sizes ;

  set activePage(int newIndex) {
    _activepage = newIndex;
    notifyListeners();
  }

  set shoeSizes(List<dynamic> newSizes){
    _shoeSizes = newSizes ;
    notifyListeners();
  }
  set sizes(List<String> newSizes){
    _sizes = newSizes ;
    notifyListeners();
  }


  late Future<List<Sneakers>> male, female, kid;

  void getMale() {
    male = Helper().getMaleSneakers();
  }

  void getFemale() {
    female = Helper().getFeMaleSneakers();
  }

  void getKid() {
    kid = Helper().getKidsSneakers();
  }



  void getShoes(String category , String id) {
    if (category == "Men's Running") {
      sneaker = Helper().getMaleSneakersbyID(id);
    } else if (category == "Women's Running") {
      sneaker = Helper().getFemaleSneakersbyID(id);
    } else {
      sneaker = Helper().getKidsSneakersbyID(id);
    }
  }




  //The below function is called with an index , it will toggle the selection of that item
  // and leave the selection of all other items as they were .
  // This will allow for multiple items to be selected .
  void toggleCheck(int index){
      for(int i =0 ; i<_shoeSizes.length ;i++){
        if(i==index){
           _shoeSizes[i]['isSelected'] = !_shoeSizes[i]['isSelected'];
        }
      }
      notifyListeners();
  }

}
