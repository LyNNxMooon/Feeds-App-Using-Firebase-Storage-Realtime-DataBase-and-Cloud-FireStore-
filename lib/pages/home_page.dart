import 'package:feeds/constants/colors.dart';
import 'package:feeds/pages/add_feed_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kSecondaryColor,
        title: const Text("Feeds"),
        centerTitle: true,
      ),
      backgroundColor: kPrimaryColor,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddFeedPage(),
            )),
      ),
    ));
  }
}
