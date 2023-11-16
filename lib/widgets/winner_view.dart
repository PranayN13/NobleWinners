import 'dart:math';

import 'package:flutter/material.dart';
import 'package:noble_winners/models/winners.dart';

Random random = Random();

class WinnerView extends StatelessWidget {
  final Winner winner;
  const WinnerView({super.key, required this.winner});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Center(
              child: Image(
                image: AssetImage('assets/1.jpg'),
                width: 160,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${winner.firstName} ${winner.lastName}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text('Category: ${winner.category}'),
                    Text('Year: ${winner.year}'),
                    Text(winner.motivation, overflow: TextOverflow.visible,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
