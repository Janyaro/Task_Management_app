import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/View/TaskScreens/task_screen.dart';
import 'package:task_management_app/View/home_screen.dart';
import 'package:task_management_app/View/profile_screen.dart';
import 'package:task_management_app/provider/bottonNavigationProvider.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
   final List<Widget> _screen = const[
    HomeScreen(),
    TaskScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final bottomProvider = Provider.of<Bottonnavigationprovider>(context);
    return  SafeArea(
      child: Scaffold(
        body: _screen[bottomProvider.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: bottomProvider.currentIndex,
          onTap: bottomProvider.changeIndex,
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.grey,
          items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home ,) , label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.task ,) , label: 'Task'),
          BottomNavigationBarItem(icon: Icon(Icons.person ,) , label: 'Person'),
        ]),
      ),
    );
    
  }
}