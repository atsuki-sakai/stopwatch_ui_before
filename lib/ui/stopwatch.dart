import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stopwatch_flutter/ui/reset_button.dart';
import 'package:stopwatch_flutter/ui/start_stop_button.dart';
import 'package:stopwatch_flutter/ui/stopwatch_renderer.dart';
import 'package:stopwatch_flutter/ui/stopwatch_ticker_ui.dart';

class Stopwatch extends StatefulWidget {
  @override
  _StopwatchState createState() => _StopwatchState();
}

class _StopwatchState extends State<Stopwatch> {
  // FIXME - StatefulWidgetのStateをGlobalKeyにする場合StatefulWidgetのStateClassの_を消す必要がある。エラーが発生
  final _tickerUIKey = GlobalKey<StopwatchTickerUIState>();
  bool _isRunning = false;

  void _reset() {
    setState(() {
      _isRunning = false;
    });
    _tickerUIKey.currentState?.reset();
  }

  void _toggleRunning() {
    setState(() {
      _isRunning = !_isRunning;
    });
    _tickerUIKey.currentState?.toggleRunning(_isRunning);
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
              radius: radius,
            ),
          ),
          StopwatchTickerUI(
            key: _tickerUIKey,
            radius: radius,
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
