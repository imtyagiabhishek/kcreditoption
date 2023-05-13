import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';
import '../utils/app_constants.dart';

class MainRepo {

  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  MainRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> login({required String phone}) async {
    return await apiClient.postData(AppConstants.LOGIN_URI, {"loginId": phone});
  }
  Future<Response> getCity({required String city,required int count}) async {
    return await apiClient.getData(AppConstants.CITY_URI+"?limit="+count.toString()+"&keyword="+city);
  }
  Future<Response> getLocality({required String cityId,required String locality,required int count}) async {
    return await apiClient.getData(AppConstants.LOCALITY_URI+"?limit="+count.toString()+"&keyword="+locality+"&cityId="+cityId);
  }
  Future<Response> getPage({required String id}) async {
    return await apiClient.getData(AppConstants.PAGE_URI+id);
  }
}
