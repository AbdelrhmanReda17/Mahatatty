import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/authentication/presentation/controllers/auth_controller.dart';
import 'package:mahattaty/core/screens/explore_screen.dart';
import 'package:mahattaty/core/screens/main_screen.dart';
import 'package:mahattaty/core/utils/open_screens.dart';
import 'package:mahattaty/features/news/presentation/screens/news_screen.dart';

import '../../authentication/presentation/screens/authentication_screen.dart';

class RootScreen extends ConsumerStatefulWidget {
  const RootScreen({super.key});

  String get homeRouteName => '/root/home';

  String get exploreRouteName => '/root/explore';

  String get profileRouteName => '/root/profile';

  String get myTicketRouteName => '/root/my_ticket';

  @override
  RootScreenState createState() => RootScreenState();
}

class RootScreenState extends ConsumerState<RootScreen> {
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
    NewsScreen(),
    Placeholder(),
  ];

  @override
  Widget build(BuildContext context) {
    final authNotifier = ref.read(authControllerProvider.notifier);

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
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
    );
  }
}