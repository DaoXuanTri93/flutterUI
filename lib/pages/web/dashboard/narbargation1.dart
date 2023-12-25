import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationBarDemo extends StatelessWidget {
  NavigationBarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DrawerHeader(
                  child: Column(
                    children: [
                      Expanded(child: Text('UserAccount')),
                      Expanded(child: Image.asset("lib/assets/logitem.jpg", fit: BoxFit.fill,)),
                    ],
                  ),

                ),
                DashboardListTile(
                  title: 'CheckTeamApproval',
                  icon: Icon(Icons.check),
                  press: () {},
                ),
                DashboardListTile(
                  title: 'home 1',
                  icon: Icon(Icons.home),
                  press: () {},
                ),
                Spacer(),
                DashboardListTile(
                  title: 'Account',
                  icon: Icon(Icons.person),
                  press: () {},
                )
              ],
            )),
            Expanded(
                flex: 5,
                child: Container(
                  color: Colors.black26,
                ))
          ],
        ),
      ),
    );
  }
}

class DashboardListTile extends StatelessWidget {
  DashboardListTile(
      {required this.title, required this.icon, required this.press});

  String title;
  Icon icon;
  VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 12.0,
      leading: icon,
      title: Text(title),
    );
  }
}
