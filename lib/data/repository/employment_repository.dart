import 'package:test_flutter_web/data/barrel.dart';

abstract class IEmploymentRepository {
  Future<BaseResponse<Employment>> getEmploymentLists(QueryModel queryModel);
  Future<BaseResponse> createEmployment(Employment data);
  Future<BaseResponse> updateEmployment(Employment data);
  Future<BaseResponse> deleteEmployments(QueryModel queryModel);
  Future<BaseResponse<WorkplaceDetail>> getWorkplaceDetailLists(QueryModel queryModel);
  Future<BaseResponse> createWorkplace(WorkplaceDetail data);
  Future<BaseResponse> updateWorkplace(WorkplaceDetail data);
  Future<BaseResponse> deleteWorkplaces(QueryModel queryModel);
}

class EmploymentRepository implements IEmploymentRepository {
  EmploymentRepository({required this.provider});
  final IEmploymentProvider provider;

  Future<BaseResponse<Employment>> getEmploymentLists(QueryModel queryModel) => provider.getEmploymentLists(queryModel);
  Future<BaseResponse> createEmployment(Employment data) => provider.createEmployment(data);
  Future<BaseResponse> updateEmployment(Employment data) => provider.updateEmployment(data);
  Future<BaseResponse> deleteEmployments(QueryModel queryModel) => provider.deleteEmployments(queryModel);

  Future<BaseResponse<WorkplaceDetail>> getWorkplaceDetailLists(QueryModel queryModel) => provider.getWorkplaceDetailLists(queryModel);
  Future<BaseResponse> createWorkplace(WorkplaceDetail data) => provider.createWorkplace(data);
  Future<BaseResponse> updateWorkplace(WorkplaceDetail data) => provider.updateWorkplace(data);
  Future<BaseResponse> deleteWorkplaces(QueryModel queryModel) => provider.deleteWorkplaces(queryModel);
}