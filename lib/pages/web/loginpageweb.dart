
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_app/auth/authentical.dart';
import 'package:login_app/const/const.dart';
import 'package:login_app/controller/homeController.dart';


class LoginPageWeb extends StatelessWidget {
  LoginPageWeb({super.key});
  final HomeController controller = Get.put(HomeController());
  final _formKey = GlobalKey<FormState>();
  final _ischeck = false.obs;
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Row(
              children: [
                Expanded(child: Container(), flex: 1,),
                Expanded(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            titleUser,
                            style:
                            const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 30),
                          TextFormField(
                            controller: _username,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Username is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: hintUser,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0))),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _password,
                            obscureText: true,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: hintPassUser,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0)),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                              onPressed: () => {
                                if (_formKey.currentState!.validate())
                                  {
                                    AuthenticationManager().login(_username.text,
                                        _password.text, _ischeck.value, controller.MAC)
                                  }
                              },
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0))),
                              child: Text(titleUser)),
                          const SizedBox(height: 5),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed('/forgotpage');
                            },
                            child: Text(getPassUser,
                                style: const TextStyle(color: Colors.blue)),
                          ),
                          Row(
                            children: [
                              Obx(() => Checkbox(
                                  value: _ischeck.value,
                                  onChanged: (value) =>
                                  {_ischeck.value = !_ischeck.value})),
                              Text(rememberUser)
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ), flex: 2,),
                Expanded(child: Container(), flex: 1,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
