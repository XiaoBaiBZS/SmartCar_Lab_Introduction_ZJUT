import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TVFocusWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback? onFocus;
  final VoidCallback? onBlur;
  final VoidCallback? onSelect;
  final Color focusColor;
  final double focusBorderWidth;
  final double scaleFactor;
  final bool enableScale;

  const TVFocusWidget({
    Key? key,
    required this.child,
    this.onFocus,
    this.onBlur,
    this.onSelect,
    this.focusColor = Colors.blue,
    this.focusBorderWidth = 2.0,
    this.scaleFactor = 1.05,
    this.enableScale = true,
  }) : super(key: key);

  @override
  State<TVFocusWidget> createState() => _TVFocusWidgetState();
}

class _TVFocusWidgetState extends State<TVFocusWidget>  {
  late FocusNode _focusNode;
  bool _hasFocus = false;
  double _currentScale = 1.0;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode(debugLabel: 'TVFocusWidget');
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus != _hasFocus) {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
        _currentScale = _hasFocus ? widget.scaleFactor : 1.0;
      });

      if (_hasFocus) {
        widget.onFocus?.call();
      } else {
        widget.onBlur?.call();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      canRequestFocus: true,
      descendantsAreFocusable: false,
      onKey: (node, event) {
        if (event is RawKeyDownEvent && event.logicalKey == LogicalKeyboardKey.select) {
          widget.onSelect?.call();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          transform: Matrix4.identity()..scale(_currentScale),
          transformAlignment: Alignment.center,
          decoration: BoxDecoration(
            border: _hasFocus
                ? Border.all(
              color: widget.focusColor,
              width: widget.focusBorderWidth,
            )
                : null,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: widget.child,
        ),
      ),
    );
  }

  @override
  FocusNode get focusNode => _focusNode;

  @override
  NumericFocusOrder get focusTraversalOrder => const NumericFocusOrder(1.0);
}