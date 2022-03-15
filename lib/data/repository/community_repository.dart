import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/data/models/base_response.dart';
import 'package:test_flutter_web/data/models/query_models.dart';
import 'package:test_flutter_web/data/provider/barrel.dart';

abstract class ICommunityRepository {
  Future<BaseResponse<CommunityTopic>> getTopics(QueryModel queryModel);
  Future<BaseResponse> createTopic(CommunityTopic data);
  Future<BaseResponse> updateTopic(CommunityTopic data);
  Future<BaseResponse> deleteTopics(QueryModel queryModel);
}

class CommunityRepository implements ICommunityRepository {
  CommunityRepository({required this.provider});
  final ICommunityApiProvider provider;

  Future<BaseResponse<CommunityTopic>> getTopics(QueryModel queryModel) => provider.getTopics(queryModel);
  Future<BaseResponse> createTopic(CommunityTopic data) => provider.createTopic(data);
  Future<BaseResponse> updateTopic(CommunityTopic data) => provider.updateTopic(data);
  Future<BaseResponse> deleteTopics(QueryModel queryModel) => provider.deleteTopics(queryModel);
}

