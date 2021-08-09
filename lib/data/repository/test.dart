import 'package:test_flutter_web/data/provider/test.dart';

class MyRepository {
  final MyApiClient apiClient;

  MyRepository({required this.apiClient});

  getAll() {
    return apiClient.getAll();
  }

  getId(id) {
    return apiClient.getId(id);
  }
}