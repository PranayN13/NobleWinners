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
  @override
  Widget build(BuildContext context) {
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
            future: Winner.getWinners(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!;
                if(showGrid){
                  return GridView.builder(
                    itemCount: data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (width / 600).round(),
                      childAspectRatio: width / 300,
                    ),
                    itemBuilder: (BuildContext context, int index) =>
                        WinnerView(winner: data[index]),
                  );
                }
                else{
                  return ListView.builder(
                      itemCount: data.length,
                      padding: const EdgeInsets.all(24),
                      itemBuilder: (context, index) =>
                          WinnerView(winner: data[index]));
                }
              }
              return const CircularProgressIndicator();
            },
          ),
        ));
  }
}
