import 'package:flutter/material.dart';

@immutable
class ThirdScreenEvent {}

class FetchData extends ThirdScreenEvent {
  final int? page;
  FetchData({this.page});
}

class FetchMoreData extends ThirdScreenEvent {
  final int? page;
  FetchMoreData({this.page});
}
