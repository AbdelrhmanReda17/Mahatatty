import 'package:flutter/material.dart';

// ignore: camel_case_types
enum backgroundHeight { small, medium, large }

class MahattatyScaffold extends StatelessWidget {
  final Widget body;
  final Widget? appBarContent;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final double appBarHeight;
  final backgroundHeight bgHeight;

  const MahattatyScaffold({
    super.key,
    required this.body,
    this.appBarContent,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.appBarHeight = 70,
    this.bgHeight = backgroundHeight.small,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf5f5f5),
      appBar: AppBar(
        titleSpacing: 0,
        toolbarHeight: appBarHeight,
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0.0,
        title: appBarContent,
      ),
      body: Stack(
        children: [
          Container(
            color: Theme.of(context).colorScheme.primary,
            height: bgHeight == backgroundHeight.small
                ? MediaQuery.of(context).size.height * 0.1
                : bgHeight == backgroundHeight.medium
                    ? MediaQuery.of(context).size.height * 0.2
                    : MediaQuery.of(context).size.height * 0.3,
          ),
          body,
        ],
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
