import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../Models/size_config.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize:  Size.fromHeight(60.h),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0XFFFE813E),
        unselectedItemColor: const Color(0XFF5423A1),// Fixed
        selectedIconTheme: const IconThemeData(
            color: Color(0XFFFE813E)
        ),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        elevation: 10,
        items:  [
          const BottomNavigationBarItem(
              icon: Icon(Icons.home,),
              label: 'Home',
              activeIcon: Icon(Icons.home,)
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.string(''''<svg width="27" height="26" viewBox="0 0 27 26" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M16.3672 11.3598H20.4242" stroke="#5423A1" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            <path d="M16.3672 14.6054H20.4242" stroke="#5423A1" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            <path d="M10.2917 14.6054C11.636 14.6054 12.7259 13.5156 12.7259 12.1712C12.7259 10.8268 11.636 9.73694 10.2917 9.73694C8.94727 9.73694 7.85742 10.8268 7.85742 12.1712C7.85742 13.5156 8.94727 14.6054 10.2917 14.6054Z" stroke="#5423A1" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            <path d="M7.14746 17.0397C7.32622 16.3415 7.73225 15.7227 8.30154 15.2808C8.87083 14.8389 9.57101 14.5991 10.2917 14.5991C11.0124 14.5991 11.7125 14.8389 12.2818 15.2808C12.8511 15.7227 13.2571 16.3415 13.4359 17.0397" stroke="#5423A1" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            <path d="M22.8588 4.86847H5.0077C4.55957 4.86847 4.19629 5.23175 4.19629 5.67988V20.2853C4.19629 20.7334 4.55957 21.0967 5.0077 21.0967H22.8588C23.3069 21.0967 23.6702 20.7334 23.6702 20.2853V5.67988C23.6702 5.23175 23.3069 4.86847 22.8588 4.86847Z" stroke="#5423A1" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>'''),
            label: 'My Aadhaar',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.string(''''<svg width="27" height="26" viewBox="0 0 27 26" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M13.0298 13.794C14.8223 13.794 16.2755 12.3409 16.2755 10.5484C16.2755 8.75583 14.8223 7.3027 13.0298 7.3027C11.2373 7.3027 9.78418 8.75583 9.78418 10.5484C9.78418 12.3409 11.2373 13.794 13.0298 13.794Z" stroke="#5423A1" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            <path d="M21.1433 10.5484C21.1433 17.8511 13.0292 23.5309 13.0292 23.5309C13.0292 23.5309 4.91504 17.8511 4.91504 10.5484C4.91504 8.39635 5.76992 6.3325 7.29161 4.8108C8.8133 3.28911 10.8772 2.43423 13.0292 2.43423C15.1812 2.43423 17.245 3.28911 18.7667 4.8108C20.2884 6.3325 21.1433 8.39635 21.1433 10.5484V10.5484Z" stroke="#5423A1" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>'''
            ),
            label: 'Enrollment Center',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.string(''''<svg width="27" height="28" viewBox="0 0 27 28" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M13.6725 16.5231C15.0169 16.5231 16.1068 15.3551 16.1068 13.9142C16.1068 12.4734 15.0169 11.3053 13.6725 11.3053C12.3281 11.3053 11.2383 12.4734 11.2383 13.9142C11.2383 15.3551 12.3281 16.5231 13.6725 16.5231Z" stroke="#5423A1" stroke-width="2" stroke-miterlimit="10"/>
            <path d="M5.55826 16.5231C6.90265 16.5231 7.99249 15.3551 7.99249 13.9142C7.99249 12.4734 6.90265 11.3053 5.55826 11.3053C4.21387 11.3053 3.12402 12.4734 3.12402 13.9142C3.12402 15.3551 4.21387 16.5231 5.55826 16.5231Z" stroke="#5423A1" stroke-width="2" stroke-miterlimit="10"/>
            <path d="M21.7858 16.5231C23.1302 16.5231 24.22 15.3551 24.22 13.9142C24.22 12.4734 23.1302 11.3053 21.7858 11.3053C20.4414 11.3053 19.3516 12.4734 19.3516 13.9142C19.3516 15.3551 20.4414 16.5231 21.7858 16.5231Z" stroke="#5423A1" stroke-width="2" stroke-miterlimit="10"/>
            </svg>'''),
            label: 'More',
          ),
        ],

      ),
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}