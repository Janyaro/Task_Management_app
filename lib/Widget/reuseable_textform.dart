import 'package:flutter/material.dart';

class ReuseableTextform extends StatelessWidget {
  final TextEditingController emailController;
  final String hintText;
  final String validatorText;
  final IconData? icon;
  final int maxline;

  const ReuseableTextform({super.key, required this.emailController, required this.hintText, required this.validatorText,  this.icon  , this.maxline = 1});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
                controller: emailController,
                maxLines: maxline,
                decoration: InputDecoration(
                  
                  contentPadding: EdgeInsets.all(15),
                  prefixIcon: Icon(icon),
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: Colors.blue.shade800
                  ),
                  border:OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(4)
                  ),
                  
                  fillColor: Colors.grey.shade300,
                  filled: true
                ),
                validator: (val){
                  if(val == null || val.isEmpty){
                    return hintText;
                  }
                  return null;
                },
              );
  }
}