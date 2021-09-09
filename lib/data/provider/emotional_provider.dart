import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/models/base_response.dart';
import 'package:test_flutter_web/data/models/emotional_log.dart';
import 'package:test_flutter_web/data/models/query_models.dart';
import 'package:test_flutter_web/data/provider/base_provider.dart';
import 'package:test_flutter_web/utils/helpers.dart';

abstract class IEmotionalApiProvider {
  Future<BaseResponse<EmotionalLog>> getEmotionalLogs(QueryModel queryModel);
}

class EmotionalApiProvider extends BaseProvider with IEmotionalApiProvider {
  Future<BaseResponse<EmotionalLog>> getEmotionalLogs(QueryModel queryModel) async {
    var query = parsedQuery(queryModel.toJson())!;
    var rs = await get(ApiPath.GetEmotionalLogs, query: query);
    BaseResponse<EmotionalLog> baseResponse = BaseResponse.fromJson(
        rs.body,
            (json) => EmotionalLog.fromJson(json as Map<String, dynamic>));
    return baseResponse;
  }
}