import 'package:flutter/material.dart';

import 'package:suitmedia_km_test/models/user_response.dart';

@immutable
class ThirdScreenState {}

class Initial extends ThirdScreenState {}

class Loading extends ThirdScreenState {}

class Success extends ThirdScreenState {
  final List<UserResponse>? data;
  Success({
    this.data,
  });
}

class Error extends ThirdScreenState {
  final String? message;
  Error({
    this.message,
  });
}
