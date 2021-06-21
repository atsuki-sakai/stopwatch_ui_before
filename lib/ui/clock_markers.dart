import 'dart:math';

import 'package:flutter/material.dart';

class ClockSecondsTickMarker extends StatelessWidget {
  const ClockSecondsTickMarker(
      {Key? key, required this.radius, required this.seconds})
      : super(key: key);

  final double radius;
  final int seconds;

  @override
  Widget build(BuildContext context) {
    final color = seconds % 5 == 0 ? Colors.white : Colors.grey[700];
    const width = 2.0;
    const height = 12.0;
    return Transform(
      transform: Matrix4.identity()
        ..translate(-width / 2, -height / 2, 0.0)
        ..rotateZ(2 * pi * (seconds / 60.0))
        ..translate(0.0, radius - height / 2, 0.0),
      child: Container(
        width: width,
        height: height,
        color: color,
      ),
    );
  }
}

class ClockTextMarker extends StatelessWidget {
  const ClockTextMarker(
      {Key? key,
      required this.value,
      required this.maxValue,
      required this.radius})
      : super(key: key);

  final int value;
  final int maxValue;
  final double radius;

  @override
  Widget build(BuildContext context) {
    const width = 40.0;
    const height = 30.0;
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        // FIXME - 中心に持ってくる
        ..translate(-width / 2, -height / 2)
        // FIXME - 数字を正しい場所に配置する
        ..rotateZ(pi + 2 * pi * (value / maxValue))
        // FIXME -中心からズラす
        ..translate(0.0, radius - 35, 0.0)
        // FIXME - 数字の向きを整える
        ..rotateZ(pi - 2 * pi * (value / maxValue)),
      child: SizedBox(
        height: height,
        width: width,
        child: Text(
          value.toString(),
          style: TextStyle(fontSize: 24.0),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
