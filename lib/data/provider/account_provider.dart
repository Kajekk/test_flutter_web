import 'dart:convert';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/data/provider/barrel.dart';
import 'package:test_flutter_web/utils/barrel.dart';

abstract class IAccountApiProvider {
  Future<BaseResponse<Account>> getAccounts(QueryModel queryModel);
  Future<BaseResponse> createAccount(Account data);
  Future<BaseResponse> updateAccount(Account data);
  Future<BaseResponse> deleteAccounts(QueryModel queryModel);
}

class AccountApiProvider extends BaseProvider with IAccountApiProvider {
  Future<BaseResponse<Account>> getAccounts(
      QueryModel queryModel) async {
    var query = parsedQuery(queryModel.toJson())!;
    var rs = await get(ApiPath.AccountUri, query: query);
    BaseResponse<Account> baseResponse = BaseResponse.fromJson(
        rs.body, (json) => Account.fromJson(json as Map<String, dynamic>));
    return baseResponse;
  }

  Future<BaseResponse> createAccount(Account data) async {
    var rs = await post(ApiPath.AccountUri, data.toJson());
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> updateAccount(Account data) async {
    var query = {
      "id": data.id,
    };
    var rs = await put(ApiPath.AccountUri, data.toJson(), query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> deleteAccounts(QueryModel queryModel) async {
    var query = {
      "q": jsonEncode(queryModel.toJson()),
    };
    var rs = await delete(ApiPath.AccountUri, query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }
}