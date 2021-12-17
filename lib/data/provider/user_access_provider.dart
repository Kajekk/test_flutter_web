import 'dart:convert';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/data/provider/barrel.dart';
import 'package:test_flutter_web/utils/barrel.dart';

abstract class IUserAccessApiProvider {
  Future<BaseResponse<Permission>> getPermissions(QueryModel queryModel);
  Future<BaseResponse> createPermission(Permission data);
  Future<BaseResponse> updatePermission(Permission data);
  Future<BaseResponse> deletePermissions(QueryModel queryModel);

  Future<BaseResponse<PermissionModule>> getPermissionModules(QueryModel queryModel);
  Future<BaseResponse> createPermissionModule(PermissionModule data);
  Future<BaseResponse> updatePermissionModule(PermissionModule data);
  Future<BaseResponse> deletePermissionModules(QueryModel queryModel);

  Future<BaseResponse<Role>> getRoles(QueryModel queryModel);
  Future<BaseResponse> createRole(Role data);
  Future<BaseResponse> updateRole(Role data);
  Future<BaseResponse> deleteRoles(QueryModel queryModel);

  Future<BaseResponse<Organisation>> getOrganisations(QueryModel queryModel);
  Future<BaseResponse> createOrganisation(Organisation data);
  Future<BaseResponse> updateOrganisation(Organisation data);
  Future<BaseResponse> deleteOrganisations(QueryModel queryModel);
}

class UserAccessApiProvider extends BaseProvider with IUserAccessApiProvider {
  Future<BaseResponse<Permission>> getPermissions(
      QueryModel queryModel) async {
    var query = parsedQuery(queryModel.toJson())!;
    var rs = await get(ApiPath.PermissionUri, query: query);
    BaseResponse<Permission> baseResponse = BaseResponse.fromJson(
        rs.body, (json) => Permission.fromJson(json as Map<String, dynamic>));
    return baseResponse;
  }

  Future<BaseResponse> createPermission(Permission data) async {
    var rs = await post(ApiPath.PermissionUri, data.toJson());
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> updatePermission(Permission data) async {
    var query = {
      "id": data.id,
    };
    var rs = await put(ApiPath.PermissionUri, data.toJson(), query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> deletePermissions(QueryModel queryModel) async {
    var query = {
      "q": jsonEncode(queryModel.toJson()),
    };
    var rs = await delete(ApiPath.PermissionUri, query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse<PermissionModule>> getPermissionModules(
      QueryModel queryModel) async {
    var query = parsedQuery(queryModel.toJson())!;
    var rs = await get(ApiPath.PermissionModuleUri, query: query);
    BaseResponse<PermissionModule> baseResponse = BaseResponse.fromJson(
        rs.body, (json) => PermissionModule.fromJson(json as Map<String, dynamic>));
    return baseResponse;
  }

  Future<BaseResponse> createPermissionModule(PermissionModule data) async {
    var rs = await post(ApiPath.PermissionModuleUri, data.toJson());
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> updatePermissionModule(PermissionModule data) async {
    var query = {
      "id": data.id,
    };
    var rs = await put(ApiPath.PermissionModuleUri, data.toJson(), query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> deletePermissionModules(QueryModel queryModel) async {
    var query = {
      "q": jsonEncode(queryModel.toJson()),
    };
    var rs = await delete(ApiPath.PermissionModuleUri, query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse<Role>> getRoles(
      QueryModel queryModel) async {
    var query = parsedQuery(queryModel.toJson())!;
    var rs = await get(ApiPath.RoleUri, query: query);
    BaseResponse<Role> baseResponse = BaseResponse.fromJson(
        rs.body, (json) => Role.fromJson(json as Map<String, dynamic>));
    return baseResponse;
  }

  Future<BaseResponse> createRole(Role data) async {
    var rs = await post(ApiPath.RoleUri, data.toJson());
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> updateRole(Role data) async {
    var query = {
      "id": data.id,
    };
    var rs = await put(ApiPath.RoleUri, data.toJson(), query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> deleteRoles(QueryModel queryModel) async {
    var query = {
      "q": jsonEncode(queryModel.toJson()),
    };
    var rs = await delete(ApiPath.RoleUri, query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse<Organisation>> getOrganisations(
      QueryModel queryModel) async {
    var query = parsedQuery(queryModel.toJson())!;
    var rs = await get(ApiPath.OrganisationUri, query: query);
    BaseResponse<Organisation> baseResponse = BaseResponse.fromJson(
        rs.body, (json) => Organisation.fromJson(json as Map<String, dynamic>));
    return baseResponse;
  }

  Future<BaseResponse> createOrganisation(Organisation data) async {
    var rs = await post(ApiPath.OrganisationUri, data.toJson());
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> updateOrganisation(Organisation data) async {
    var query = {
      "id": data.id,
    };
    var rs = await put(ApiPath.OrganisationUri, data.toJson(), query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> deleteOrganisations(QueryModel queryModel) async {
    var query = {
      "q": jsonEncode(queryModel.toJson()),
    };
    var rs = await delete(ApiPath.OrganisationUri, query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }
}