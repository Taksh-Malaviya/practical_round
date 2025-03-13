import 'package:get/get.dart';
import 'package:practical/services/api.dart';

import '../model/app_model.dart';

class APIController extends GetxController {
  late Future<List<Result>?>
      allData; // Use Future.value to initialize with an empty list.

  void getData() async {
    allData = Apihalper.apihalper.getData();

    update();
  }

  void getPaidData() async {
    // Similarly for the getPaidData method
    allData = Apihalper.apihalper.getPaiData();

    update();
  }
}
