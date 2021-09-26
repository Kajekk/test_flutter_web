import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/data/provider/barrel.dart';

abstract class IGoalRepository {
  Future<BaseResponse<Goal>> getGoalList(QueryModel queryModel);
  Future<BaseResponse> createGoal(Goal data);
  Future<BaseResponse> updateGoal(Goal data);
  Future<BaseResponse<GoalFrequency>> getGoalFrequencyList(QueryModel queryModel);
  Future<BaseResponse> createGoalFrequency(GoalFrequency data);
  Future<BaseResponse> updateGoalFrequency(GoalFrequency data);

  Future<BaseResponse<GoalRelationship>> getGoalRelationshipList(QueryModel queryModel);
  Future<BaseResponse> createGoalRelationship(GoalRelationship data);
  // Future<BaseResponse> updateGoalFrequency(GoalFrequency data);
}

class GoalRepository implements IGoalRepository {
  GoalRepository({required this.provider});
  final IGoalProvider provider;

  Future<BaseResponse<Goal>> getGoalList(QueryModel queryModel) => provider.getGoalList(queryModel);
  Future<BaseResponse> createGoal(Goal data) => provider.createGoal(data);
  Future<BaseResponse> updateGoal(Goal data) => provider.updateGoal(data);
  Future<BaseResponse<GoalFrequency>> getGoalFrequencyList(QueryModel queryModel) => provider.getGoalFrequencyList(queryModel);
  Future<BaseResponse> createGoalFrequency(GoalFrequency data) => provider.createGoalFrequency(data);
  Future<BaseResponse> updateGoalFrequency(GoalFrequency data) => provider.updateGoalFrequency(data);
  Future<BaseResponse<GoalRelationship>> getGoalRelationshipList(QueryModel queryModel) => provider.getGoalRelationshipList(queryModel);
  Future<BaseResponse> createGoalRelationship(GoalRelationship data) => provider.createGoalRelationship(data);

}