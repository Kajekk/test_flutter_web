import 'dart:convert';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/utils/barrel.dart';
import 'barrel.dart';

abstract class IGoalProvider {
  Future<BaseResponse<Goal>> getGoalList(QueryModel queryModel);
  Future<BaseResponse> createGoal(Goal data);
  Future<BaseResponse> updateGoal(Goal data);
  Future<BaseResponse> deleteGoals(QueryModel queryModel);

  Future<BaseResponse<GoalFrequency>> getGoalFrequencyList(QueryModel queryModel);
  Future<BaseResponse> createGoalFrequency(GoalFrequency data);
  Future<BaseResponse> updateGoalFrequency(GoalFrequency data);
  Future<BaseResponse> deleteGoalFrequencies(QueryModel queryModel);

  Future<BaseResponse<GoalRelationship>> getGoalRelationshipList(QueryModel queryModel);
  Future<BaseResponse> createGoalRelationship(GoalRelationship data);
  Future<BaseResponse> updateGoalRelationship(GoalRelationship data);
  Future<BaseResponse> deleteGoalRelationships(QueryModel queryModel);

  Future<BaseResponse<GoalTracking>> getGoalTrackingList(QueryModel queryModel);
  Future<BaseResponse> updateGoalTracking(GoalTracking data);
  Future<BaseResponse> deleteGoalTracking(QueryModel queryModel);
}

class GoalProvider extends BaseProvider with IGoalProvider {
  Future<BaseResponse<Goal>> getGoalList(QueryModel queryModel) async {
    var query = parsedQuery(queryModel.toJson())!;
    var rs = await get(ApiPath.GetGoalList, query: query);
    BaseResponse<Goal> baseResponse = BaseResponse.fromJson(
        rs.body,
            (json) => Goal.fromJson(json as Map<String, dynamic>));
    return baseResponse;
  }

  Future<BaseResponse> createGoal(Goal data) async {
    var rs = await post(ApiPath.CreateGoal, data.toJson());
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> updateGoal(Goal data) async {
    var query = {
      "id": data.id,
    };
    var rs = await put(ApiPath.UpdateGoal, data.toJson(), query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> deleteGoals(QueryModel queryModel) async {
    var query = {
      "q": jsonEncode(queryModel.toJson()),
    };
    var rs = await delete(ApiPath.DeleteGoals, query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse<GoalFrequency>> getGoalFrequencyList(QueryModel queryModel) async {
    var query = parsedQuery(queryModel.toJson())!;
    var rs = await get(ApiPath.GetGoalFrequencyList, query: query);
    BaseResponse<GoalFrequency> baseResponse = BaseResponse.fromJson(
        rs.body,
            (json) => GoalFrequency.fromJson(json as Map<String, dynamic>));
    return baseResponse;
  }

  Future<BaseResponse> createGoalFrequency(GoalFrequency data) async {
    var rs = await post(ApiPath.CreateGoalFrequency, data.toJson());
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> updateGoalFrequency(GoalFrequency data) async {
    var query = {
      "id": data.id,
    };
    var rs = await put(ApiPath.UpdateGoalFrequency, data.toJson(), query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> deleteGoalFrequencies(QueryModel queryModel) async {
    var query = {
      "q": jsonEncode(queryModel.toJson()),
    };
    var rs = await delete(ApiPath.DeleteGoalFrequencies, query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse<GoalRelationship>> getGoalRelationshipList(QueryModel queryModel) async {
    var query = parsedQuery(queryModel.toJson())!;
    var rs = await get(ApiPath.GetGoalRelationshipList, query: query);
    BaseResponse<GoalRelationship> baseResponse = BaseResponse.fromJson(
        rs.body,
            (json) => GoalRelationship.fromJson(json as Map<String, dynamic>));
    return baseResponse;
  }

  Future<BaseResponse> createGoalRelationship(GoalRelationship data) async {
    var rs = await post(ApiPath.CreateGoalRelationship, data.toJson());
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> updateGoalRelationship(GoalRelationship data) async {
    var query = {
      "id": data.id,
    };
    var rs = await put(ApiPath.UpdateGoalRelationship, data.toJson(), query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> deleteGoalRelationships(QueryModel queryModel) async {
    var query = {
      "q": jsonEncode(queryModel.toJson()),
    };
    var rs = await delete(ApiPath.DeleteGoalRelationships, query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse<GoalTracking>> getGoalTrackingList(QueryModel queryModel) async {
    var query = parsedQuery(queryModel.toJson())!;
    var rs = await get(ApiPath.GoalTrackingUri, query: query);
    BaseResponse<GoalTracking> baseResponse = BaseResponse.fromJson(
        rs.body,
            (json) => GoalTracking.fromJson(json as Map<String, dynamic>));
    return baseResponse;
  }

  Future<BaseResponse> updateGoalTracking(GoalTracking data) async {
    var query = {
      "id": data.id,
    };
    var rs = await put(ApiPath.GoalTrackingUri, data.toJson(), query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse> deleteGoalTracking(QueryModel queryModel) async {
    var query = {
      "q": jsonEncode(queryModel.toJson()),
    };
    var rs = await delete(ApiPath.GoalTrackingUri, query: query);
    BaseResponse baseResponse = BaseResponse.fromJson(rs.body, (json) => null);
    return baseResponse;
  }
}