import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Winner implements Comparable {
  final String id;
  final String firstName;
  final String lastName;
  final String category;
  final String year;
  final String motivation;
  final String share;

  Winner(this.id, this.firstName, this.lastName, this.category, this.year,
      this.motivation, this.share);

  static Future<List<Winner>> getWinners(
      {String category = '', String year = ''}) async {
    final response = await http.get(Uri.parse(
        'http://api.nobelprize.org/v1/prize.json?category=$category&year=$year'));
    final data = jsonDecode(response.body)['prizes'];
    if (response.statusCode == 200) {
      final winners = List<Winner>.empty(growable: true);
      for (var e in data) {
        final laureates = (e['laureates']);
        if (laureates != null) {
          for (var laureate in laureates) {
            winners.add(Winner(
                laureate['id'] ?? '',
                laureate['firstname'] ?? '',
                laureate['surname'] ?? '',
                e['category'] ?? '',
                e['year'] ?? '',
                laureate['motivation'] ?? '',
                laureate['share'] ?? ''));
          }
        }
      }
      return winners
          .where((element) => (int.parse(element.year) >= 1900 &&
              int.parse(element.year) <= 2018))
          .toList();
    }
    throw const HttpException('Some error occurred');
  }

  static Future<List<Winner>> getWinnersMoreThanOnce() async {
    final winners = await getWinners();
    final List<Winner> moreThanOnce = [];
    for (var winner in winners) {
      var count = 0;
      for (var otherWinner in winners) {
        if (winner.compareTo(otherWinner) == 0) {
          count++;
        }
      }
      if (count > 1) {
        moreThanOnce.add(winner);
      }
    }
    moreThanOnce.sort();
    return moreThanOnce;
  }

  @override
  String toString() {
    return '$id $firstName $lastName $category $year';
  }

  @override
  int compareTo(other) {
    return '$firstName $lastName'
        .compareTo('${other.firstName} ${other.lastName}');
  }
}
