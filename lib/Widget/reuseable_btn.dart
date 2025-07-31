import 'package:flutter/material.dart';

class ReuseableBtn extends StatelessWidget {
  final String title;
 final VoidCallback ontap;
 final bool isloading;
  const ReuseableBtn({super.key, required this.title, required this.ontap, required this.isloading});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: ontap,
      child: Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Center(
                      child:isloading ?  CircularProgressIndicator(color: Colors.white,) :Text(title, style: TextStyle(fontSize: 23 , color: Colors.white),),
                    ),
                  ),
    );
  }
}