import 'dart:convert';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/utils/helpers.dart';

abstract class IEmploymentProvider {
  Future<BaseResponse<Employment>> getEmploymentLists(QueryModel queryModel);
  Future<BaseResponse> createEmployment(Employment data);
  Future<BaseResponse> updateEmployment(Employment data);
  Future<BaseResponse> deleteEmployments(QueryModel queryModel);

  Future<BaseResponse<WorkplaceDetail>> getWorkplaceDetailLists(QueryModel queryModel);
  Future<BaseResponse> createWorkplace(WorkplaceDetail data);
  Future<BaseResponse> updateWorkplace(WorkplaceDetail data);
  Future<BaseResponse> deleteWorkplaces(QueryModel queryModel);

  Future<BaseResponse<ProWorkSchedule>> getProScheduleLists(QueryModel queryModel);
  Future<BaseResponse> createProSchedule(ProWorkSchedule data);
  Future<BaseResponse> updateProSchedule(ProWorkSchedule data);
  Future<BaseResponse> deleteProSchedules(QueryModel queryModel);

  Future<BaseResponse<ContactForm>> getContactForms(QueryModel queryModel);
  Future<BaseResponse> deleteContactForms(QueryModel queryModel);
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

  Future<BaseResponse> createEmployment(Employment data) async {
    var rs = await post(ApiPath.CreateEmployment, data.toJson());
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> updateEmployment(Employment data) async {
    var query = {
      "id": data.id,
    };
    var rs = await put(ApiPath.UpdateEmployment, data.toJson(), query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> deleteEmployments(QueryModel queryModel) async {
    var query = {
      "q": jsonEncode(queryModel.toJson()),
    };
    var rs = await delete(ApiPath.DeleteEmployments, query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse<WorkplaceDetail>> getWorkplaceDetailLists(QueryModel queryModel) async {
    var query = parsedQuery(queryModel.toJson())!;
    var rs = await get(ApiPath.GetWorkplaceDetailLists, query: query);
    BaseResponse<WorkplaceDetail> baseResponse = BaseResponse.fromJson(
        rs.body,
            (json) => WorkplaceDetail.fromJson(json as Map<String, dynamic>));
    return baseResponse;
  }

  Future<BaseResponse> createWorkplace(WorkplaceDetail data) async {
    var rs = await post(ApiPath.CreateWorkplace, data.toJson());
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> updateWorkplace(WorkplaceDetail data) async {
    var query = {
      "id": data.id,
    };
    var rs = await put(ApiPath.UpdateWorkplace, data.toJson(), query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> deleteWorkplaces(QueryModel queryModel) async {
    var query = {
      "q": jsonEncode(queryModel.toJson()),
    };
    var rs = await delete(ApiPath.DeleteWorkplaces, query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse<ProWorkSchedule>> getProScheduleLists(QueryModel queryModel) async {
    var query = parsedQuery(queryModel.toJson())!;
    var rs = await get(ApiPath.ProScheduleUri, query: query);
    BaseResponse<ProWorkSchedule> baseResponse = BaseResponse.fromJson(
        rs.body,
            (json) => ProWorkSchedule.fromJson(json as Map<String, dynamic>));
    return baseResponse;
  }

  Future<BaseResponse> createProSchedule(ProWorkSchedule data) async {
    var rs = await post(ApiPath.ProScheduleUri, data.toJson());
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> updateProSchedule(ProWorkSchedule data) async {
    var query = {
      "id": data.id,
    };
    var rs = await put(ApiPath.ProScheduleUri, data.toJson(), query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> deleteProSchedules(QueryModel queryModel) async {
    var query = {
      "q": jsonEncode(queryModel.toJson()),
    };
    var rs = await delete(ApiPath.ProScheduleUri, query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse<ContactForm>> getContactForms(QueryModel queryModel) async {
    var query = parsedQuery(queryModel.toJson())!;
    var rs = await get(ApiPath.ContactFormUri, query: query);
    BaseResponse<ContactForm> baseResponse = BaseResponse.fromJson(
        rs.body,
            (json) => ContactForm.fromJson(json as Map<String, dynamic>));
    return baseResponse;
  }

  Future<BaseResponse> deleteContactForms(QueryModel queryModel) async {
    var query = {
      "q": jsonEncode(queryModel.toJson()),
    };
    var rs = await delete(ApiPath.ContactFormUri, query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }
}