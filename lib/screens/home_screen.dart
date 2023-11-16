import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Noble Winners'),
          bottom: TabBar(
            isScrollable: true,
            onTap: (index){
            },
            tabs: const [
              Tab(text: 'All',),
              Tab(text: 'Chemistry',),
              Tab(text: 'Peace',),
            ],
          ),
        ),
        body: ListView(),
      ),
    );
  }
}
