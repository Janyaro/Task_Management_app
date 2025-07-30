import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/Service/Auth_service.dart';
import 'package:task_management_app/View/Auth/forget_password_screen.dart';
import 'package:task_management_app/View/Auth/signup_screen.dart';
import 'package:task_management_app/View/root_screen.dart';
import 'package:task_management_app/Widget/reuseable_btn.dart';
import 'package:task_management_app/Widget/reuseable_textform.dart';
import 'package:task_management_app/provider/Authentication_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return  Scaffold(
      appBar: AppBar(
        title: Text('Login Screen' , style: TextStyle(fontSize: 23,),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
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
                ReuseableTextform(controller: emailController, hintText: 'Enter email address  Email address', validatorText: 'Email required', icon: Icons.email_outlined,),
                SizedBox(
                  height: media.height * 0.03,
                ),
                 ReuseableTextform(
                  controller: passwordController,
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


                Consumer<AuthenticationProvider>(builder: (context , value , child){
                  return ReuseableBtn(isloading:  value.isloading, title: 'Login', ontap: () async {
  if (!formkey.currentState!.validate()) return;

  value.setloading(true); // Start loading
  await authService.loginUser(emailController.text, passwordController.text).then((val) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const RootScreen()));
  }).onError((error, stackTrace) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Login failed: ${error.toString()}')),
    );
  });
  value.setloading(false); // Stop loading
},
);
                }),
                  
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
      ),
    );
  }
}