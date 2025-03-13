import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:practical/controllers/api_controller.dart';
import 'package:practical/model/app_model.dart';
import 'package:practical/services/api.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  APIController controller = Get.put(APIController());
  @override
  void initState() {
    super.initState();
    controller.getData();
  }

  @override
  Widget build(BuildContext context) {
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
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: CupertinoTextField(
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
                          return ListTile(
                            leading: Image.network(result.artworkUrl100),
                            title: Text(result.name),
                            subtitle: Text(result.artistName),
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
