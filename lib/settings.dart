import 'package:flutter/material.dart';

Color background = Color(0xff2471B7);

class CustomPageRoute extends PageRouteBuilder {
  Widget child;
  AxisDirection axis;

  CustomPageRoute({required this.child, required this.axis})
      : super(
            transitionDuration: const Duration(milliseconds: 200),
            pageBuilder: (context, animation, secondaryAnimation) => child);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // TODO: implement buildTransitions
    return SlideTransition(
        position: Tween<Offset>(begin: getOffset(), end: Offset.zero)
            .animate(animation),
        child: child
        // super.buildTransitions(context, animation, secondaryAnimation, child),
        );
  }

  Offset getOffset() {
    switch (axis) {
      case AxisDirection.up:
        return const Offset(0, 1);
      case AxisDirection.down:
        return const Offset(0, -1);
      case AxisDirection.right:
        return const Offset(-1, 0);
      case AxisDirection.left:
        return const Offset(1, 0);
    }
  }
}
