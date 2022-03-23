import 'dart:convert';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/utils/barrel.dart';
import 'barrel.dart';

abstract class IInclusFormProvider {
  Future<BaseResponse<InclusiveEmploymentForm>> getInclusiveEmploymentFormList(QueryModel queryModel);
  Future<BaseResponse> createInclusiveEmploymentForm(InclusiveEmploymentForm data);
  Future<BaseResponse> updateInclusiveEmploymentForm(InclusiveEmploymentForm data);
  Future<BaseResponse> deleteInclusiveEmploymentForms(QueryModel queryModel);

  Future<BaseResponse<ContactUsForm>> getContactUsFormList(QueryModel queryModel);
  Future<BaseResponse> createContactUsForm(ContactUsForm data);
  Future<BaseResponse> updateContactUsForm(ContactUsForm data);
  Future<BaseResponse> deleteContactUsForms(QueryModel queryModel);
}

class InclusFormProvider extends BaseProvider with IInclusFormProvider {
  Future<BaseResponse<InclusiveEmploymentForm>> getInclusiveEmploymentFormList(QueryModel queryModel) async {
    var query = parsedQuery(queryModel.toJson())!;
    var rs = await get(ApiPath.InclusiveEmploymentFormUri, query: query);
    BaseResponse<InclusiveEmploymentForm> baseResponse = BaseResponse.fromJson(
        rs.body,
            (json) => InclusiveEmploymentForm.fromJson(json as Map<String, dynamic>));
    return baseResponse;
  }

  Future<BaseResponse> createInclusiveEmploymentForm(InclusiveEmploymentForm data) async {
    var rs = await post(ApiPath.InclusiveEmploymentFormUri, data.toJson());
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> updateInclusiveEmploymentForm(InclusiveEmploymentForm data) async {
    var query = {
      "id": data.id,
    };
    var rs = await put(ApiPath.InclusiveEmploymentFormUri, data.toJson(), query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> deleteInclusiveEmploymentForms(QueryModel queryModel) async {
    var query = {
      "q": jsonEncode(queryModel.toJson()),
    };
    var rs = await delete(ApiPath.InclusiveEmploymentFormUri, query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse<ContactUsForm>> getContactUsFormList(QueryModel queryModel) async {
    var query = parsedQuery(queryModel.toJson())!;
    var rs = await get(ApiPath.ContactUsFormUri, query: query);
    BaseResponse<ContactUsForm> baseResponse = BaseResponse.fromJson(
        rs.body,
            (json) => ContactUsForm.fromJson(json as Map<String, dynamic>));
    return baseResponse;
  }

  Future<BaseResponse> createContactUsForm(ContactUsForm data) async {
    var rs = await post(ApiPath.ContactUsFormUri, data.toJson());
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> updateContactUsForm(ContactUsForm data) async {
    var query = {
      "id": data.id,
    };
    var rs = await put(ApiPath.ContactUsFormUri, data.toJson(), query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> deleteContactUsForms(QueryModel queryModel) async {
    var query = {
      "q": jsonEncode(queryModel.toJson()),
    };
    var rs = await delete(ApiPath.ContactUsFormUri, query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }
}