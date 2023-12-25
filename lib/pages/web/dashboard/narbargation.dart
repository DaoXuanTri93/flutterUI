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
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DrawerHeader(child: Text("DrawerHeader")),
                ListTile(
                  onTap: (){},
                  horizontalTitleGap: 12.0,
                  leading: Icon(Icons.person),
                  title: Text("Dashboard"),
                ),
                ListTile(
                  onTap: (){},
                  horizontalTitleGap: 12.0,
                  leading: Icon(Icons.person),
                  title: Text("Dashboard1"),
                ),
                ListTile(
                  onTap: (){},
                  horizontalTitleGap: 12.0,
                  leading: Icon(Icons.person),
                  title: Text("Dashboard2"),
                )
              ],
            )),
            Expanded(flex: 5, child: Container(
              color: Colors.blue,
            ))

          ],
        ),
      ),
    );

  }
}


