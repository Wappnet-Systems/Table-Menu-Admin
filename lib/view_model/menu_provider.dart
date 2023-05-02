import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:table_menu_admin/repository/menu_item_repository.dart';
import '../models/menuItem_model.dart';


class MenuProvider with ChangeNotifier {

  final MenuItemRepository _menuItemRepository = MenuItemRepository();
  bool _isEnableNew = false;
  bool _isEnableVeg = false;
  bool _isEnableNonVeg = false;
  bool _isEnableSpicy = false;
  bool _isEnableJain = false;
  bool _isEnableSpecial = false;
  bool _isEnableSweet = false;
  bool _isEnablePopular = false;

  int? _menu_id;
  String _menu_name = "";
  String _menu_image = "";

  String get menu_image => _menu_image;
  int _menu_category_id = 0;
  String _menu_ingredients = "";
  int _menu_price = 0;
  String _menu_description = "";
  String _category_name = "";
  //var uuid = Uuid();

  // Getters
  String get menu_name => _menu_name;
  int get menu_category_id => _menu_category_id;
  String get menu_ingredients => _menu_ingredients;
  int get menu_price => _menu_price;
  String get menu_description => _menu_description;
  String get category_name => _category_name;
  bool get isEnableNew => _isEnableNew;


  bool get isEnableVeg => _isEnableVeg;
  bool get isEnableNonVeg => _isEnableNonVeg;
  bool get isEnableSpicy => _isEnableSpicy;
  bool get isEnableJain => _isEnableJain;
  bool get isEnableSpecial => _isEnableSpecial;
  bool get isEnableSweet => _isEnableSweet;
  bool get isEnablePopular => _isEnablePopular;

  List<MenuData> _menuitems = [];

  List<MenuData> get menuitems => _menuitems;




  // Setters

  void setMenuName(String value){
    _menu_name = value;
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
  void setCategoryId(int value){
    _menu_category_id = value;
    notifyListeners();
  }
  void setCategoryName(String value){
    _category_name = value;
    notifyListeners();
  }

  loadValues(MenuData menuItem){
    _menu_id = menuItem.id;
    _menu_image = menuItem.image_url!;
    _menu_name = menuItem.name!;
    _menu_ingredients = menuItem.ingredients!;
    _menu_price = int.parse(menuItem.price!);
    _menu_description = menuItem.description!;
    _isEnableNew = menuItem.isNew!;
    _isEnableVeg = menuItem.isVeg!;
    _isEnableNonVeg = menuItem.isNonVeg!;
    _isEnableSpicy = menuItem.isSpicy!;
    _isEnableJain = menuItem.isJain!;
    _isEnableSpecial = menuItem.isSpecial!;
    _isEnableSweet = menuItem.isSweet!;
    _isEnablePopular = menuItem.isPopular!;
  }

  Future<List<MenuData>> getMenuItems() async {
    var response = await _menuItemRepository.getMenuItems();
    if (response != null) {
      if (response.statusCode == 200) {
        var result = response.data;
        //print(result);

        var getMenuItem = MenuItemModel.fromJson(response.data);

        if (getMenuItem.menuData!.isNotEmpty) {
          var addedIds = Set<int>();
          _menuitems.clear();
          _menuitems.addAll(getMenuItem.menuData!);
          log("categoryList:${_menuitems.length}");
          getMenuItem.menuData!.forEach((data) {
            // Check if category already exists
            if (!addedIds.contains(data.id)) {
              // categoryList.add(GetCategory(data: [data]));
              addedIds.add(data.id!); // Add categoryId to Set
            }
          });

          print('###$_menuitems');
          return _menuitems;
        }
      } else {}
    }
    // Return an empty list if there was an error
    return [];
  }


  saveMenuItem() async {
    var menuData = MenuData(
      name: menu_name,
      description: menu_description,
      image: await MultipartFile.fromFile(temp_image!.path),
      price: menu_price.toString(),
      ingredients: menu_ingredients,
      category_id: menu_category_id,
      category_name: category_name,
      isJain: isEnableJain,
      isVeg: isEnableVeg,
      isNew: isEnableNew,
      isNonVeg: isEnableNonVeg,
      isPopular: isEnablePopular,
      isSpecial: isEnableSpecial,
      isSpicy: isEnableSpicy,
      isSweet: isEnableSweet
    );
    FormData formData = menuData.toFormData();
    await _menuItemRepository.saveMenuItem(formData);
    notifyListeners();
  }

  updateMenuItem(int id) async {
    var menuData = MenuData(
        name: _menu_name,
        description: _menu_description,
        image: _temp_image != null ? await MultipartFile.fromFile(_temp_image!.path) : null,
        price: _menu_price.toString(),
        ingredients: _menu_ingredients,
        category_id: _menu_category_id,
        category_name: _category_name,
        isJain: _isEnableJain,
        isVeg: _isEnableVeg,
        isNew: _isEnableNew,
        isNonVeg: _isEnableNonVeg,
        isPopular: _isEnablePopular,
        isSpecial: _isEnableSpecial,
        isSpicy: _isEnableSpicy,
        isSweet: _isEnableSweet
    );
    FormData formData = menuData.toFormData();
     _menuItemRepository.updateMenuItem(formData,id);
     notifyListeners();
  }

  removeMenuItem(int id) async{
    await _menuItemRepository.deleteMenuItem(id);
    _menuitems.removeWhere((menuitem) => menuitem.id == id);
    notifyListeners();
  }

  File? _temp_image;
  get temp_image => _temp_image;

  void setImagetemp(File temp_image) {
    _temp_image = temp_image;
    notifyListeners();
  }

}