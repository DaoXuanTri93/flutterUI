


import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:login_app/const/const.dart';
import 'package:login_app/const/fontText.dart';
import 'package:login_app/controller/changePasswordController.dart';


class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});
  ChangePasswordController changePasswordController = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    var passOld = TextEditingController().obs;
    var passNew = TextEditingController().obs;
    var passNewConFirm = TextEditingController().obs;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              child: Row(
                children: [
                  Expanded(flex: 2, child: Container()),
                  Expanded(flex: 4, child: Form(
                    key: _formKey,
                    child: Obx(
                      () => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('パスワード変更', style: textFont.titleLarge),
                            SizedBox(height: 30),
                            Text('現在のパスワード:', style: textFont.titleMedium),
                            SizedBox(height: 15),
                            TextFormField(
                              validator: (value) {
                                if(value!.trim().isEmpty){
                                  return notEmpty ;
                                }
                              },
                              obscureText: true,
                              controller: passOld.value,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder()),
                            ),
                            SizedBox(height: 15),
                            Text('新しいパスワード:', style: textFont.titleMedium),
                            SizedBox(height: 15),
                            TextFormField(
                              validator: (value) {
                                passNew.value.text = value!;
                                if(value!.trim().isEmpty){
                                  return notEmpty ;
                                }
                              },
                              obscureText: true,
                              controller: passNew.value,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder()),
                            ),
                            SizedBox(height: 15),
                            Text('新しいパスワードの確認:', style: textFont.titleMedium),
                            SizedBox(height: 15),
                            TextFormField(
                              validator: (value) {
                                passNewConFirm.value.text = value!;
                                if(value!.trim().isEmpty){
                                  return notEmpty ;
                                }
                                if(passNew.value.text != passNewConFirm.value.text){
                                  return incorrectPassword;
                                }
                              },
                              obscureText: true,
                              controller: passNewConFirm.value,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder()),
                            ),
                            SizedBox(height: 15),
                            ElevatedButton(onPressed: () {

                              Map<String, dynamic> data = {
                                "passwordOld" : passOld.value.text,
                                "passwordNew" : passNew.value.text,
                                "passwordNewConfirm" : passNewConFirm.value.text,
                              };
                              if(_formKey.currentState!.validate()){
                                EasyLoading.show();
                                changePasswordController.fetchDatauser(data);
                              }
                            }, style: ButtonStyle(
                                shape: MaterialStateProperty.all(RoundedRectangleBorder( borderRadius: BorderRadius.circular(5))),
                                backgroundColor: MaterialStateProperty.all(Colors.blue)),
                                child: Text('変更', style: TextStyle(color: Colors.white))),
                          ],
                        ),
                    ),
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
