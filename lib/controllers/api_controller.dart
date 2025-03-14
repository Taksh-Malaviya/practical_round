import 'package:get/get.dart';
import 'package:practical/services/api.dart';

import '../model/app_model.dart';

class APIController extends GetxController {
  late Future<List<Result>?> allData;

  void getData() async {
    allData = Apihalper.apihalper.getData();

    update();
  }

  void getPaidData() async {
    allData = Apihalper.apihalper.getPaiData();

    update();
  }
}
