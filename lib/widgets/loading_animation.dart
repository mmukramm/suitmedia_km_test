import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:suitmedia_km_test/styles/colors.dart';

class LoadingAnimation extends StatelessWidget {
  final double? size;
  const LoadingAnimation({
    super.key,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.threeArchedCircle(
      color: primaryColor,
      size: size!,
    );
  }
}
