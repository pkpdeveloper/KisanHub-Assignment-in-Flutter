import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCarouselWidget extends StatefulWidget {
  final List<Widget> children;
  final Duration duration;

  const CustomCarouselWidget(
      {Key key, @required this.children, @required this.duration})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomCarouselWidgetState();
  }
}

class _CustomCarouselWidgetState extends State<CustomCarouselWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  int _widgetIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )
      ..addStatusListener((animationStatus) {
        if (animationStatus == AnimationStatus.completed) {
          if (mounted) {
            setState(() {
              if (_widgetIndex < widget.children.length - 1) {
                _widgetIndex++;
              } else {
                _widgetIndex = 0;
              }
              _controller.reset();
              _controller.forward();
            });
          }
        }
      })
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        child: ConstrainedBox(
            child: IndexedStack(
              index: _widgetIndex,
              sizing: StackFit.expand,
              children: widget.children,
            ),
            constraints: BoxConstraints.expand()),
        builder: (BuildContext context, Widget child) {
          return Transform.scale(scale: 1.0 + _controller.value, child: child);
        });
  }
}
