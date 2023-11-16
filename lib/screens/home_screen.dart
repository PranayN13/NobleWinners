import 'package:flutter/material.dart';
import 'package:noble_winners/models/winners.dart';
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
    final categories = [
      'all',
      'physics',
      'chemistry',
      'medicine',
      'peace',
      'economics',
      'literature',
    ];
    final years = ['all'];
    for (int i = 1900; i <= 2018; i++) {
      years.add(i.toString());
    }
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Noble Winners'),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => Dialog(
                            child: Container(
                              padding: const EdgeInsets.all(24),
                              width: 400,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Settings',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  CheckboxListTile(
                                    value: showGrid,
                                    onChanged: (value) {
                                      setState(() {
                                        showGrid = !showGrid;
                                      });
                                      Navigator.pop(context);
                                    },
                                    title: const Text('View as Grid'),
                                    subtitle: const Text(
                                        'Switch between list and grid'),
                                  )
                                ],
                              ),
                            ),
                          ));
                },
                icon: const Icon(Icons.settings))
          ],
        ),
        body: Center(
          child: FutureBuilder(
            future: Winner.getWinners(category: filterCategory, year: filterYear),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!;
                return Row(
                  children: [
                    Container(
                      width: 300,
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Categories',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: categories
                                .map((e) => ActionChip(
                                      label: Text(e),
                                      onPressed: () {
                                        setState(() {
                                          filterCategory = e;
                                        });
                                      },
                                      backgroundColor: filterCategory == e
                                          ? Colors.grey
                                          : Colors.transparent,
                                    ))
                                .toList(),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.grey)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  borderRadius: BorderRadius.circular(16),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  isExpanded: true,
                                  value: filterYear,
                                  items: years
                                      .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      filterYear = value!;
                                    });
                                  }),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  filterYear = years.first;
                                  filterCategory = categories.first;
                                });
                              },
                              child: const Text('Clear Filters'))
                        ],
                      ),
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
        ));
  }
}
