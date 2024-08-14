import 'package:suitmedia_km_test/models/user_response.dart';

class ApiResponse {
  final int? page;
  final int? perPage;
  final int? total;
  final int? totalPages;
  final List<UserResponse>? data;

  const ApiResponse({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
  });

  factory ApiResponse.fromMap(Map<String, dynamic> map) {
    return ApiResponse(
      page: map['page'] != null ? map['page'] as int : null,
      perPage: map['perPage'] != null ? map['perPage'] as int : null,
      total: map['total'] != null ? map['total'] as int : null,
      totalPages: map['totalPages'] != null ? map['totalPages'] as int : null,
      data: map['data'] != null
          ? List<UserResponse>.from(
              (map['data'] as List<dynamic>).map<UserResponse?>(
                (x) => UserResponse.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  @override
  String toString() {
    return 'ApiResponse(page: $page, perPage: $perPage, total: $total, totalPages: $totalPages, data: $data)';
  }

  
}
