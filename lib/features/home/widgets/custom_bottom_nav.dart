import 'package:flutter/material.dart';
import 'package:music_app1/controller/home_controller.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key, required this.index, this.onTap});
  final int index;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: onTap,

      backgroundColor: Color(0xff261F44),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color(0xff854F9F),
      unselectedItemColor: Color(0xffFFFFFF),

      items: [
        for (int i = 0; i < HomeController.homeIcon.length; i++)
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ), // ← هنا تضبط المسافة اللي بدك إياها
              child: HomeController.homeIcon[i],
            ),
            label: "",
          ),
      ],
    );
  }
}
