import 'package:flutter/material.dart';

class NewButton extends StatelessWidget {
  final String text;
  final double? height;
  final double? width; 
  final VoidCallback onClick;


  const NewButton({
    required this.text,
    this.height,
    this.width,
    required this.onClick,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(vertical: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30)),
      child: ElevatedButton(
              onPressed: () {
                onClick.call();
              },
              child: Text(
                text,
                
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  
                ),
              ),

              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black.withOpacity(0.5);
            }
            return Colors.black;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
              ),
            ),
    );
  }
}