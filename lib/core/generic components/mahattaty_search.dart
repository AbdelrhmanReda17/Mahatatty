import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MahattatySearch extends StatelessWidget {
  const MahattatySearch({
    super.key,
    required this.onPressed,
  });

  final Function(String value) onPressed;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final primaryContainer = Theme.of(context).colorScheme.primaryContainer;  
    final surface = Theme.of(context).colorScheme.surface;
    
    
    final TextEditingController searchController = TextEditingController();
    return TextField(
      controller: searchController,
      cursorColor: surface,
      style: TextStyle(color: surface),
      onSubmitted: (value) {
        if (searchController.text.isNotEmpty) {
          onPressed(value);
          searchController.clear();
        }
      },
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.searchText,
        hintStyle:
            TextStyle(color: primaryContainer),
        fillColor: primaryColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(
              color: surface, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
              color: surface, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
              color: surface, width: 1.0),
        ),
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
        suffixIcon: IconButton(
          icon: Icon(
            Icons.search,
            color: surface,
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
