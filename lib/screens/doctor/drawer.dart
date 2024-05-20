import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ta/screens/doctor/list_tile.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onSignOut;
  const MyDrawer({
    super.key,
    required this.onProfileTap,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        //header
        Column(
          children: [
            const DrawerHeader(
                child: Icon(
              Icons.person,
              color: Color.fromARGB(255, 31, 30, 30),
              size: 64,
            )),
            //home
            MyListTile(
              icon: Icons.home,
              text: 'الصفحة الرئيسية',
              onTap: () => Navigator.pop(context),
            ),
            //profile
            MyListTile(
              icon: Icons.person,
              text: 'حسابي',
              onTap: onProfileTap,
            ),
          ],
        ),
        //Logout
        Padding(
          padding: const EdgeInsets.only(bottom: 25.0),
          child: MyListTile(
            icon: Icons.logout,
            text: 'تسجيل خروج',
            onTap: onSignOut,
          ),
        ),
      ]),
    );
  }
}
