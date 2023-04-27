import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../models/category_model.dart';
import '../repository/category_repository.dart';


class CategoryProvider extends ChangeNotifier {


 // final firestoreService = FireStoreService();
  String _category_name = '';
  String _category_description = '';
   int? _category_id;
  String _category_image = '';
  bool _isSelected = false;
  //var uuid = Uuid();

  //Getters
  String get category_name => _category_name;
  String get category_description => _category_description;
  String get category_image => _category_image;
  bool get isSelected => _isSelected;

  final CategoryRepository _categoryRepository = CategoryRepository();
  List<CategoryModel> _categories = [];

  List<CategoryModel> get categories => _categories;

  Future<void> getCategories() async {
    _categories = await _categoryRepository.getCategories();
    notifyListeners();
  }

  //Setters
  setcategoryName(String value) {
    _category_name = value;
    notifyListeners();
  }

  setCategoryDescription(String value) {
    _category_description = value;
    notifyListeners();
  }

  setCategoryImage(String value) {
    _category_image = value;
    notifyListeners();
  }

  setIsSelectedValue(bool value) {
    _isSelected = value;
    notifyListeners();
  }

  loadValues(CategoryModel category){
    _category_name=category.categoryName!;
    _category_description=category.categoryDescription!;
    //_category_image = category.categoryImage!;
     _category_id=category.categoryId!;
  }

  saveCategory() async {
      // first time
      var newCategory = CategoryModel(categoryId: 1,categoryName: category_name, categoryDescription: category_description, categoryImage: await MultipartFile.fromFile(_temp_image!.path));
      print(_temp_image!.path.toString());
      FormData formData = newCategory.toFormData();
      await _categoryRepository.saveCategory(formData);
      notifyListeners();
  }

  updateCategory() async {
    // update data
    var updatedCategory =
    CategoryModel(categoryId : 1,categoryName: category_name, categoryDescription: category_description, categoryImage: await MultipartFile.fromFile(_temp_image!.path));
    await _categoryRepository.updateCategory(updatedCategory);
    notifyListeners();
  }

  removeCategory(int categoryId) async{
    await _categoryRepository.deleteCategory(categoryId);
    _categories.removeWhere((category) => category.categoryId == categoryId);
    notifyListeners();
  }

  File? _temp_image;

  get temp_image => _temp_image;

  void setImagetemp(File tempImage) {
    _temp_image = tempImage;
    notifyListeners();
  }

}