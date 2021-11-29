import 'dart:convert';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/utils/barrel.dart';

import 'barrel.dart';

abstract class ISupportProvider {
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

class SupportProvider extends BaseProvider with ISupportProvider {
  Future<BaseResponse<AttendanceModel>> getAttendanceList(QueryModel queryModel) async {
    var query = parsedQuery(queryModel.toJson())!;
    var rs = await get(ApiPath.GetAttendanceList, query: query);
    BaseResponse<AttendanceModel> baseResponse = BaseResponse.fromJson(
        rs.body,
            (json) => AttendanceModel.fromJson(json as Map<String, dynamic>));
    return baseResponse;
  }

  Future<BaseResponse> createAttendance(AttendanceModel data) async {
    var rs = await post(ApiPath.CreateAttendance, data.toJson());
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> updateAttendance(AttendanceModel data) async {
    var query = {
      "id": data.id,
    };
    var rs = await put(ApiPath.UpdateAttendance, data.toJson(), query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> deleteAttendances(QueryModel queryModel) async {
    var query = {
      "q": jsonEncode(queryModel.toJson()),
    };
    var rs = await delete(ApiPath.DeleteAttendances, query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse<SupportMetric>> getSupportMetricList(QueryModel queryModel) async {
    var query = parsedQuery(queryModel.toJson())!;
    var rs = await get(ApiPath.SupportMetricUri, query: query);
    BaseResponse<SupportMetric> baseResponse = BaseResponse.fromJson(
        rs.body,
            (json) => SupportMetric.fromJson(json as Map<String, dynamic>));
    return baseResponse;
  }

  Future<BaseResponse> createSupportMetric(SupportMetric data) async {
    var rs = await post(ApiPath.SupportMetricUri, data.toJson());
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> updateSupportMetric(SupportMetric data) async {
    var query = {
      "id": data.id,
    };
    var rs = await put(ApiPath.SupportMetricUri, data.toJson(), query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> deleteSupportMetrics(QueryModel queryModel) async {
    var query = {
      "q": jsonEncode(queryModel.toJson()),
    };
    var rs = await delete(ApiPath.SupportMetricUri, query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse<SupportLog>> getSupportLogList(QueryModel queryModel) async {
    var query = parsedQuery(queryModel.toJson())!;
    var rs = await get(ApiPath.SupportLogUri, query: query);
    BaseResponse<SupportLog> baseResponse = BaseResponse.fromJson(
        rs.body,
            (json) => SupportLog.fromJson(json as Map<String, dynamic>));
    return baseResponse;
  }

  Future<BaseResponse> createSupportLog(SupportLog data) async {
    var rs = await post(ApiPath.SupportLogUri, data.toJson());
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> updateSupportLog(SupportLog data) async {
    var query = {
      "id": data.id,
    };
    var rs = await put(ApiPath.SupportLogUri, data.toJson(), query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> deleteSupportLogs(QueryModel queryModel) async {
    var query = {
      "q": jsonEncode(queryModel.toJson()),
    };
    var rs = await delete(ApiPath.SupportLogUri, query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse<LocationTracking>> getLocationTrackingList(QueryModel queryModel) async {
    var query = parsedQuery(queryModel.toJson())!;
    var rs = await get(ApiPath.LocationTrackingUri, query: query);
    BaseResponse<LocationTracking> baseResponse = BaseResponse.fromJson(
        rs.body,
            (json) => LocationTracking.fromJson(json as Map<String, dynamic>));
    return baseResponse;
  }

  Future<BaseResponse> createLocationTracking(LocationTracking data) async {
    var rs = await post(ApiPath.LocationTrackingUri, data.toJson());
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> updateLocationTracking(LocationTracking data) async {
    var query = {
      "id": data.id,
    };
    var rs = await put(ApiPath.LocationTrackingUri, data.toJson(), query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> deleteLocationTrackings(QueryModel queryModel) async {
    var query = {
      "q": jsonEncode(queryModel.toJson()),
    };
    var rs = await delete(ApiPath.LocationTrackingUri, query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }
}