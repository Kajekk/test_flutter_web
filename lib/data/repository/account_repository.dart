import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/data/provider/barrel.dart';

abstract class IAccountRepository {
  Future<BaseResponse<Account>> getAccounts(QueryModel queryModel);
  Future<BaseResponse> createAccount(Account data);
  Future<BaseResponse> updateAccount(Account data);
  Future<BaseResponse> deleteAccounts(QueryModel queryModel);
}

class AccountRepository implements IAccountRepository {
  AccountRepository({required this.provider});
  final IAccountApiProvider provider;

  Future<BaseResponse<Account>> getAccounts(QueryModel queryModel) => provider.getAccounts(queryModel);
  Future<BaseResponse> createAccount(Account data) => provider.createAccount(data);
  Future<BaseResponse> updateAccount(Account data) => provider.updateAccount(data);
  Future<BaseResponse> deleteAccounts(QueryModel queryModel) => provider.deleteAccounts(queryModel);
}