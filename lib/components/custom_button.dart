import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    this.inkColor,
    this.iconColor,
    @required this.icon,
    @required this.onPressed,
  });

  final Color iconColor;
  final Color inkColor;
  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: ShapeDecoration(
        shape: CircleBorder(),
        color: inkColor,
      ),
      child: IconButton(
        icon: Icon(
          icon,
          size: 30,
          color: iconColor,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
