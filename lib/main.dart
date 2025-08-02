import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/View/Auth/login_screen.dart';
import 'package:task_management_app/View/splash_screen.dart';
import 'package:task_management_app/provider/TaskProvider.dart';
import 'package:task_management_app/provider/Authentication_provider.dart';
import 'package:task_management_app/provider/bottonNavigationProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(
 MultiProvider(providers: [
  ChangeNotifierProvider(create: (_)=> TaskProvider()),
  ChangeNotifierProvider(create: (_)=> Bottonnavigationprovider()),
  ChangeNotifierProvider(create: (_)=> AuthenticationProvider())
 ],
 child:const MyApp() ,
 )   
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:ThemeData(
        appBarTheme:const AppBarTheme(
          
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 23 , color: Colors.black , fontWeight: FontWeight.w500)),
      ),
      
      home:const SplashScreen  (),
    );
  }
}