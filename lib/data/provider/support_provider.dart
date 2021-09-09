import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/utils/barrel.dart';

import 'barrel.dart';

abstract class ISupportProvider {
  Future<BaseResponse<AttendanceModel>> getAttendanceList(QueryModel queryModel);
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
}