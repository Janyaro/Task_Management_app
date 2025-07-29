import 'package:flutter/material.dart';
import 'package:task_management_app/View/Auth/login_screen.dart';
import 'package:task_management_app/Widget/reuseable_btn.dart';
import 'package:task_management_app/Widget/reuseable_textform.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formkey = GlobalKey<FormState>();
  final userController = TextEditingController();
  final emailController = TextEditingController();
  final passwordContreoller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
        key: formkey,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('Create your Account' , style:TextStyle(fontSize: 28 , fontWeight: FontWeight.bold) ,),
            SizedBox(height: media.height * 0.02,),
            ReuseableTextform(emailController: userController, hintText: 'User name', validatorText: 'Username required ', icon: Icons.person),
                      SizedBox(height: media.height * 0.02,),
            ReuseableTextform(emailController: emailController, hintText: 'Enter Email', validatorText:'Email required', icon: Icons.email_outlined),
            SizedBox(height: media.height * 0.02,),
            ReuseableTextform(emailController: passwordContreoller, hintText: 'Enter Password', validatorText: 'password required', icon: Icons.lock),
            SizedBox(height: media.height * 0.02,),
            ReuseableBtn(title: 'Sign Up', ontap: (){}),
            Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Already have an account" , style: TextStyle(fontSize: 17),),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
                    }, child: Text('Login',style: TextStyle(fontSize: 17),))
                  ],
                ),

            SizedBox(height: media.height * 0.1,),
          ],
        ) ),
      ),
    );
  }
}