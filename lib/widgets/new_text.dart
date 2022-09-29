import 'package:flutter/material.dart';

class NewText extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final VoidCallback? onClick;


  const NewText({
    required this.text,
    this.size,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.onClick,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: onClick == null
          ? Align(
            alignment: Alignment.centerRight,
            child: Text(
                text,
                style: TextStyle(
                  fontSize: size,
                  fontWeight: fontWeight,
                  color: color,
                ),
              ),
          )
          : TextButton(
              onPressed: () {
                onClick?.call();
              },
              child: Text(
                text,
                textAlign: textAlign,
                style: TextStyle(
                  fontSize: size,
                  fontWeight: fontWeight,
                  color: color,
                  
                ),
              ),
            ),
    );
  }
}