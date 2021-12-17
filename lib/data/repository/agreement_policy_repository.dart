import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/data/provider/barrel.dart';

abstract class IAgreementAndPolicyRepository {
  Future<BaseResponse<Agreement>> getAgreements(QueryModel queryModel);
  Future<BaseResponse> createAgreement(Agreement data);
  Future<BaseResponse> updateAgreement(Agreement data);
  Future<BaseResponse> deleteAgreements(QueryModel queryModel);

  Future<BaseResponse<Policy>> getPolicies(QueryModel queryModel);
  Future<BaseResponse> createPolicy(Policy data);
  Future<BaseResponse> updatePolicy(Policy data);
  Future<BaseResponse> deletePolicies(QueryModel queryModel);
}

class AgreementAndPolicyRepository implements IAgreementAndPolicyRepository {
  AgreementAndPolicyRepository({required this.provider});
  final IAgreementAndPolicyProvider provider;

  Future<BaseResponse<Agreement>> getAgreements(QueryModel queryModel) => provider.getAgreements(queryModel);
  Future<BaseResponse> createAgreement(Agreement data) => provider.createAgreement(data);
  Future<BaseResponse> updateAgreement(Agreement data) => provider.updateAgreement(data);
  Future<BaseResponse> deleteAgreements(QueryModel queryModel) => provider.deleteAgreements(queryModel);

  Future<BaseResponse<Policy>> getPolicies(QueryModel queryModel) => provider.getPolicies(queryModel);
  Future<BaseResponse> createPolicy(Policy data) => provider.createPolicy(data);
  Future<BaseResponse> updatePolicy(Policy data) => provider.updatePolicy(data);
  Future<BaseResponse> deletePolicies(QueryModel queryModel) => provider.deletePolicies(queryModel);
}
