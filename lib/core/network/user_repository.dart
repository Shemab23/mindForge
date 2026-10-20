import 'package:dio/dio.dart';
import '../models/user_model.dart';

class UserRepository {
  final Dio _dio = Dio();

  /// Predefined constant mock fallback values (Matches your strict formatting rules)
  static const List<Map<String, dynamic>> fallbackMockData = [
    {
      "id": 0,
      "name": "Fallback Offline Developer",
      "email": "shema.dev@mindforge.internal",
      "address": {"city": "Kigali"},
      "company": {"name": "MindForge Core System"},
    },
  ];

  /// Fetches users and applies strict model filtering over response payloads
  Future<List<UserModel>> fetchUsersFromEndpoint() async {
    try {
      final response = await _dio.get(
        'https://jsonplaceholder.typicode.com/users',
      );

      if (response.data is List) {
        final rawList = response.data as List;
        // Map raw data arrays directly through our type conversion factory parameters
        return rawList
            .map(
              (jsonItem) =>
                  UserModel.fromJson(jsonItem as Map<String, dynamic>),
            )
            .toList();
      }
      throw Exception(
        'Unexpected payload format returned from background systems.',
      );
    } catch (error) {
      // Return hardcoded mock arrays through model parsers if networking drops out
      return fallbackMockData
          .map((mockItem) => UserModel.fromJson(mockItem))
          .toList();
    }
  }
}
