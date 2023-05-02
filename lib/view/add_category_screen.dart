import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_admin/models/category_model.dart';
import 'package:table_menu_admin/res/services/api_endpoints.dart';
import 'package:table_menu_admin/view/select_photo_options_screen.dart';

import '../utils/widgets/custom_button.dart';
import '../utils/widgets/custom_textformfield.dart';
import '../view_model/menu_category_provider.dart';

class AddCategoryScreen extends StatefulWidget {
  final Data? category;

  AddCategoryScreen([this.category]);

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {

  Future _pickImage(ImageSource source) async {
    final category_provider =
        Provider.of<CategoryProvider>(context, listen: false);
    try {
      final image = await ImagePicker().pickImage(source: source);

      final imageTemporary = File(image!.path);

      category_provider.setImagetemp(imageTemporary);
      Navigator.of(context).pop();
    } on Exception catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: _pickImage,
              ),
            );
          }),
    );
  }

  final GlobalKey<FormState> _formKey_add_category = GlobalKey();
  final name_controller_category = TextEditingController();
  final description_controller_category = TextEditingController();
  String image_url = "";
  int category_id = 0;

  @override
  void dispose() {
    name_controller_category.dispose();
    description_controller_category.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.category == null) {
      // new record
      name_controller_category.text = "";
      name_controller_category.text = "";
      Future.delayed(Duration.zero, () {
        final categoryProvider = Provider.of(context, listen: false);
        categoryProvider.loadValues(CategoryModel());
      });
    } else {
      // existing record update
      category_id = widget.category!.categoryId!;
      name_controller_category.text = widget.category!.categoryName!;
      description_controller_category.text =
          widget.category!.description!;
      image_url = ApiEndPoint.baseImageUrl + widget.category!.categoryImg!.toString();
      //State Update
      Future.delayed(Duration.zero, () {
        final categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
        categoryProvider.loadValues(widget.category!);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                      (widget.category == null)
                          ? const Text(
                              "Add Category",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            )
                          : const Text(
                              "Update Category",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                  child: Center(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        _showSelectPhotoOptions(context);
                      },
                      child: Center(
                        child: Consumer<CategoryProvider>(
                          builder: (_, categoryconsumer, __) {
                            return DottedBorder(
                              color: Colors.black,
                              strokeWidth: 1,
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(20.0),
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                  height: 150.0,
                                  width: 200.0,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Center(
                                    child: categoryProvider.temp_image != null
                                        ? Column(
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Image.asset(
                                                "assets/images/select_image.png",
                                                height: 100,
                                                width: 100,
                                              ),
                                              const Text(
                                                "Upload Image",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          )
                                        : CircleAvatar(
                                            backgroundImage: widget.category?.categoryImg == null ? FileImage(categoryProvider.temp_image) : NetworkImage(image_url) as ImageProvider,
                                            radius: 200,
                                          ),
                                  )
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Form(
                  key: _formKey_add_category,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        CustomTextFormField().getCustomEditTextArea(
                          labelValue: "Name",
                          hintValue: "Enter Name",
                          obscuretext: false,
                          maxLines: 1,
                          onchanged: (value) {
                            categoryProvider.setcategoryName(value);
                          },
                          prefixicon: const Icon(
                            Icons.drive_file_rename_outline,
                            color: Colors.black,
                          ),
                          controller: name_controller_category,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Name Field is Required";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField().getCustomEditTextArea(
                          labelValue: "Description",
                          hintValue: "Enter Description",
                          obscuretext: false,
                          onchanged: (value) {
                            categoryProvider.setCategoryDescription(value);
                          },
                          prefixicon: const Icon(
                            Icons.description_outlined,
                            color: Colors.black,
                          ),
                          maxLines: 4,
                          controller: description_controller_category,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Description Field is Required";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: CustomButton(
                            onPressed: () async {
                              if (_formKey_add_category.currentState!
                                  .validate()) {
                                if(widget.category?.categoryName == null){
                                  categoryProvider.saveCategory();
                                }else {
                                  categoryProvider.updateCategory();
                                }
                                Navigator.of(context).pop();
                              }
                            },
                            child: const Text(
                              "Save",
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        (widget.category != null)
                            ? SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: CustomButton(
                                  onPressed: () {
                                    categoryProvider.removeCategory(
                                        widget.category!.categoryId!);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    "Delete",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}