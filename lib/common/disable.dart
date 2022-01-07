import 'package:flutter/material.dart';

class Disable extends StatelessWidget {
  const Disable({Key? key, required this.child, required this.disable})
      : super(key: key);

  final Widget child;
  final bool disable;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: disable,
      child: disable
          ? ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Colors.grey,
                BlendMode.saturation,
              ),
              child: child)
          : child,
    );
  }
}
