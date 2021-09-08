import 'package:get/get.dart';
import 'package:test_flutter_web/constants/api_path.dart';
import 'package:test_flutter_web/modules/authentication/authentication.dart';

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
      // String? token = await Get.find<AuthenticationController>().secureStorage.read(key: 'access_token');
      // request.headers['Authorization'] = token ?? '';
      return request;
    });

    httpClient.addResponseModifier((request, response) {
      return response;
    });
  }
}