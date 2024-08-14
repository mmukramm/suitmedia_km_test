import 'package:dio/dio.dart';

import 'package:suitmedia_km_test/models/api_response.dart';

class DioClient {
  DioClient._internal();

  static final DioClient instance = DioClient._internal();

  factory DioClient() {
    return instance;
  }

  final url = 'https://reqres.in/api/users';

  final dio = Dio();

  Future<ApiResponse> fetchData({required int page}) async {
    try {
      final response = await dio
          .get(url, queryParameters: {'page': page.toString(), 'per_page': 10});

      return ApiResponse.fromMap(response.data);
    } on DioException {
      rethrow;
    }
  }
}
