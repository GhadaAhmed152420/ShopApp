import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Screen',
        ),
      ),
      body: Center(
        child: Text(
          'Search',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
