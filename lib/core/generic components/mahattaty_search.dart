import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/news/presentation/screens/news_search_screen.dart';
import '../utils/open_screens.dart';

class MahattatySearch extends StatelessWidget {
  const MahattatySearch({
    super.key,
    required this.onPressed,
  });

  final Function(String value) onPressed;

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return TextField(
      controller: searchController,
      cursorColor: Theme.of(context).colorScheme.surface,
      style: TextStyle(color: Theme.of(context).colorScheme.surface),
      onSubmitted: (value) {
        if (searchController.text.isNotEmpty) {
          onPressed(value);
          searchController.clear();
        }
      },
      decoration: InputDecoration(
        hintText: 'What are you looking for?',
        hintStyle:
            TextStyle(color: Theme.of(context).colorScheme.primaryContainer),
        fillColor: Theme.of(context).colorScheme.primary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.surface, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.surface, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.surface, width: 1.0),
        ),
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
        suffixIcon: IconButton(
          icon: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.surface,
          ),
          onPressed: () {
            if (searchController.text.isNotEmpty) {
              onPressed(searchController.text);
              searchController.clear();
            }
          },
        ),
      ),
    );
  }
}
