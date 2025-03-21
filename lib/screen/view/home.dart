import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:practical/controllers/api_controller.dart';
import 'package:practical/model/app_model.dart';
import 'package:practical/routs/routes.dart';
import 'package:practical/services/api.dart';
import '../../controllers/theme.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  APIController controller = Get.put(APIController());
  FocusNode searchFocusNode = FocusNode();
  bool isTextFieldFocused = false;

  @override
  void initState() {
    super.initState();
    controller.getData();

    searchFocusNode.addListener(() {
      setState(() {
        isTextFieldFocused = searchFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Apps",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              themeController.isDarkMode.value
                  ? Icons.wb_sunny
                  : Icons.nightlight_round,
              color: themeController.isDarkMode.value
                  ? Colors.yellow
                  : Colors.blue,
            ),
            onPressed: () {
              themeController.toggleTheme();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: CupertinoTextField(
              focusNode: searchFocusNode,
              placeholder: 'Search',
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: CupertinoColors.inactiveGray,
                  width: 0.5,
                ),
              ),
              prefix: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Icon(CupertinoIcons.search),
              ),
              suffix: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Icon(CupertinoIcons.mic),
              ),
            ),
          ),
          if (isTextFieldFocused)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Search field is focused. You can type here.",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.getData();
                  },
                  child: Container(
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "Top Free",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.getPaidData();
                  },
                  child: Container(
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "Top Paid",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          GetBuilder<APIController>(builder: (context) {
            return FutureBuilder(
              future: controller.allData,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  log("Error: ${snapshot.error}");
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (snapshot.hasData) {
                  List<Result>? data = snapshot.data;

                  if (data != null && data.isNotEmpty) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          var result = data[index];
                          log(result.name);
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.detail, arguments: result);
                            },
                            child: ListTile(
                              leading: Image.network(result.artworkUrl100),
                              title: Text(result.name),
                              subtitle: Text(result.artistName),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    log("Status Code: ${snapshot.connectionState}");
                    return Center(
                      child: Text('No data available'),
                    );
                  }
                } else {
                  return Center(
                    child: Text('No data available'),
                  );
                }
              },
            );
          }),
        ],
      ),
    );
  }
}
