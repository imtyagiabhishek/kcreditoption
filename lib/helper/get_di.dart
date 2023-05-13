import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../api/api_client.dart';
import '../controller/auth_controller.dart';
import '../repository/auth_repo.dart';
import '../utils/app_constants.dart';

Future<Map<String, Map<String, String>>?> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

  // Repository
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  // Controller
  Get.lazyPut(() => AuthController(authRepo: Get.find()));

}
