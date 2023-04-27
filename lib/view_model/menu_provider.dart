import 'dart:io';
import 'package:flutter/cupertino.dart';

class MenuProvider with ChangeNotifier {

  //final firestoreService = FireStoreService();
  bool _isEnableNew = false;
  bool _isEnableVeg = false;
  bool _isEnableNonVeg = false;
  bool _isEnableSpicy = false;
  bool _isEnableJain = false;
  bool _isEnableSpecial = false;
  bool _isEnableSweet = false;
  bool _isEnablePopular = false;

  String? _menu_id;
  String _menu_name = "";
  String _menu_image = "";

  String get menu_image => _menu_image;
  String _menu_category = "";
  String _menu_ingredients = "";
  int _menu_price = 0;
  String _menu_description = "";
  //var uuid = Uuid();

  // Getters
  String get menu_name => _menu_name;
  String get menu_category => _menu_category;
  String get menu_ingredients => _menu_ingredients;
  int get menu_price => _menu_price;
  String get menu_description => _menu_description;

  bool get isEnableNew => _isEnableNew;


  bool get isEnableVeg => _isEnableVeg;
  bool get isEnableNonVeg => _isEnableNonVeg;
  bool get isEnableSpicy => _isEnableSpicy;
  bool get isEnableJain => _isEnableJain;
  bool get isEnableSpecial => _isEnableSpecial;
  bool get isEnableSweet => _isEnableSweet;
  bool get isEnablePopular => _isEnablePopular;



  // Setters

  void setMenuName(String value){
    _menu_name = value;
    notifyListeners();
  }
  void setMenuCategory(String value){
    _menu_category = value;
    notifyListeners();
  }
  void setMenuIngredients(String value){
    _menu_ingredients = value;
    notifyListeners();
  }
  void setMenuPrice(int value){
    _menu_price = value;
    notifyListeners();
  }
  void setMenuDescription(String value){
    _menu_description = value;
    notifyListeners();
  }

  void setBoolNew(bool value){
    _isEnableNew=value;
    notifyListeners();
  }
  void setBoolVeg(bool value){
    _isEnableVeg=value;
    notifyListeners();
  }
  void setBoolNonVeg(bool value){
    _isEnableNonVeg=value;
    notifyListeners();
  }
  void setBoolSpicy(bool value){
    _isEnableSpicy=value;
    notifyListeners();
  }
  void setBoolJain(bool value){
    _isEnableJain=value;
    notifyListeners();
  }
  void setBoolSpecial(bool value){
    _isEnableSpecial=value;
    notifyListeners();
  }
  void setBoolSweet(bool value){
    _isEnableSweet=value;
    notifyListeners();
  }
  void setBoolPopular(bool value){
    _isEnablePopular=value;
    notifyListeners();
  }

  // loadValues(MenuItemModel menuItem){
  //   _menu_id = menuItem.menuId!;
  //   _menu_image = menuItem.menuImage!;
  //   _menu_name = menuItem.menuName!;
  //   _menu_category = menuItem.menuCateory!;
  //   _menu_ingredients = menuItem.menuIngredients!;
  //   _menu_price = menuItem.menuPrice!;
  //   _menu_description = menuItem.menuDescription!;
  //   _isEnableNew = menuItem.isEnableNew!;
  //   _isEnableVeg = menuItem.isEnableVeg!;
  //   _isEnableNonVeg = menuItem.isEnableNonVeg!;
  //   _isEnableSpicy = menuItem.isEnableSpicy!;
  //   _isEnableJain = menuItem.isEnableJain!;
  //   _isEnableSpecial = menuItem.isEnableSpecial!;
  //   _isEnableSweet = menuItem.isEnableSweet!;
  //   _isEnablePopular = menuItem.isEnablePopular!;
  // }


  // saveMenuItem() async {
  //     // first time
  //     var newMenuItem =
  //     MenuItemModel(
  //       createdAt: DateTime.now().toString(),
  //       menuId: uuid.v4(),
  //       menuImage:  await firestoreService.addMenuItemImage(_temp_image!),
  //       menuName: menu_name,
  //       menuCateory: menu_category,
  //       menuIngredients: menu_ingredients,
  //       menuPrice: menu_price,
  //       menuDescription: menu_description,
  //       isEnableNew: isEnableNew,
  //       isEnableVeg: isEnableVeg,
  //       isEnableNonVeg: isEnableNonVeg,
  //       isEnableSpicy: isEnableSpicy,
  //       isEnableJain: isEnableJain,
  //       isEnableSpecial: isEnableSpecial,
  //       isEnableSweet: isEnableSweet,
  //       isEnablePopular: isEnablePopular
  //     );
  //     firestoreService.saveMenuItem(newMenuItem);
  // }

  // updateMenuItem() async {
  //   var updatedMenuItem =
  //   MenuItemModel(
  //     createdAt: DateTime.now().toString(),
  //       menuId: _menu_id,
  //       menuImage:  _menu_id,
  //       menuName: menu_name,
  //       menuCateory: menu_category,
  //       menuIngredients: menu_ingredients,
  //       menuPrice: menu_price,
  //       menuDescription: menu_description,
  //       isEnableNew: isEnableNew,
  //       isEnableVeg: isEnableVeg,
  //       isEnableNonVeg: isEnableNonVeg,
  //       isEnableSpicy: isEnableSpicy,
  //       isEnableJain: isEnableJain,
  //       isEnableSpecial: isEnableSpecial,
  //       isEnableSweet: isEnableSweet,
  //       isEnablePopular: isEnablePopular
  //   );
  //   firestoreService.updateMenuItem(updatedMenuItem, _menu_id!);
  // }

  // removeMenuItem(String menuId){
  //   firestoreService.removeMenuItem(menuId);
  // }

  File? _temp_image;
  get temp_image => _temp_image;

  void setImagetemp(File temp_image) {
    _temp_image = temp_image;
    notifyListeners();
  }

}