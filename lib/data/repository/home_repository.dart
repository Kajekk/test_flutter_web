import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/data/models/barrel.dart';

abstract class IHomeRepository {
  Future<BaseResponse<Quote>> getQuoteList(QueryModel queryModel);
  Future<BaseResponse> createQuote(Quote data);
  Future<BaseResponse> updateQuote(Quote data);
  Future<BaseResponse> deleteQuotes(QueryModel queryModel);
}

class HomeRepository implements IHomeRepository {
  HomeRepository({required this.provider});
  final IHomeProvider provider;

  Future<BaseResponse<Quote>> getQuoteList(QueryModel queryModel) => provider.getQuoteList(queryModel);
  Future<BaseResponse> createQuote(Quote data) => provider.createQuote(data);
  Future<BaseResponse> updateQuote(Quote data) => provider.updateQuote(data);
  Future<BaseResponse> deleteQuotes(QueryModel queryModel) => provider.deleteQuotes(queryModel);
}