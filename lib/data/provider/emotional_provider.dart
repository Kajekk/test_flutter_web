import 'dart:convert';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/data/provider/barrel.dart';
import 'package:test_flutter_web/utils/helpers.dart';

abstract class IEmotionalApiProvider {
  Future<BaseResponse<EmotionalLog>> getEmotionalLogs(QueryModel queryModel);
  Future<BaseResponse> createEmotionalLog(EmotionalLog data);
  Future<BaseResponse> updateEmotionalLog(EmotionalLog data);
  Future<BaseResponse> deleteEmotionalLogs(QueryModel queryModel);

  Future<BaseResponse<EmotionType>> getEmotionalTypes(QueryModel queryModel);
}

class EmotionalApiProvider extends BaseProvider with IEmotionalApiProvider {
  Future<BaseResponse<EmotionalLog>> getEmotionalLogs(
      QueryModel queryModel) async {
    var query = parsedQuery(queryModel.toJson())!;
    var rs = await get(ApiPath.GetEmotionalLogs, query: query);
    BaseResponse<EmotionalLog> baseResponse = BaseResponse.fromJson(
        rs.body, (json) => EmotionalLog.fromJson(json as Map<String, dynamic>));
    return baseResponse;
  }

  Future<BaseResponse> createEmotionalLog(EmotionalLog data) async {
    var rs = await post(ApiPath.CreateEmotionLog, data.toJson());
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> updateEmotionalLog(EmotionalLog data) async {
    var query = {
      "id": data.id,
    };
    var rs = await put(ApiPath.UpdateEmotionLog, data.toJson(), query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> deleteEmotionalLogs(QueryModel queryModel) async {
    var query = {
      "q": jsonEncode(queryModel.toJson()),
    };
    var rs = await delete(ApiPath.DeleteEmotionLogs, query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  @override
  Future<BaseResponse<EmotionType>> getEmotionalTypes(QueryModel queryModel) async {
    var query = parsedQuery(queryModel.toJson())!;
    var rs = await get(ApiPath.GetEmotionTypes, query: query);
    BaseResponse<EmotionType> baseResponse = BaseResponse.fromJson(
        rs.body, (json) => EmotionType.fromJson(json as Map<String, dynamic>));
    return baseResponse;
  }
}
