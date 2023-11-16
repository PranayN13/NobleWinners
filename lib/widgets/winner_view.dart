import 'package:flutter/material.dart';
import 'package:noble_winners/models/winners.dart';

class WinnerView extends StatelessWidget {
  final Winner winner;
  const WinnerView({super.key, required this.winner});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/noble_medal.png',
                height: 160,
              ),
            ),
            const SizedBox(
              height: 16,
              width: 16,
            ),
            Column(
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
