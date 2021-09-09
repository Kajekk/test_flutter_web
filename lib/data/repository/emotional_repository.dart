import 'package:test_flutter_web/data/models/base_response.dart';
import 'package:test_flutter_web/data/models/emotional_log.dart';
import 'package:test_flutter_web/data/models/query_models.dart';
import 'package:test_flutter_web/data/provider/barrel.dart';

abstract class IEmotionalRepository {
  Future<BaseResponse<EmotionalLog>> getEmotionalLogs(QueryModel queryModel);
}

class EmotionalRepository implements IEmotionalRepository {
  EmotionalRepository({required this.provider});
  final IEmotionalApiProvider provider;

  Future<BaseResponse<EmotionalLog>> getEmotionalLogs(QueryModel queryModel) => provider.getEmotionalLogs(queryModel);
}