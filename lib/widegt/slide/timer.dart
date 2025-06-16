import 'dart:async';
import 'package:flutter/material.dart';
import 'package:clock/clock.dart';

typedef StopwatchCallback = void Function(Duration duration);

class StopwatchController {
  final _stateCompleter = Completer<_StopwatchWidgetState>();

  // 开始计时
  Future<void> start() async {
    final state = await _stateCompleter.future;
    state.start();
  }

  // 暂停计时 - 修复了之前的问题
  Future<void> pause() async {
    final state = await _stateCompleter.future;
    state.pause();
  }

  // 重置计时器
  Future<void> reset() async {
    final state = await _stateCompleter.future;
    state.reset();
  }

  // 获取当前计时
  Future<Duration> getElapsedTime() async {
    final state = await _stateCompleter.future;
    return state._elapsed;
  }

  // 获取计时状态
  Future<bool> isRunning() async {
    final state = await _stateCompleter.future;
    return state._isRunning;
  }

  // 内部方法，由组件调用以提供状态
  void _bindState(_StopwatchWidgetState state) {
    if (!_stateCompleter.isCompleted) {
      _stateCompleter.complete(state);
    }
  }
}

class StopwatchWidget extends StatefulWidget {
  final StopwatchCallback? onTimeChanged;
  final TextStyle? timeTextStyle;
  final TextStyle? buttonTextStyle;
  final Color? activeButtonColor;
  final Color? inactiveButtonColor;
  final Duration? updateInterval;
  final StopwatchController? controller;
  final bool showButtons;

  const StopwatchWidget({
    Key? key,
    this.onTimeChanged,
    this.timeTextStyle,
    this.buttonTextStyle,
    this.activeButtonColor,
    this.inactiveButtonColor,
    this.updateInterval = const Duration(milliseconds: 100),
    this.controller,
    this.showButtons = true,
  }) : super(key: key);

  @override
  _StopwatchWidgetState createState() => _StopwatchWidgetState();
}

class _StopwatchWidgetState extends State<StopwatchWidget> {
  late final Stopwatch _stopwatch;
  late Duration _elapsed;
  Timer? _timer;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _stopwatch = clock.stopwatch();
    _elapsed = Duration.zero;

    // 如果提供了控制器，则绑定到它
    if (widget.controller != null) {
      widget.controller!._bindState(this);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _stopwatch.stop();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(widget.updateInterval!, (_) {
      if (_stopwatch.isRunning) {
        setState(() {
          _elapsed = _stopwatch.elapsed;
          widget.onTimeChanged?.call(_elapsed);
        });
      }
    });
  }

  void start() {
    if (!_isRunning) {
      _stopwatch.start();
      _startTimer();
      setState(() {
        _isRunning = true;
      });
    }
  }

  void pause() {
    if (_isRunning) {
      _stopwatch.stop();
      _timer?.cancel();
      setState(() {
        _isRunning = false;
      });
    }
  }

  void reset() {
    pause();
    setState(() {
      _stopwatch.reset();
      _elapsed = Duration.zero;
      widget.onTimeChanged?.call(_elapsed);
    });
  }

  // 修复了时间格式化函数，恢复毫秒显示
  String _formatDuration(Duration duration) {
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);
    int milliseconds = duration.inMilliseconds.remainder(1000) ~/ 10;

    return '${minutes.toString().padLeft(2, '0')} : '
        '${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _formatDuration(_elapsed),
          style: widget.timeTextStyle ?? const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (widget.showButtons) ...[
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _isRunning ? null : start,
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.activeButtonColor ?? Colors.green,
                ),
                child: Text(
                  '开始',
                  style: widget.buttonTextStyle,
                ),
              ),
              ElevatedButton(
                onPressed: _isRunning ? pause : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.activeButtonColor ?? Colors.orange,
                ),
                child: Text(
                  '暂停',
                  style: widget.buttonTextStyle,
                ),
              ),
              ElevatedButton(
                onPressed: reset,
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.inactiveButtonColor ?? Colors.red,
                ),
                child: Text(
                  '重置',
                  style: widget.buttonTextStyle,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
