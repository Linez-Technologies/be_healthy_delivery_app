import 'package:be_healthy_delivery_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedFilledButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  const RoundedFilledButton({
    Key key,
    this.title,
    this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: kOrangeMaterialColor,
        shadowColor: kOrangeMaterialColor,
        padding: EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 80),
        shape: RoundedRectangleBorder(side: BorderSide(
          color: kOrangeMaterialColor,
          width: 2,
          style: BorderStyle.solid,
        ), borderRadius: BorderRadius.circular(30)
        ),
      ),
      onPressed: onPressed,
      child: Text(title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}