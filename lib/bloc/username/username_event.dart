import 'package:flutter/material.dart';

@immutable
class UsernameEvent {}

class ChangeUsername extends UsernameEvent {
  final String username;
  ChangeUsername({required this.username});
}
