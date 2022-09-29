import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  TextEditingController controller;
  String hint;
  bool isEnabled;


  CustomTextField({required this.controller, required this.hint, required this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
          TextFormField(
            textAlign: TextAlign.right,
            controller: controller,
            enabled: isEnabled,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.black, fontSize: 16, ), 
                errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(12)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                )),

            ),

        ],
      ),
    );
  }
}