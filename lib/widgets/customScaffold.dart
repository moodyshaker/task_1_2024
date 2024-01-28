import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task/widgets/main_text.dart';
import '../../constants.dart';

class CustomScaffold extends StatefulWidget {
  final Widget body;
  final Color? backgroundColor;

  const CustomScaffold(
      {required this.body, this.backgroundColor, Key? key})
      : super(key: key);

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor ?? kAccentColor,
      body: SafeArea(child: widget.body),
    );
  }
}
