import 'package:flutter/material.dart';
import 'package:task_management_app/View/Auth/forget_password_screen.dart';
import 'package:task_management_app/View/Auth/signup_screen.dart';
import 'package:task_management_app/Widget/reuseable_btn.dart';
import 'package:task_management_app/Widget/reuseable_textform.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordContreoller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return  Scaffold(
      appBar: AppBar(
        title: Text('Login Screen' , style: TextStyle(fontSize: 23,),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              SizedBox(
                height: media.height * 0.02,
              ),
             const Text('Welcome Back' , style:TextStyle(fontSize: 28 , fontWeight: FontWeight.bold) ,),
              SizedBox(
                height: media.height * 0.04,
              ),
              ReuseableTextform(emailController: emailController, hintText: 'Enter email address  Email address', validatorText: 'Email required', icon: Icons.email_outlined,),
              SizedBox(
                height: media.height * 0.03,
              ),
               ReuseableTextform(
                emailController: passwordContreoller,
                hintText: 'Password here ',
                 validatorText:'password required',
                  icon: Icons.password,
                 
                 ),
               Align(
                alignment: Alignment.bottomRight,
                child: TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>const ForgetPasswordScreen()));
                }, child:const Text('Forget password' ,style: TextStyle(fontSize: 17),))),
                SizedBox(height: media.height * 0.02,),
                ReuseableBtn(title: 'Login', ontap: (){}),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  const  Text("don't have an account" , style: TextStyle(fontSize: 17),),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupScreen()));
                    }, child:const Text('Sign Up',style: TextStyle(fontSize: 17),))
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}