import 'package:test_flutter_web/data/barrel.dart';

abstract class IEmploymentRepository {
  Future<BaseResponse<Employment>> getEmploymentLists(QueryModel queryModel);
}

class EmploymentRepository implements IEmploymentRepository {
  EmploymentRepository({required this.provider});
  final IEmploymentProvider provider;

  Future<BaseResponse<Employment>> getEmploymentLists(QueryModel queryModel) => provider.getEmploymentLists(queryModel);
}