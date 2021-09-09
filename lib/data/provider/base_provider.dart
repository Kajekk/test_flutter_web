import 'dart:html';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/api_path.dart';

class BaseProvider extends GetConnect {
  @override
  set withCredentials(bool _withCredentials) {
    super.withCredentials = _withCredentials;
  }
  @override
  bool get withCredentials => super.withCredentials;

  @override
  void onInit() {
    withCredentials = true;
    httpClient.baseUrl = ApiPath.BaseUrl;
    httpClient.addRequestModifier<void>((request) async {
      var accessToken = window.localStorage.containsKey("access_token") ? window.localStorage["access_token"] : "";
      request.headers['Authorization'] = "Bearer " + (accessToken ?? "");
      return request;
    });

    httpClient.addResponseModifier((request, response) {
      return response;
    });
  }
}