import 'package:flutter/material.dart';
import 'package:login_app/auth/authentical.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    void logOut(){
      AuthenticationManager().logOut();
    }
    return  Scaffold(body: Center(child: ElevatedButton(
        onPressed: logOut,
        child: Text("Logout"))));
  }
}
