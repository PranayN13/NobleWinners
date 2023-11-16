import 'package:flutter/material.dart';
import 'package:noble_winners/models/winners.dart';
import 'package:noble_winners/widgets/filters.dart';
import 'package:noble_winners/widgets/winner_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showGrid = false;
  final scrollController = ScrollController();
  String filterCategory = 'all';
  String filterYear = 'all';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noble Winners'),
      ),
      body: Center(
        child: FutureBuilder(
          future: Winner.getWinners(category: filterCategory, year: filterYear),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!;
              return Row(
                children: [
                  if (width > 800)
                    Container(
                      width: 300,
                      padding: const EdgeInsets.all(24),
                      child: Filters(onCategoryChange: (value){
                        setState(() {
                          filterCategory = value;
                        });
                      }, onYearChange: (value) {
                        setState(() {
                          filterYear = value;
                        });
                      },filterCategory: filterCategory, filterYear: filterYear,)
                    ),
                  Expanded(
                    child: Scrollbar(
                      controller: scrollController,
                      child: ListView.builder(
                          controller: scrollController,
                          itemCount: data.length,
                          padding: const EdgeInsets.all(24),
                          itemBuilder: (context, index) =>
                              WinnerView(winner: data[index])),
                    ),
                  ),
                ],
              );
            }
            if (snapshot.hasError) {
              return const Text('Some error occurred');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: width<=800?FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            showDragHandle: true,
              context: context,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(24.0),
                child: Filters(onCategoryChange: (value){
                  setState(() {
                    filterCategory = value;
                  });
                }, onYearChange: (value) {
                  setState(() {
                    filterYear = value;
                  });
                },filterCategory: filterCategory, filterYear: filterYear,)
              ));
        },
        child: const Icon(Icons.filter_list_sharp),
      ):null,
    );
  }
}
