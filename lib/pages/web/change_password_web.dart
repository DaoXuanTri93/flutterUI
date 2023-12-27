

import 'package:flutter/material.dart';
import 'package:login_app/controller/changePasswordController.dart';


class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});


  @override
  Widget build(BuildContext context) {
    TextEditingController passOld = TextEditingController();
    TextEditingController passNew = TextEditingController();
    TextEditingController passNewConFirm = TextEditingController();
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              child: Row(
                children: [
                  Expanded(flex: 2, child: Container()),
                  Expanded(flex: 4, child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('パスワード変更', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                        SizedBox(height: 30),
                        Text('現在のパスワード:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        SizedBox(height: 15),
                        TextField(
                          obscureText: true,
                          controller: passOld,
                          decoration: InputDecoration(
                              border: OutlineInputBorder()),
                        ),
                        SizedBox(height: 15),
                        Text('新しいパスワード:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        SizedBox(height: 15),
                        TextField(
                          obscureText: true,
                          controller: passNew,
                          decoration: InputDecoration(
                              border: OutlineInputBorder()),
                        ),
                        SizedBox(height: 15),
                        Text('新しいパスワードの確認:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        SizedBox(height: 15),
                        TextField(
                          obscureText: true,
                          controller: passNewConFirm,
                          decoration: InputDecoration(
                              border: OutlineInputBorder()),
                        ),
                        SizedBox(height: 15),
                        ElevatedButton(onPressed: () {
                          Map<String, dynamic> data = {
                            "passwordOld" : passOld,
                            "passwordNew" : passNew,
                            "passwordNewConfirm" : passNewConFirm,
                          };
                          ChangePasswordController().fetchDatauser(data);
                        }, child: Text('変更')),
                      ],
                    ),
                  ),
                  Expanded(flex: 2, child: Container()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
