import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/Service/Auth_service.dart';
import 'package:task_management_app/View/Auth/login_screen.dart';
import 'package:task_management_app/Widget/reuseable_btn.dart';
import 'package:task_management_app/Widget/reuseable_textform.dart';
import 'package:task_management_app/provider/Authentication_provider.dart';

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
  final authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title:const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
        key: formkey,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
           const Text('Create your Account' , style:TextStyle(fontSize: 28 , fontWeight: FontWeight.bold) ,),
            SizedBox(height: media.height * 0.02,),
            ReuseableTextform(controller: userController, hintText: 'User name', validatorText: 'Username required ', icon: Icons.person),
                      SizedBox(height: media.height * 0.02,),
            ReuseableTextform(controller: emailController, hintText: 'Enter Email', validatorText:'Email required', icon: Icons.email_outlined),
            SizedBox(height: media.height * 0.02,),
            ReuseableTextform(controller: passwordContreoller, hintText: 'Enter Password', validatorText: 'password required', icon: Icons.lock),
            SizedBox(height: media.height * 0.02,),
            Consumer<AuthenticationProvider>(builder: (context , value , child){
              return ReuseableBtn( isloading: value.isloading,title: 'Sign Up', ontap: ()async{
                  if (!formkey.currentState!.validate()) return;

                value.setloading(true);
                 await authService.registerUser(
                        userController.text, 
                        emailController.text, 
                        passwordContreoller.text).then((val){
                          value.setloading(false);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
                        }).onError((error,StackTrace){
                          value.setloading(false);
                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$error')));
                        });
              });
               
            }),
                        Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  const  Text("Already have an account" , style: TextStyle(fontSize: 17),),
                    TextButton(onPressed: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
                    }, child:const Text('Login',style: TextStyle(fontSize: 17),))
                  ],
                ),

            SizedBox(height: media.height * 0.1,),
          ],
        ) ),
      ),
    );
  }
}