import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/View/Auth/login_screen.dart';
import 'package:task_management_app/View/root_screen.dart';

class AuthService {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  // Check if user is logged in
  Future<void> checkUser(BuildContext context) async {
    final user = auth.currentUser;
    print('Check user is available or not: $user');

    if (user != null) {
      // User is logged in → Go to RootScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RootScreen()),
      );
    } else {
      // User not logged in → Go to LoginScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  // Register a new user
  Future<User?> registerUser(String username, String email, String password) async {
    try {
      final result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;

      if (user != null) {
        await firestore.collection('Userdata').doc(user.uid).set({
          'uid': user.uid,
          'username': username,
          'email': email,
        });
      }

      return user;
    } catch (e) {
      print('Register error: $e');
      return null;
    }
  }

  // Login existing user
  Future<User?> loginUser(String email, String password) async {
    try {
      final result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  // Logout current user
  Future<void> logout() async {
    await auth.signOut();
  }

  // Send password reset email
  Future<void> forgetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  // Fetch current logged-in user's info
  Future<Map<String, dynamic>?> getUserInfo() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        print('User is not logged in');
        return null;
      }

      final snapshot = await FirebaseFirestore.instance
          .collection('Userdata') 
          .doc(user.uid)
          .get();

      if (snapshot.exists) {
        print("Fetched user data: ${snapshot.data()}");
        return snapshot.data();
      } else {
        print('User document not found in Userdata collection');
        return null;
      }
    } catch (e) {
      print('Error while fetching user data: $e');
      return null;
    }
  }
}
