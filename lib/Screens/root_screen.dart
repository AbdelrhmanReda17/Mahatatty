import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/Providers/auth_provider.dart';
import 'package:mahattaty/Screens/authentication_screen.dart';
import 'package:mahattaty/Screens/home_screen.dart';
import 'package:mahattaty/Utils/open_screens.dart';
import 'explore_screen.dart';

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

  static const List<Widget> _screens = [
    HomeScreen(),
    ExploreScreen(),
    Placeholder(),
    Placeholder(),
  ];

  @override
  Widget build(BuildContext context) {
    final authNotifier = ref.read(authProvider.notifier);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: _screens[_selectedPageIndex],
          ),
          ElevatedButton(
            onPressed: () {
              authNotifier.signOut();
              openScreen(
                context: context,
                routeName: const AuthenticationScreen().loginRouteName,
                isReplace: true,
              );
            },
            child: const Text('Go Back'),
          ),
        ],
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
