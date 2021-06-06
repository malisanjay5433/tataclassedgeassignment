import 'package:flutter/material.dart';

class FadePageRoute extends PageRouteBuilder {
  final Widget widget;
  FadePageRoute({required this.widget})
      : super(pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryanimation,
        ) {
          return widget;
        }, transitionsBuilder: ((BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryanimation,
            Widget child) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(animation),
            child: child,
          );
        }));
}
