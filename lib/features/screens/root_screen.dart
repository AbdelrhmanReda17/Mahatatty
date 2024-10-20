import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/features/settings/presentation/screens/settings_screen.dart';
import 'package:mahattaty/features/train_booking/presentation/screens/user_tickets_screen.dart';
import 'explore_screen.dart';
import 'main_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});
  String get homeRouteName => '/root/home';
  String get exploreRouteName => '/root/explore';
  String get profileRouteName => '/root/profile';
  String get myTicketRouteName => '/root/my_ticket';
  @override
  RootScreenState createState() => RootScreenState();
}

class RootScreenState extends State<RootScreen> {
  int _selectedPageIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    switch (widget.key) {
      case const Key('home_screen'):
        _selectedPageIndex = 0;
        break;
      case const Key('explore_screen'):
        _selectedPageIndex = 1;
        break;
      case const Key('my_ticket_screen'):
        _selectedPageIndex = 2;
        break;
      case const Key('profile_screen'):
        _selectedPageIndex = 3;
        break;
      default:
        _selectedPageIndex = 0;
    }
  }

  static const List<Widget> _screens = [
    MainScreen(),
    ExploreScreen(),
    UserTicketsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else {
          exit(0);
        }
        return Future.value(true);
      },
      child: Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: _screens[_selectedPageIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedIconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.primary,
          ),
          type: BottomNavigationBarType.fixed,
          unselectedIconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.house),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.bagShopping),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.ticket),
              label: 'My Ticket',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.user),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedPageIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
