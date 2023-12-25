import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationBarDemo1 extends StatelessWidget {
  NavigationBarDemo1({super.key});

  @override
  Widget build(BuildContext context) {
    List container_demo = [

    ];
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            NavigationRail(
              onDestinationSelected: (index){
                print(index);
              },
                destinations: [
              NavigationRailDestination(
                  icon: Icon(Icons.person), label: Text("hello")),
              NavigationRailDestination(
                  icon: Icon(Icons.person), label: Text("ba"))
            ], selectedIndex: 1)
          ],
        ),
      ),
    );
  }
}
