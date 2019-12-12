import 'dart:async';

import 'package:flutter/material.dart';

class CustomNavigationWidget extends StatefulWidget
    implements CustomNavigationContract {
  final Widget child;
  final StreamController<Widget> streamController;

  const CustomNavigationWidget(
      {Key key, @required this.streamController, this.child})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomNavigationWidgetState();
  }

  static CustomNavigationWidget of(BuildContext context) {
    var widget = context.ancestorWidgetOfExactType(CustomNavigationWidget);
    if (widget == null) {
      throw NullThrownError();
    }
    return widget;
  }

  @override
  void route(Widget widget) {
    streamController.add(widget);
  }
}

class _CustomNavigationWidgetState extends State<CustomNavigationWidget> {
  var _currentWidget;

  @override
  void initState() {
    _currentWidget = widget.child;
    widget.streamController.stream.listen((newWidget) {
       Future.delayed(Duration(milliseconds: 50), () {
        if (mounted) {
          setState(() {
            print("widget refreshed");
            _currentWidget = newWidget;
          });
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _currentWidget;
  }
}

abstract class CustomNavigationContract {
  void route(Widget widget);
}
