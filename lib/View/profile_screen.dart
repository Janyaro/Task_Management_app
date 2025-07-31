import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/Service/Auth_service.dart';
import 'package:task_management_app/View/Auth/login_screen.dart';
import 'package:task_management_app/Widget/reuseable_btn.dart';
import 'package:task_management_app/provider/Authentication_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
    final authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return  Scaffold(
      appBar: AppBar(
        title: Text('User profile'),
      ),
        body:FutureBuilder(
        future: authService.getUserInfo(), 
        builder: (context , snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: Text('thora Wait kar'),
            );
          }
          else if(!snapshot.hasData){
          return const Center(
            child:Text('No user find'),
          );
          }
          else if (!snapshot.hasData || snapshot.data == null) {
  return const Center(child: Text('No user found'));
}

          final data = snapshot.data!;
          return  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
           const Center(
              child: CircleAvatar(
                radius: 100,
                child: Text('data'),
              ),
            ),
            SizedBox(height: media.height * 0.02,),
            TextFormField(
              initialValue: data['uid'],
              readOnly: true,
              decoration: InputDecoration(
                  
                  contentPadding: EdgeInsets.all(15),

                  hintStyle: TextStyle(
                    color: Colors.blue.shade800
                  ),
                  border:OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(4)
                  ),
                                    fillColor: Colors.grey.shade300,
                  filled: true
            )),
             SizedBox(height: media.height * 0.02,),
            TextFormField(
              initialValue: data['username'],
              readOnly: true,
              decoration: InputDecoration(
                  
                  contentPadding: EdgeInsets.all(15),

                  hintStyle: TextStyle(
                    color: Colors.blue.shade800
                  ),
                  border:OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(4)
                  ),
                                    fillColor: Colors.grey.shade300,
                  filled: true
            )),
             SizedBox(height: media.height * 0.02,),
            TextFormField(
              initialValue: data['email'],
              readOnly: true,
              decoration: InputDecoration(
                  
                  contentPadding: EdgeInsets.all(15),

                  hintStyle: TextStyle(
                    color: Colors.blue.shade800
                  ),
                  border:OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(4)
                  ),
                                    fillColor: Colors.grey.shade300,
                  filled: true
            )),
           SizedBox(height: media.height * 0.02,),
          Consumer<AuthenticationProvider>(builder: (context , value, child){
            return ReuseableBtn(isloading: value.isloading, title: 'Logout', ontap: ()async{
              value.setloading(true);
            await authService.logout().then((val){
              value.setloading(false);
              Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
            }).onError((error,StackTrace){
              value.setloading(false);
            });
          
           });
          })
                    ],
                  ),
          );
        })
    );
  }
}