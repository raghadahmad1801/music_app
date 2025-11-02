import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,

      automaticallyImplyLeading: true,
      iconTheme: const IconThemeData(color: Colors.white),

      // leading: GestureDetector(
      //   // onTap: () {
      //   //   Navigator.pop(context);
      //   // },
      //   child: Icon(Icons.arrow_left, size: 30, color: Color(0xffFFFFFF)),
      // ),
      title: Text(
        "Now Playing",
        style: GoogleFonts.orbitron(
          textStyle: TextStyle(
            color: Color(0xffFFFFFF),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      centerTitle: true,
      actions: [
        Icon(Icons.share, size: 20, color: Color(0xffFFFFFF)),
        Gap(15),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Icon(Icons.more_vert, size: 20, color: Color(0xffFFFFFF)),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
