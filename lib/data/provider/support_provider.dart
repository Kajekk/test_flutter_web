import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/utils/barrel.dart';

import 'barrel.dart';

abstract class ISupportProvider {
  Future<BaseResponse<AttendanceModel>> getAttendanceList(QueryModel queryModel);
  Future<BaseResponse> createAttendance(AttendanceModel data);
  Future<BaseResponse> updateAttendance(AttendanceModel data);
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
}