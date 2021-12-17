import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/data/provider/barrel.dart';

abstract class IUserAccessRepository {
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

class UserAccessRepository implements IUserAccessRepository {
  UserAccessRepository({required this.provider});
  final IUserAccessApiProvider provider;

  Future<BaseResponse<Permission>> getPermissions(QueryModel queryModel) => provider.getPermissions(queryModel);
  Future<BaseResponse> createPermission(Permission data) => provider.createPermission(data);
  Future<BaseResponse> updatePermission(Permission data) => provider.updatePermission(data);
  Future<BaseResponse> deletePermissions(QueryModel queryModel) => provider.deletePermissions(queryModel);

  Future<BaseResponse<PermissionModule>> getPermissionModules(QueryModel queryModel) => provider.getPermissionModules(queryModel);
  Future<BaseResponse> createPermissionModule(PermissionModule data) => provider.createPermissionModule(data);
  Future<BaseResponse> updatePermissionModule(PermissionModule data) => provider.updatePermissionModule(data);
  Future<BaseResponse> deletePermissionModules(QueryModel queryModel) => provider.deletePermissionModules(queryModel);

  Future<BaseResponse<Role>> getRoles(QueryModel queryModel) => provider.getRoles(queryModel);
  Future<BaseResponse> createRole(Role data) => provider.createRole(data);
  Future<BaseResponse> updateRole(Role data) => provider.updateRole(data);
  Future<BaseResponse> deleteRoles(QueryModel queryModel) => provider.deleteRoles(queryModel);

  Future<BaseResponse<Organisation>> getOrganisations(QueryModel queryModel) => provider.getOrganisations(queryModel);
  Future<BaseResponse> createOrganisation(Organisation data) => provider.createOrganisation(data);
  Future<BaseResponse> updateOrganisation(Organisation data) => provider.updateOrganisation(data);
  Future<BaseResponse> deleteOrganisations(QueryModel queryModel) => provider.deleteOrganisations(queryModel);
}