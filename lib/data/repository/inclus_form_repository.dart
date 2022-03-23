import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/data/provider/barrel.dart';

abstract class IInclusFormRepository {
  Future<BaseResponse<InclusiveEmploymentForm>> getInclusiveEmploymentFormList(QueryModel queryModel);
  Future<BaseResponse> createInclusiveEmploymentForm(InclusiveEmploymentForm data);
  Future<BaseResponse> updateInclusiveEmploymentForm(InclusiveEmploymentForm data);
  Future<BaseResponse> deleteInclusiveEmploymentForms(QueryModel queryModel);

  Future<BaseResponse<ContactUsForm>> getContactUsFormList(QueryModel queryModel);
  Future<BaseResponse> createContactUsForm(ContactUsForm data);
  Future<BaseResponse> updateContactUsForm(ContactUsForm data);
  Future<BaseResponse> deleteContactUsForms(QueryModel queryModel);
}

class InclusFormRepository implements IInclusFormRepository {
  InclusFormRepository({required this.provider});
  final IInclusFormProvider provider;

  Future<BaseResponse<InclusiveEmploymentForm>> getInclusiveEmploymentFormList(QueryModel queryModel) => provider.getInclusiveEmploymentFormList(queryModel);
  Future<BaseResponse> createInclusiveEmploymentForm(InclusiveEmploymentForm data) => provider.createInclusiveEmploymentForm(data);
  Future<BaseResponse> updateInclusiveEmploymentForm(InclusiveEmploymentForm data) => provider.updateInclusiveEmploymentForm(data);
  Future<BaseResponse> deleteInclusiveEmploymentForms(QueryModel queryModel) => provider.deleteInclusiveEmploymentForms(queryModel);

  Future<BaseResponse<ContactUsForm>> getContactUsFormList(QueryModel queryModel) => provider.getContactUsFormList(queryModel);
  Future<BaseResponse> createContactUsForm(ContactUsForm data) => provider.createContactUsForm(data);
  Future<BaseResponse> updateContactUsForm(ContactUsForm data) => provider.updateContactUsForm(data);
  Future<BaseResponse> deleteContactUsForms(QueryModel queryModel) => provider.deleteContactUsForms(queryModel);
}