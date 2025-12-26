import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:my_template/core/commons/constants/colors/app_colors.dart';
import 'package:my_template/core/utils/responsiveness/app_responsiveness.dart';
import 'package:my_template/features/cart/presentation/screens/cart_page.dart';
import 'package:my_template/features/home/presentation/screens/home_page.dart';
import 'package:my_template/features/profile/presentation/screens/profile_page.dart';

class AppBottomNav extends StatefulWidget {
  const AppBottomNav({super.key});

  @override
  State<AppBottomNav> createState() => _AppBottomNavState();
}

class _AppBottomNavState extends State<AppBottomNav> {
  int _currentIndex = 0;

  final List<Widget> pages = [HomePage(), CartPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          pages[_currentIndex],

          Positioned(left: 0, right: 0, bottom: 0, child: _buildBottomNav()),

          Positioned(
            bottom: appH(30),
            left: MediaQuery.of(context).size.width / 2 - appH(32),
            child: _buildCenterButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.greyScale.grey300)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index == 1) return;
            setState(() => _currentIndex = index);
          },

          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedItemColor: AppColors.green,
          iconSize: appH(25),
          items: [
            BottomNavigationBarItem(
              icon: _currentIndex == 0
                  ? Icon(IconlyBold.home)
                  : Icon(IconlyLight.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
            BottomNavigationBarItem(
              icon: _currentIndex == 2
                  ? Icon(IconlyBold.setting)
                  : Icon(IconlyLight.setting),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterButton() {
    return GestureDetector(
      onTap: () {
        setState(() => _currentIndex = 1);
      },
      child: Container(
        height: appH(64),
        width: appH(64),
        decoration: BoxDecoration(
          color: _currentIndex == 1 ? AppColors.green : AppColors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          IconlyBold.bag,
          color: _currentIndex == 1 ? AppColors.white : AppColors.green,
          size: appH(30),
        ),
      ),
    );
  }
}
