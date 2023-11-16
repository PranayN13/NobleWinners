import 'package:flutter/material.dart';
import 'package:noble_winners/screens/more_than_once.dart';

class Filters extends StatefulWidget {
  final String filterCategory;
  final String filterYear;
  final void Function(String) onCategoryChange;
  final void Function(String) onYearChange;
  const Filters({super.key, required this.onCategoryChange, required this.onYearChange, required this.filterCategory, required this.filterYear,});

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  static late String filterCategory;
  static late String filterYear;
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
  @override
  void initState() {
    for (int i = 1900; i <= 2018; i++) {
      years.add(i.toString());
    }
    filterYear = widget.filterYear;
    filterCategory = widget.filterCategory;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categories and Filters',
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
                widget.onCategoryChange(e);
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
                      widget.onYearChange(value!);
                    }),
              )),
          const SizedBox(height: 16,),
          ElevatedButton(onPressed: (){
            setState(() {
              filterYear=years.first;
              filterCategory=categories.first;
            });
            widget.onCategoryChange(filterYear);
            widget.onYearChange(filterYear);
          }, child: const Text('Clear Filters')),
          const SizedBox(height: 4,),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const MoreThanOnce()));
          }, child: const Text('Winners more than once')),
        ]);
  }
}
