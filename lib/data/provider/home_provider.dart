import 'dart:convert';

import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/utils/barrel.dart';
import 'barrel.dart';

abstract class IHomeProvider {
  Future<BaseResponse<Quote>> getQuoteList(QueryModel queryModel);
  Future<BaseResponse> createQuote(Quote data);
  Future<BaseResponse> updateQuote(Quote data);
  Future<BaseResponse> deleteQuotes(QueryModel queryModel);
}

class HomeProvider extends BaseProvider with IHomeProvider {
  Future<BaseResponse<Quote>> getQuoteList(QueryModel queryModel) async {
    var query = parsedQuery(queryModel.toJson())!;
    var rs = await get(ApiPath.GetQuoteList, query: query);
    BaseResponse<Quote> baseResponse = BaseResponse.fromJson(
        rs.body,
            (json) => Quote.fromJson(json as Map<String, dynamic>));
    return baseResponse;
  }

  Future<BaseResponse> createQuote(Quote data) async {
    var rs = await post(ApiPath.CreateQuote, data.toJson());
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> updateQuote(Quote data) async {
    var query = {
      "id": data.id,
    };
    var rs = await put(ApiPath.UpdateQuote, data.toJson(), query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> deleteQuotes(QueryModel queryModel) async {
    var query = {
      "q": jsonEncode(queryModel.toJson()),
    };
    var rs = await delete(ApiPath.DeleteQuotes, query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }
}