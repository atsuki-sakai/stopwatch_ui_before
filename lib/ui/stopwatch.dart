import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stopwatch_flutter/ui/reset_button.dart';
import 'package:stopwatch_flutter/ui/start_stop_button.dart';
import 'package:stopwatch_flutter/ui/stopwatch_renderer.dart';

class Stopwatch extends StatefulWidget {
  @override
  _StopwatchState createState() => _StopwatchState();
}

class _StopwatchState extends State<Stopwatch>
    with SingleTickerProviderStateMixin {
  // FIXME - toggleRunningが呼ばれる度に時間がリセットされるのを防ぐ為のプロパティー　２つ
  Duration _previouslyElapsed = Duration.zero;
  Duration _currentlyElapsed = Duration.zero;
  Duration get _elapsed => _currentlyElapsed + _previouslyElapsed;

  late final Ticker _ticker;
  bool _isRunning = false;

  void _reset() {
    _ticker.stop();
    setState(() {
      _isRunning = false;
      _previouslyElapsed = Duration.zero;
      _currentlyElapsed = Duration.zero;
    });
  }

  void _toggleRunning() {
    setState(() {
      _isRunning = !_isRunning;
    });
    if (_isRunning) {
      _ticker.start();
    } else {
      _previouslyElapsed += _currentlyElapsed;
      _ticker.stop();
      _currentlyElapsed = Duration.zero;
    }
  }

  @override
  void initState() {
    super.initState();

    _ticker = this.createTicker((elapsed) {
      setState(() {
        _currentlyElapsed = elapsed;
      });
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // FIXME - LayoutBuilder(context,constraints)　第二引数から子のウィジェットの大きさを取得出来る。
    return LayoutBuilder(builder: (context, constraints) {
      final double radius = constraints.maxWidth / 2;
      return Stack(
        children: [
          SizedBox(
            child: StopwatchRenderer(
              elapsed: _elapsed,
              radius: radius,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: SizedBox(
              height: 80.0,
              width: 80.0,
              child: ResetButton(
                isRunning: _isRunning,
                onPressed: _reset,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              height: 80.0,
              width: 80.0,
              child: StartStopButton(
                isRunning: _isRunning,
                onPressed: _toggleRunning,
              ),
            ),
          ),
        ],
      );
    });
  }
}
