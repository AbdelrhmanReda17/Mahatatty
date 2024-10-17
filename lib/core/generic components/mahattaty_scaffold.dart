import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: camel_case_types
enum backgroundHeight { small, medium, large }

class MahattatyScaffold extends StatelessWidget {
  final Widget body;
  final Widget? appBarContent;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Function? onWillPop;
  final backgroundHeight bgHeight;

  const MahattatyScaffold({
    super.key,
    required this.body,
    this.appBarContent,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.onWillPop,
    this.bgHeight = backgroundHeight.small,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (onWillPop != null) {
          await onWillPop!();
          return Future.value(false);
        }
        Navigator.of(context).pop();
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        drawerEdgeDragWidth: 0,
        appBar: AppBar(
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          titleSpacing: 0,
          backgroundColor: Theme.of(context).colorScheme.primary,
          iconTheme: IconThemeData(color: Theme.of(context).colorScheme.surface),
          elevation: 0,
          title: appBarContent,
        ),
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.8],
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary.withOpacity(0.8),
                  ],
                ),
              ),
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(0),
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
      ),
    );
  }
}
