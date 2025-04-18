import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:resq_application/module/user/controller/user_home_controller.dart';
import 'package:resq_application/module/user/view/emergency_screen.dart';
import 'package:resq_application/module/user/view/first_aid_screen.dart';
import 'package:resq_application/module/user/view/user_home.dart';
import 'package:resq_application/module/user/view/user_info_screen.dart';


class BottomNavPage extends StatelessWidget {

  final List<Widget> pages = [
    UserHome(),
    EmergencyPage(),
    FirstAidPage(),
    UserInfo(),
  ];

   BottomNavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Consumer<UserHomeController>(
            builder: (context,controller,_) {
              return pages[controller.bottomIndex];
            }
          ),
      bottomNavigationBar: Consumer<UserHomeController>(
        builder: (context,controller,_) {
          return Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: GNav(
                  gap: 8,
                  backgroundColor: Color(0xff0C3B2E),
                  activeColor: Color(0xffFFBA00),
                  color: Colors.grey,
                  padding: const EdgeInsets.all(16),
                  selectedIndex: controller.bottomIndex,
                  onTabChange: (index) {
                    controller.bottomNavigationChange(index);
                    // navController.changeTabIndex(index); // Change tab
                  },
                  tabs: const [
                    GButton(icon: Icons.home, text: 'Home'),
                    GButton(icon: Icons.sos_outlined, text: 'Emergency'),
                    GButton(icon: Icons.local_hospital_outlined, text: 'First Aid'),
                    GButton(icon: Icons.person_2, text: 'Profile'),
                  ],
                ),
              );
        }
      ),
    );
  }
}
