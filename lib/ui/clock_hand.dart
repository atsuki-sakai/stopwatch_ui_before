import 'package:flutter/material.dart';

class ClockHand extends StatelessWidget {
  const ClockHand(
      {Key? key,
      required this.handThickness,
      required this.rotateZAngle,
      required this.handLength,
      required this.color})
      : super(key: key);
  final double handThickness;
  final double rotateZAngle;
  final double handLength;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..translate(-handThickness / 2, 0.0, 0.0)
        ..rotateZ(rotateZAngle),
      child: Container(
        width: handThickness,
        height: handLength,
        color: color,
      ),
    );
  }
}
