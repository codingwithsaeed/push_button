import 'dart:async';

import 'package:flutter/material.dart';
import 'package:push_button/ripple_animation.dart';

class PushButton extends StatefulWidget {
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
  State<PushButton> createState() => _PushButtonState();
}

class _PushButtonState extends State<PushButton> with TickerProviderStateMixin {
  late Timer _timer;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
        onPointerDown: (PointerDownEvent event) {
          _timer = Timer(const Duration(milliseconds: 100), () {
            if (widget.onLongPressed != null) {
              widget.onLongPressed!();
              _controller.repeat();
            }
          });
        },
        onPointerUp: (PointerUpEvent event) {
          _controller.value = 0;
          _controller.stop();
          _timer.cancel();
        },
        child: CustomPaint(
          painter: CirclePainter(_controller, color: widget.color),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.size),
            child: Container(
              width: widget.size,
              height: widget.size,
              color: widget.color,
              child: Center(child: widget.child),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
