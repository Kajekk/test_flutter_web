import 'dart:convert';

import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/utils/barrel.dart';

abstract class IAgreementAndPolicyProvider {
  Future<BaseResponse<Agreement>> getAgreements(QueryModel queryModel);
  Future<BaseResponse> createAgreement(Agreement data);
  Future<BaseResponse> updateAgreement(Agreement data);
  Future<BaseResponse> deleteAgreements(QueryModel queryModel);

  Future<BaseResponse<Policy>> getPolicies(QueryModel queryModel);
  Future<BaseResponse> createPolicy(Policy data);
  Future<BaseResponse> updatePolicy(Policy data);
  Future<BaseResponse> deletePolicies(QueryModel queryModel);
}

class AgreementAndPolicyApiProvider extends BaseProvider with IAgreementAndPolicyProvider {
  Future<BaseResponse<Agreement>> getAgreements(
      QueryModel queryModel) async {
    var query = parsedQuery(queryModel.toJson())!;
    var rs = await get(ApiPath.TermOfServiceUri, query: query);
    BaseResponse<Agreement> baseResponse = BaseResponse.fromJson(
        rs.body, (json) => Agreement.fromJson(json as Map<String, dynamic>));
    return baseResponse;
  }

  Future<BaseResponse> createAgreement(Agreement data) async {
    var rs = await post(ApiPath.TermOfServiceUri, data.toJson());
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> updateAgreement(Agreement data) async {
    var query = {
      "id": data.id,
    };
    var rs = await put(ApiPath.TermOfServiceUri, data.toJson(), query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> deleteAgreements(QueryModel queryModel) async {
    var query = {
      "q": jsonEncode(queryModel.toJson()),
    };
    var rs = await delete(ApiPath.TermOfServiceUri, query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse<Policy>> getPolicies(
      QueryModel queryModel) async {
    var query = parsedQuery(queryModel.toJson())!;
    var rs = await get(ApiPath.PolicyUri, query: query);
    BaseResponse<Policy> baseResponse = BaseResponse.fromJson(
        rs.body, (json) => Policy.fromJson(json as Map<String, dynamic>));
    return baseResponse;
  }

  Future<BaseResponse> createPolicy(Policy data) async {
    var rs = await post(ApiPath.PolicyUri, data.toJson());
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> updatePolicy(Policy data) async {
    var query = {
      "id": data.id,
    };
    var rs = await put(ApiPath.PolicyUri, data.toJson(), query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> deletePolicies(QueryModel queryModel) async {
    var query = {
      "q": jsonEncode(queryModel.toJson()),
    };
    var rs = await delete(ApiPath.PolicyUri, query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }
}