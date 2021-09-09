import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/data/provider/support_provider.dart';

abstract class ISupportRepository {
  Future<BaseResponse<AttendanceModel>> getAttendanceList(QueryModel queryModel);
}

class SupportRepository implements ISupportRepository {
  SupportRepository({required this.provider});
  final ISupportProvider provider;

  Future<BaseResponse<AttendanceModel>> getAttendanceList(QueryModel queryModel) => provider.getAttendanceList(queryModel);
}