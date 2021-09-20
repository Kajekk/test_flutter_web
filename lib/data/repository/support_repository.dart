import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/data/provider/barrel.dart';

abstract class ISupportRepository {
  Future<BaseResponse<AttendanceModel>> getAttendanceList(QueryModel queryModel);
  Future<BaseResponse> createAttendance(AttendanceModel data);
  Future<BaseResponse> updateAttendance(AttendanceModel data);
}

class SupportRepository implements ISupportRepository {
  SupportRepository({required this.provider});
  final ISupportProvider provider;

  Future<BaseResponse<AttendanceModel>> getAttendanceList(QueryModel queryModel) => provider.getAttendanceList(queryModel);
  Future<BaseResponse> createAttendance(AttendanceModel data) => provider.createAttendance(data);
  Future<BaseResponse> updateAttendance(AttendanceModel data) => provider.updateAttendance(data);
}