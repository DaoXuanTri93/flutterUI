import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_app/auth/authentical.dart';
import 'package:login_app/pages/officemastersearch.dart';
import 'package:login_app/pages/user_master_search.dart';
import 'package:login_app/pages/web/123.dart';
import 'package:login_app/pages/web/change_password_web.dart';
import 'package:login_app/pages/web/driver_infor.dart';
// import 'package:login_app/pages/web/screen_check_team.dart';

class NavigationBarDemo1 extends StatelessWidget {
  NavigationBarDemo1({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> container_demo = [
      OfficeMasterSearch(),
      ScreenCheckTeam(),
      DriverInforSearch(),
      Container(child: Center(child: Text("approval"))),
      UserMasterSearch(),
      Container(child: Center(child: Text("Staff"))),
      ChangePassword(),
    ].obs;
    var _selectIndex = 0.obs;
    var argument = Get.arguments;
    if(argument == null){
      _selectIndex.value = 0;
    }else{
      _selectIndex.value = argument;
    }
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => SingleChildScrollView(
            child: SizedBox(
              height: 963,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: NavigationRail(
                        onDestinationSelected: (index) {
                          _selectIndex.value = index;
                        },
                        selectedLabelTextStyle:
                            TextStyle(color: Colors.lightBlue[500]),
                        unselectedLabelTextStyle:
                            TextStyle(color: Colors.grey[500]),
                        useIndicator: true,
                        backgroundColor: Colors.black87,
                        indicatorColor: Colors.grey[50],
                        leading: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Image.asset("lib/assets/logitem.jpg"),
                        ),
                        // trailing: Text('trailing'),
                        minWidth: 100,
                        labelType: NavigationRailLabelType.all,
                        destinations:  const [
                          NavigationRailDestination(
                              icon: Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                              selectedIcon: Icon(
                                Icons.check,
                                color: Colors.black,
                              ),
                              label: Text("CheckTeamApproval")),
                          NavigationRailDestination(
                              icon: Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              selectedIcon: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              label: Text("Office Search")),
                          NavigationRailDestination(
                              icon: Icon(
                                Icons.drive_eta_rounded,
                                color: Colors.white,
                              ),
                              selectedIcon: Icon(
                                Icons.drive_eta_rounded,
                                color: Colors.black,
                              ),
                              label: Text("Driver Information")),
                          NavigationRailDestination(
                              icon: Icon(
                                Icons.approval,
                                color: Colors.white,
                              ),
                              selectedIcon: Icon(
                                Icons.approval,
                                color: Colors.black,
                              ),
                              label: Text("Time Attendance Approval")),
                          NavigationRailDestination(
                              icon: Icon(Icons.search_outlined, color: Colors.white,),
                              selectedIcon: Icon(Icons.search_outlined, color: Colors.black,),
                              label: Text("Staff User")),
                        ],
                        trailing: Column(
                          children: [
                            PopupMenuButton(
                              position : PopupMenuPosition.under,
                              // offset: Offset.fromDirection(1.5),
                              tooltip: '',
                              clipBehavior: Clip.none,
                              icon: Icon(Icons.person, color: Colors.white),
                              itemBuilder: (BuildContext context) {
                                return [
                                  PopupMenuItem(
                                    onTap: (){
                                      Get.toNamed('/changePassword');
                                    },
                                      child: Row(
                                    children: const [
                                      Icon(Icons.lock_outline),
                                      SizedBox(width: 5),
                                      Text('Changed Password'),
                                    ],
                                  )),
                                  PopupMenuItem(
                                    onTap: (){
                                      AuthenticationManager().logOut();
                                    },
                                      child: Row(
                                    children: const [
                                      Icon(Icons.login_outlined),
                                      SizedBox(width: 5),
                                      Text('Log Out'),
                                    ],
                                  )),
                                ];
                              },
                            ),
                            Text("Account", style: TextStyle(color: Colors.grey[500]),)
                          ],
                        ),
                        selectedIndex: _selectIndex.value),
                  ),
                  Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: container_demo[_selectIndex.value],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
