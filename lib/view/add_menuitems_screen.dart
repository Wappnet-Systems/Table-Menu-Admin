import 'dart:developer';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_admin/res/services/api_endpoints.dart';
import 'package:table_menu_admin/view/select_photo_options_screen.dart';
import '../models/category_model.dart';
import '../models/menuItem_model.dart';
import '../utils/widgets/custom_button.dart';
import '../utils/widgets/custom_textformfield.dart';
import '../view_model/menu_category_provider.dart';
import '../view_model/menu_provider.dart';

class AddMenuItemsScreen extends StatefulWidget {

  final MenuData? menuItemModel;
  final int? index;

  AddMenuItemsScreen([this.menuItemModel, this.index]);

  @override
  State<AddMenuItemsScreen> createState() => _AddMenuItemsScreenState();
}

class _AddMenuItemsScreenState extends State<AddMenuItemsScreen> {

  Future _pickImage(ImageSource source) async {
    final menu_provider = Provider.of<MenuProvider>(context, listen: false);
    try {
      final image = await ImagePicker().pickImage(source: source);

      final imageTemporary = File(image!.path);

      menu_provider.setImagetemp(imageTemporary);
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

  final GlobalKey<FormState> _formKey_add_menuitem = GlobalKey();
  TextEditingController name_controller = TextEditingController();
  TextEditingController description_controller = TextEditingController();
  TextEditingController ingredients_controller = TextEditingController();
  TextEditingController price_controller = TextEditingController();

  List items = [];
  String image_url = "";

  String? selectedValue;
  @override
  void initState() {
    if(widget.menuItemModel == null){
      // new record
      name_controller.text = "";
      description_controller.text = "";
      ingredients_controller.text = "";
      price_controller.text = "";
      // new Future.delayed(Duration.zero , (){
      //   final menuProvider = Provider.of(context,listen: false);
      //   menuProvider.loadValues(MenuItemModel());
      // });
    } else{
      // existing record update
      name_controller.text = widget.menuItemModel!.name!;
      description_controller.text = widget.menuItemModel!.description!;
      ingredients_controller.text = widget.menuItemModel!.ingredients!;
      price_controller.text = widget.menuItemModel!.price.toString();
      image_url = widget.menuItemModel!.image_url!;
      //State Update
      new Future.delayed(Duration.zero, () {
        final menuProvider = Provider.of<MenuProvider>(context,listen: false);
        menuProvider.loadValues(widget.menuItemModel!);
      });
    }

    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final menu_provider = Provider.of<MenuProvider>(context, listen: true);
    final category_provider = Provider.of<CategoryProvider>(context);
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
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                      (widget.menuItemModel == null) ?
                      const Text(
                        "Add Menu Item",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ) :
                      const Text(
                        "Update Menu Item",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      )
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
                        child: Consumer<MenuProvider>(
                          builder: (_, menuconsumer, __) {
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
                                    child:  widget.menuItemModel == null ?
                                    Column(
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
                                        :
                                    CircleAvatar(
                                            backgroundImage: NetworkImage(ApiEndPoint.baseImageUrl + image_url) as ImageProvider,
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
                  key: _formKey_add_menuitem,
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
                              menu_provider.setMenuName(value);
                            },
                            prefixicon: const Icon(
                              Icons.drive_file_rename_outline,
                              color: Colors.black,
                            ),
                            controller: name_controller,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return  "Name Field is Required";
                              }
                            },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        StreamBuilder(
                          stream: category_provider.getCategories().asStream(),
                            builder: (context, snapshot) {
                            if(snapshot.hasData){
                              List<Data>? categories = snapshot.data;
                              return DropdownButtonFormField2(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Category Field is Required";
                                  }
                                },
                                decoration: const InputDecoration(
                                    labelText: "Category",
                                    hintText: "Choose Category",
                                    prefixIcon: Icon(
                                      Icons.category_outlined,
                                      color: Colors.black,
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(width: 3, color: Colors.black),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(25))),
                                    // This is the error border
                                    errorBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.red, width: 5))),
                                items: List.generate(categories!.length, (index) => categories[index].categoryName )
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                                    .toList(),
                                value: selectedValue,
                                onChanged: (value) {
                                  category_provider.setcategoryName(value!);
                                    List.generate(categories.length,
                                            (index){
                                              if(categories[index].categoryName == value){
                                                log("category id :${categories[index].categoryId}");
                                                menu_provider.setCategoryId(categories[index].categoryId!);
                                              }
                                            });
                                },
                              );
                            }
                            return Container();
                            }
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField().getCustomEditTextArea(
                            labelValue: "Ingredients",
                            hintValue: "Enter Ingredients",
                            onchanged: (value) {
                              menu_provider.setMenuIngredients(value);
                            },
                          obscuretext: false,
                          maxLines: 1,
                            prefixicon: const Icon(
                              Icons.event_note_outlined,
                              color: Colors.black,
                            ),
                            controller: ingredients_controller,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "ingredients Field is Required";
                              }
                            },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField().getCustomEditTextArea(
                            labelValue: "Price",
                            hintValue: "Enter Price",
                          onchanged: (value) {
                              int a = int.parse(value);
                            menu_provider.setMenuPrice(a);
                          },
                          obscuretext: false,
                          maxLines: 1,
                            prefixicon: const Icon(
                              Icons.currency_rupee_outlined,
                              color: Colors.black,
                            ),
                            controller: price_controller,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Price Field is Required";
                              }
                            },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField().getCustomEditTextArea(
                            labelValue: "Description",
                            hintValue: "Enter Description",
                            onchanged: (value) {
                              menu_provider.setMenuDescription(value);
                            },
                          obscuretext: false,
                            prefixicon: const Icon(
                              Icons.description_outlined,
                              color: Colors.black,
                            ),
                            maxLines: 4,
                            controller: description_controller,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Description Field is Required";
                              }
                            },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: const [
                            Text(
                              "Other details To Add",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(width: 4),
                            const Text(
                              "New",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            const Spacer(),
                            Switch(
                              value: menu_provider.isEnableNew,
                              onChanged: (value) {
                                  menu_provider.setBoolNew(value);
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(width: 4),
                            const Text(
                              "Veg",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            const Spacer(),
                            Switch(
                              value: menu_provider.isEnableVeg,
                              onChanged: (value) {
                                if(menu_provider.isEnableNonVeg == true){
                                }else {
                                  menu_provider.setBoolVeg(value);
                                }
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(width: 4),
                            const Text(
                              "Non Veg",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            const Spacer(),
                            Switch(
                              value: menu_provider.isEnableNonVeg,
                              onChanged: (value) {
                                if(menu_provider.isEnableVeg == true){
                                }else{
                                  menu_provider.setBoolNonVeg(value);
                                }
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(width: 4),
                            const Text(
                              "Spicy",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            const Spacer(),
                            Switch(
                              value: menu_provider.isEnableSpicy,
                              onChanged: (value) {
                                if(menu_provider.isEnableSweet == true) {
                                }else {
                                  menu_provider.setBoolSpicy(value);
                                }
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(width: 4),
                            const Text(
                              "Jain",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            const Spacer(),
                            Switch(
                              value: menu_provider.isEnableJain,
                              onChanged: (value) {
                                if(menu_provider.isEnableNonVeg == true){

                                }else{
                                  menu_provider.setBoolJain(value);
                                }
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(width: 4),
                            const Text(
                              "Special",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            const Spacer(),
                            Switch(
                              value: menu_provider.isEnableSpecial,
                              onChanged: (value) {
                                menu_provider.setBoolSpecial(value);
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(width: 4),
                            const Text(
                              "Sweet",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            const Spacer(),
                            Switch(
                              value: menu_provider.isEnableSweet,
                              onChanged: (value) {
                                if(menu_provider.isEnableSpicy == true) {
                                }else {
                                  menu_provider.setBoolSweet(value);
                                }
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(width: 4),
                            const Text(
                              "Popular",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            const Spacer(),
                            Switch(
                              value: menu_provider.isEnablePopular,
                              onChanged: (value) {
                                menu_provider.setBoolPopular(value);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: CustomButton(onPressed: () {
                       if (_formKey_add_menuitem.currentState!.validate()) {
                         if(widget.menuItemModel?.name == null){
                           menu_provider.saveMenuItem();
                         }else {
                           menu_provider.updateMenuItem(widget.menuItemModel!.id!);
                         }
                         Navigator.of(context).pop();
                       }
                          }, child: const Text("Save", style: TextStyle(fontSize: 16.0),),),
                        ),
                        const SizedBox(height: 20,),
                        (widget.menuItemModel != null ) ? SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: CustomButton(onPressed: () {
                            menu_provider.removeMenuItem(widget.menuItemModel!.id!);
                            Navigator.of(context).pop();
                          }, child: const Text("Delete", style: TextStyle(fontSize: 16.0),),),
                        ): Container(),
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
