import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/data/models/base_response.dart';
import 'package:test_flutter_web/data/models/emotional_log.dart';
import 'package:test_flutter_web/data/models/query_models.dart';
import 'package:test_flutter_web/data/provider/barrel.dart';

abstract class IEmotionalRepository {
  Future<BaseResponse<EmotionalLog>> getEmotionalLogs(QueryModel queryModel);
  Future<BaseResponse> createEmotionalLog(EmotionalLog data);
  Future<BaseResponse> updateEmotionalLog(EmotionalLog data);
  Future<BaseResponse> deleteEmotionalLogs(QueryModel queryModel);

  Future<BaseResponse<EmotionType>> getEmotionalTypes(QueryModel queryModel);
  Future<BaseResponse> createEmotionalType(EmotionType data);
  Future<BaseResponse> updateEmotionalType(EmotionType data);
  Future<BaseResponse> deleteEmotionalType(QueryModel queryModel);
}

class EmotionalRepository implements IEmotionalRepository {
  EmotionalRepository({required this.provider});
  final IEmotionalApiProvider provider;

  Future<BaseResponse<EmotionalLog>> getEmotionalLogs(QueryModel queryModel) => provider.getEmotionalLogs(queryModel);
  Future<BaseResponse> createEmotionalLog(EmotionalLog data) => provider.createEmotionalLog(data);
  Future<BaseResponse> updateEmotionalLog(EmotionalLog data) => provider.updateEmotionalLog(data);
  Future<BaseResponse> deleteEmotionalLogs(QueryModel queryModel) => provider.deleteEmotionalLogs(queryModel);

  Future<BaseResponse<EmotionType>> getEmotionalTypes(QueryModel queryModel) => provider.getEmotionalTypes(queryModel);
  Future<BaseResponse> createEmotionalType(EmotionType data) => provider.createEmotionalType(data);
  Future<BaseResponse> updateEmotionalType(EmotionType data) => provider.updateEmotionalType(data);
  Future<BaseResponse> deleteEmotionalType(QueryModel queryModel) => provider.deleteEmotionalType(queryModel);
}