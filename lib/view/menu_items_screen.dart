import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_admin/view_model/menu_provider.dart';
import '../models/category_model.dart';
import '../models/menuItem_model.dart';
import '../res/services/api_endpoints.dart';
import '../utils/responsive.dart';
import '../view_model/menu_category_provider.dart';
import 'add_category_screen.dart';
import 'add_menuitems_screen.dart';

class MenuItemListScreen extends StatefulWidget {
  const MenuItemListScreen({Key? key}) : super(key: key);

  @override
  State<MenuItemListScreen> createState() => _MenuItemListScreenState();
}

class _MenuItemListScreenState extends State<MenuItemListScreen> {
  @override
  Widget build(BuildContext context) {
    final category_provider = Provider.of<CategoryProvider>(context);
    final menuitem_provider = Provider.of<MenuProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10),
            child: StreamBuilder<List<Data>>(
                stream: category_provider.getCategories().asStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Data>? items = snapshot.data;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              right: 10, top: 10, bottom: 10),
                          child: const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Hello, Admin",
                              style: TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Categories (${items?.length})",
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddCategoryScreen(),
                                    ));
                              },
                              child: DottedBorder(
                                color: Colors.black,
                                strokeWidth: 1,
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(20.0),
                                padding: const EdgeInsets.all(8),
                                child: const Text(
                                  "+ Add",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: const [
                            Text(
                              "Long Press on Categories for more options",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Flexible(
                            flex: 2,
                            child: (items != null && items.isNotEmpty)
                                ? ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: items.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onLongPress: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AddCategoryScreen(
                                                        items[index]),
                                              ));
                                        },
                                        onTap: () {
                                          category_provider
                                              .setIsSelectedValue(true);
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: CircleAvatar(
                                                backgroundImage: items[index]
                                                            .categoryImg ==
                                                        null
                                                    ? null
                                                    : NetworkImage(ApiEndPoint
                                                            .baseImageUrl +
                                                        items[index]
                                                            .categoryImg
                                                            .toString()),
                                                radius: 38,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              items[index].categoryName!,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    })
                                : Container()),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text(
                                  "Menu Items",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AddMenuItemsScreen(),
                                    ));
                              },
                              child: DottedBorder(
                                color: Colors.black,
                                strokeWidth: 1,
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(20.0),
                                padding: const EdgeInsets.all(8),
                                child: const Text(
                                  "+ Add",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<List<MenuData>>(
                          stream: menuitem_provider.getMenuItems().asStream(),
                          builder: (context, snapshot) {
                            print(snapshot);
                            if (snapshot.hasData) {
                              List<MenuData>? menu_items = snapshot.data;
                              log("menu items : $menu_items");
                              return Expanded(
                                flex: 5,
                                child: (menu_items == null)
                                    ? Center(
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            Image.asset(
                                              "assets/images/empty-menu.png",
                                              height: 230,
                                              width: 230,
                                            ),
                                            const Text(
                                              "No Menu",
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount: menu_items.length,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    AddMenuItemsScreen(
                                                        menu_items[index]),
                                              ));
                                            },
                                            child: Container(
                                              width: wp(100, context),
                                              child: Card(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ListTile(
                                                    leading: Image.network(ApiEndPoint.baseImageUrl +
                                                      menu_items[index]
                                                              .image_url! ??
                                                          '',
                                                    ),
                                                    title: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            (menu_items[index]
                                                                        .isVeg! ==
                                                                    true)
                                                                ? Image.asset(
                                                                    "assets/images/veg-icon.png",
                                                                    height: 40,
                                                                    width: 40,
                                                                  )
                                                                : Image.asset(
                                                                    "assets/images/non-veg-icon.png",
                                                                    height: 35,
                                                                    width: 35,
                                                                  ),
                                                            const Spacer(),
                                                            (menu_items[index]
                                                                        .isNew ==
                                                                    true)
                                                                ? Container(
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .purple
                                                                            .shade200,
                                                                        borderRadius:
                                                                            const BorderRadius.all(Radius.circular(20))),
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        const Text(
                                                                      "New",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .purple,
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  )
                                                                : Container()
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 6,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "${menu_items[index].name!}",
                                                              style: const TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 6,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "${menu_items[index].ingredients!}",
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 12,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        const Divider(
                                                          height: 3,
                                                          color: Colors.grey,
                                                        ),
                                                        const SizedBox(
                                                          height: 6,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "₹ ${menu_items[index].price!}",
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Spacer(),
                                                            (menu_items[index]
                                                                        .isSpicy ==
                                                                    true)
                                                                ? Text(
                                                                    "Spicy, ",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                  )
                                                                : Text(""),
                                                            (menu_items[index]
                                                                        .isSweet ==
                                                                    true)
                                                                ? Text(
                                                                    "Sweet, ",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                  )
                                                                : Text(""),
                                                            (menu_items[index]
                                                                        .isSpecial ==
                                                                    true)
                                                                ? Text(
                                                                    "Special, ",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                  )
                                                                : Text(""),
                                                            (menu_items[index]
                                                                        .isPopular ==
                                                                    true)
                                                                ? Text(
                                                                    "Popular ",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                  )
                                                                : Text(""),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 6,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                          // : Center(
                                          //   child: Column(
                                          //     children: [
                                          //       const SizedBox(
                                          //         height: 30,
                                          //       ),
                                          //       Image.asset(
                                          //         "assets/images/empty-menu.png",
                                          //         height: 230,
                                          //         width: 230,
                                          //       ),
                                          //       const Text(
                                          //         "No Menu",
                                          //         style: TextStyle(
                                          //             fontSize: 22,
                                          //             fontWeight: FontWeight.w400),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // );
                                        },
                                      ),
                              );
                            } else {}
                            return CircularProgressIndicator();
                          },
                        ),
                      ],
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ),
        ),
      ),
    );
  }
}
