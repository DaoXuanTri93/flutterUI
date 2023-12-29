// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:login_app/pages/officemastersearch.dart';
// import 'package:login_app/pages/web/screen_check_team.dart';
//
// class NavigationBarDemo extends StatelessWidget {
//   NavigationBarDemo({super.key});
//
//   RxInt index = 0.obs;
//   List<Widget> pages = [
//     OfficeMasterSearch(),
//     ScreenCheckTeam(),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Row(
//           children: [
//             Expanded(
//                 child: Column(
//               children: [
//                 DrawerHeader(
//                   child: Column(
//                     children: [
//                       Expanded(child: Text('UserAccount')),
//                       Expanded(child: Image.asset("lib/assets/logitem.jpg")),
//                     ],
//                   ),
//
//                 ),
//                 DashboardListTile(
//                   title: 'CheckTeamApproval',
//                   icon: Icon(Icons.check),
//                   press: () {
//                     index.value = 0;
//                   },
//                 ),
//                 DashboardListTile(
//                   title: 'Văn phòng',
//                   icon: Icon(Icons.home),
//                   press: () {
//                     index.value = 1;
//                   },
//                 ),
//                 DashboardListTile(
//                   title: 'Tài Xế',
//                   icon: Icon(Icons.drive_eta_rounded),
//                   press: () {},
//                 ),
//                 DashboardListTile(
//                   title: 'Phê Duyệt Chấm Công',
//                   icon: Icon(Icons.check),
//                   press: () {},
//                 ),
//                 DashboardListTile(
//                   title: 'Người Dùng',
//                   icon: Icon(Icons.person),
//                   press: () {},
//                 ),
//                 Spacer(),
//                 DashboardListTile(
//                   title: 'Account',
//                   icon: Icon(Icons.person),
//                   press: () {},
//                 )
//               ],
//             )),
//             Expanded(
//                 flex: 5,
//                 child: Obx(() => pages[index.value]),
//                 )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class DashboardListTile extends StatelessWidget {
//   DashboardListTile(
//       {required this.title, required this.icon, required this.press});
//
//   String title;
//   Icon icon;
//   VoidCallback press;
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       onTap: press,
//       horizontalTitleGap: 12.0,
//       leading: icon,
//       title: Text(title),
//     );
//   }
// }
