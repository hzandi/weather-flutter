import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoadingAnimation extends StatelessWidget {
  const CustomLoadingAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.dotsTriangle(color: Colors.white, size: 64);
  }
}
