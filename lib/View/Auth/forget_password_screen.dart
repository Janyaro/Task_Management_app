import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/Service/Auth_service.dart';
import 'package:task_management_app/Widget/reuseable_btn.dart';
import 'package:task_management_app/Widget/reuseable_textform.dart';
import 'package:task_management_app/provider/Authentication_provider.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final emailController = TextEditingController();
  final authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final authprovider = Provider.of<AuthenticationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title:const Text('Forget password'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ReuseableTextform(controller: emailController, hintText: 'Email address', validatorText: 'Enter Email address here', icon: Icons.email_outlined),
          SizedBox(height: media.height * 0.03,),
          ReuseableBtn(isloading: authprovider.isloading, title: 'Forget Password', ontap: ()async{
            authprovider.setloading(true);
            await authService.forgetPassword(emailController.text.trim()).
            then((val){
              authprovider.setloading(false);
            }).onError((error , StackTrace){
              authprovider.setloading(false);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$error'))
              );
            });
          })
        ],
            ),
      ),
    );
  }
}