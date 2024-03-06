import 'package:flutter/material.dart';

Widget customSearchField(TextEditingController searchController,
    Function() clearSearch, Function() editingComplete) {
  return TextField(
    controller: searchController,
    onEditingComplete: editingComplete,
    decoration: InputDecoration(
      prefixIcon: const Icon(
        Icons.search,
      ),
      suffixIcon: IconButton(
        onPressed: clearSearch,
        icon: const Icon(Icons.cancel),
      ),
      hintText: 'Search...',
      hintStyle: const TextStyle(
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w200,
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(40),
        ),
      ),
    ),
  );
}