import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReuseableTextform extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String validatorText;
  final IconData? icon;
  final IconButton? suffixIcon;
  final int maxline;
  final bool isVisibility;
  const ReuseableTextform({super.key, required this.controller, required this.hintText, required this.validatorText,  this.icon  ,this.suffixIcon ,this.maxline = 1 , this.isVisibility = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
              controller: controller,
              maxLines: maxline,
              obscureText: isVisibility,
              decoration: InputDecoration(  
                contentPadding:const EdgeInsets.all(15),
                prefixIcon: Icon(icon),
                suffixIcon: suffixIcon ,
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