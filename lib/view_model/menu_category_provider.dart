import 'dart:async';
import 'dart:developer';
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
  //   Stream<List<CategoryModel>> _categoryStream = Stream.value([]);
  // Stream<List<CategoryModel>> get categoryStream => _categoryStream;
  final CategoryRepository _categoryRepository = CategoryRepository();
  List<Data> _categories = [];

  List<Data> get categories => _categories;


  CategoryProvider() {
    //_categoryStream = _categoryRepository.getCategories().asStream();
    notifyListeners();
  }

  Future<List<Data>> getCategories() async {
    var response = await _categoryRepository.getCategories();
    if (response != null) {
      if (response.statusCode == 200) {
        var result = response.data;
        print(result);

        var getCategory = CategoryModel.fromJson(response.data);
        print(getCategory.data![0].categoryName);
        if (getCategory.data!.isNotEmpty) {
          var addedIds = Set<int>();
          _categories.clear();
          _categories.addAll(getCategory.data!);
          log("categoryList:${_categories.length}");
          getCategory.data!.forEach((data) {
            // Check if category already exists
            if (!addedIds.contains(data.categoryId)) {
              // categoryList.add(GetCategory(data: [data]));
              addedIds.add(data.categoryId!); // Add categoryId to Set
            }
          });

          print('###$_categories');
          return _categories;
        }
      } else {}
    }
    // Return an empty list if there was an error
    return [];
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

  loadValues(Data category){
    _category_name=category.categoryName!;
    _category_description=category.description!;
    _category_image = category.categoryImg!;
     _category_id=category.categoryId!;
  }

  saveCategory() async {
      // first time
      var newCategory = CategoryModel(categoryName: category_name, categoryDescription: category_description, categoryImage: await MultipartFile.fromFile(_temp_image!.path));
      print(_temp_image!.path.toString());
      FormData formData = newCategory.toFormData();
      await _categoryRepository.saveCategory(formData);
      notifyListeners();
  }

  updateCategory() async {
    // update data
    var updatedCategory =
    CategoryModel(categoryId : _category_id,categoryName: category_name, categoryDescription: category_description, categoryImage: await MultipartFile.fromFile(_temp_image!.path));
    FormData formData = updatedCategory.toFormData();
    await _categoryRepository.updateCategory(formData,updatedCategory.categoryId!);
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