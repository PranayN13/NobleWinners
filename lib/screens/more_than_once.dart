import 'package:flutter/material.dart';
import 'package:noble_winners/models/winners.dart';

import '../widgets/winner_view.dart';

class MoreThanOnce extends StatelessWidget {
  const MoreThanOnce({super.key});

  @override
  Widget build(BuildContext context){
  final scrollController = ScrollController();
  return Scaffold(
    appBar: AppBar(title: const Text('Winners More Than Once'),),
    body: Center(
      child: FutureBuilder(
          future: Winner.getWinnersMoreThanOnce(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!;
              return Scrollbar(
                controller: scrollController,
                child: ListView.builder(
                    controller: scrollController,
                    itemCount: data.length,
                    padding: const EdgeInsets.all(24),
                    itemBuilder: (context, index) =>
                        WinnerView(winner: data[index])),
              );
            }
            if (snapshot.hasError) {
              return const Text('Some error occurred');
            }
            return const CircularProgressIndicator();
          },
        ),
    ),
  );
  }
}
