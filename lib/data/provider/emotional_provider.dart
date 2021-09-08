import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/models/base_response.dart';
import 'package:test_flutter_web/data/models/emotional_log.dart';
import 'package:test_flutter_web/data/provider/base_provider.dart';
import 'package:test_flutter_web/modules/authentication/authentication_controller.dart';

class EmotionalApiProvider extends BaseProvider {
  Future<BaseResponse<EmotionalLog>?> getEmotionalLogs(int offset, limit) async {
    var query = {
      "offset": offset,
      "limit": limit,
    };
    var rs = await get<BaseResponse<EmotionalLog>>('/admin/v1/emotion-log/list', query: query);
    await Future.delayed(Duration(seconds: 5));
    return null;
  }
}