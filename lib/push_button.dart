import 'dart:async';

import 'package:flutter/material.dart';

class PushButton extends StatelessWidget {
  final Widget? child;
  final VoidCallback? onLongPressed;
  final double size;
  final Color color;

  const PushButton({
    Key? key,
    this.child,
    this.onLongPressed,
    this.size = 100,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Timer _timer;
    return Listener(
        onPointerDown: (PointerDownEvent event) {
          _timer = Timer(const Duration(milliseconds: 100), () {
            if (onLongPressed != null) {
              onLongPressed!();
            }
          });
        },
        onPointerUp: (PointerUpEvent event) {
          _timer.cancel();
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size),
          child: Container(
            width: size,
            height: size,
            color: color,
            child: Center(child: child),
          ),
        ));
  }
}
