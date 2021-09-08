import 'package:test_flutter_web/data/models/base_response.dart';
import 'package:test_flutter_web/data/models/emotional_log.dart';
import 'package:test_flutter_web/data/provider/barrel.dart';

class EmotionalRepository {
  final EmotionalApiProvider _emotionalApiProvider = EmotionalApiProvider();

  Future<BaseResponse<EmotionalLog>?> getEmotionalLogs(int offset, limit) => _emotionalApiProvider.getEmotionalLogs(offset, limit);
}