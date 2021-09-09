import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/utils/helpers.dart';

abstract class IEmploymentProvider {
  Future<BaseResponse<Employment>> getEmploymentLists(QueryModel queryModel);
}

class EmploymentProvider extends BaseProvider with IEmploymentProvider {
  Future<BaseResponse<Employment>> getEmploymentLists(QueryModel queryModel) async {
    var query = parsedQuery(queryModel.toJson())!;
    var rs = await get(ApiPath.GetEmploymentLists, query: query);
    BaseResponse<Employment> baseResponse = BaseResponse.fromJson(
        rs.body,
            (json) => Employment.fromJson(json as Map<String, dynamic>));
    return baseResponse;
  }
}