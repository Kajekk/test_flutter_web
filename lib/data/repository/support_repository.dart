import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/data/provider/barrel.dart';

abstract class ISupportRepository {
  Future<BaseResponse<AttendanceModel>> getAttendanceList(QueryModel queryModel);
  Future<BaseResponse> createAttendance(AttendanceModel data);
  Future<BaseResponse> updateAttendance(AttendanceModel data);
  Future<BaseResponse> deleteAttendances(QueryModel queryModel);

  Future<BaseResponse<SupportMetric>> getSupportMetricList(QueryModel queryModel);
  Future<BaseResponse> createSupportMetric(SupportMetric data);
  Future<BaseResponse> updateSupportMetric(SupportMetric data);
  Future<BaseResponse> deleteSupportMetrics(QueryModel queryModel);

  Future<BaseResponse<SupportLog>> getSupportLogList(QueryModel queryModel);
  Future<BaseResponse> createSupportLog(SupportLog data);
  Future<BaseResponse> updateSupportLog(SupportLog data);
  Future<BaseResponse> deleteSupportLogs(QueryModel queryModel);

  Future<BaseResponse<LocationTracking>> getLocationTrackingList(QueryModel queryModel);
  Future<BaseResponse> createLocationTracking(LocationTracking data);
  Future<BaseResponse> updateLocationTracking(LocationTracking data);
  Future<BaseResponse> deleteLocationTrackings(QueryModel queryModel);
}

class SupportRepository implements ISupportRepository {
  SupportRepository({required this.provider});
  final ISupportProvider provider;

  Future<BaseResponse<AttendanceModel>> getAttendanceList(QueryModel queryModel) => provider.getAttendanceList(queryModel);
  Future<BaseResponse> createAttendance(AttendanceModel data) => provider.createAttendance(data);
  Future<BaseResponse> updateAttendance(AttendanceModel data) => provider.updateAttendance(data);
  Future<BaseResponse> deleteAttendances(QueryModel queryModel) => provider.deleteAttendances(queryModel);

  Future<BaseResponse<SupportMetric>> getSupportMetricList(QueryModel queryModel) => provider.getSupportMetricList(queryModel);
  Future<BaseResponse> createSupportMetric(SupportMetric data) => provider.createSupportMetric(data);
  Future<BaseResponse> updateSupportMetric(SupportMetric data) => provider.updateSupportMetric(data);
  Future<BaseResponse> deleteSupportMetrics(QueryModel queryModel) => provider.deleteSupportMetrics(queryModel);

  Future<BaseResponse<SupportLog>> getSupportLogList(QueryModel queryModel) => provider.getSupportLogList(queryModel);
  Future<BaseResponse> createSupportLog(SupportLog data) => provider.createSupportLog(data);
  Future<BaseResponse> updateSupportLog(SupportLog data) => provider.updateSupportLog(data);
  Future<BaseResponse> deleteSupportLogs(QueryModel queryModel) => provider.deleteSupportLogs(queryModel);

  Future<BaseResponse<LocationTracking>> getLocationTrackingList(QueryModel queryModel) => provider.getLocationTrackingList(queryModel);
  Future<BaseResponse> createLocationTracking(LocationTracking data) => provider.createLocationTracking(data);
  Future<BaseResponse> updateLocationTracking(LocationTracking data) => provider.updateLocationTracking(data);
  Future<BaseResponse> deleteLocationTrackings(QueryModel queryModel) => provider.deleteLocationTrackings(queryModel);
}