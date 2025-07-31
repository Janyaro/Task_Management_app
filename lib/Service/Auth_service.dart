import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/View/Auth/login_screen.dart';
import 'package:task_management_app/View/root_screen.dart';

class AuthService {
final auth = FirebaseAuth.instance;

final firestore = FirebaseFirestore.instance;

// for check the user is login or not

Future<void> checkUser (BuildContext context)async{
  final user = await auth.currentUser;
  if(user != null){
    Navigator.push(context , MaterialPageRoute(builder: (context)=> RootScreen()));
  }
  else{
     Navigator.push(context , MaterialPageRoute(builder: (context)=> LoginScreen()));
  }
}
// for create the new user 
 Future<User?> RegisterUser ( String username , String email , String password )async{
  try {
    final result = await auth.createUserWithEmailAndPassword(
      email: email,
       password: password
       );
       User? user = result.user;
       if(user != null){
       await firestore.collection('user').doc(user.uid).set({
        'uid': user.uid,
        'username':username,
        'email': email
       });
       }
       return user;
  } catch (e) {
    print('Sign in error ${e}');
    return null;
  }
 }

// for login the user 

Future<User?> loginUser (String email , String password)async{
try {
final result = await auth.signInWithEmailAndPassword(email: email, password: password);
  return result.user;
} catch (e) {
 return null; 
}
}

// for logout the user
Future<void>logout()async{
  await auth.signOut();
}
 
 // forget password
 Future<void>forgetPassword(String email)async{
  await auth.sendPasswordResetEmail(email: email);
 }


Future<Map<String , dynamic>?> getUserInfo () async{
try {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final snapshots =await firestore.collection('user').doc(uid).get();
  if(snapshots.exists){
    return snapshots.data();
  }
  else{
    return null;
  }
} catch (e) {
  print('Error while fetching user data ${e}');
  return null;
}
}

}