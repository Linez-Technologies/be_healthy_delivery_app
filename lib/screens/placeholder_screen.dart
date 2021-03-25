import 'package:flutter/material.dart';

class PlaceholderScreen extends StatefulWidget {
  final Color color;
  PlaceholderScreen({this.color});
  @override
  _PlaceholderScreenState createState() => _PlaceholderScreenState();
}

class _PlaceholderScreenState extends State<PlaceholderScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
    );
  }
}
