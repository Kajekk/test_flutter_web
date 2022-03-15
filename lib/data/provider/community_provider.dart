import 'dart:convert';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/data/provider/barrel.dart';
import 'package:test_flutter_web/utils/helpers.dart';

abstract class ICommunityApiProvider {
  Future<BaseResponse<CommunityTopic>> getTopics(QueryModel queryModel);
  Future<BaseResponse> createTopic(CommunityTopic data);
  Future<BaseResponse> updateTopic(CommunityTopic data);
  Future<BaseResponse> deleteTopics(QueryModel queryModel);
}

class CommunityApiProvider extends BaseProvider with ICommunityApiProvider {
  Future<BaseResponse<CommunityTopic>> getTopics(
      QueryModel queryModel) async {
    var query = parsedQuery(queryModel.toJson())!;
    var rs = await get(ApiPath.CommunityTopicUri, query: query);
    BaseResponse<CommunityTopic> baseResponse = BaseResponse.fromJson(
        rs.body, (json) => CommunityTopic.fromJson(json as Map<String, dynamic>));
    return baseResponse;
  }

  Future<BaseResponse> createTopic(CommunityTopic data) async {
    var rs = await post(ApiPath.CommunityTopicUri, data.toJson());
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> updateTopic(CommunityTopic data) async {
    var query = {
      "id": data.id,
    };
    var rs = await put(ApiPath.CommunityTopicUri, data.toJson(), query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> deleteTopics(QueryModel queryModel) async {
    var query = {
      "q": jsonEncode(queryModel.toJson()),
    };
    var rs = await delete(ApiPath.CommunityTopicUri, query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }
}