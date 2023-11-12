import 'package:flutter/material.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class FilterContainer extends StatelessWidget {
  final String title;
  final String productCount;
  const FilterContainer(
      {super.key, required this.title, required this.productCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        height: 150,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF0C0C0C),
                fontSize: 42,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "($productCount)",
              style: const TextStyle(
                color: Color(0xFF0C0C0C),
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ]),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              TestSelect(
                title: 'Color',
                dropDownItems: colors,
              ),
              const SizedBox(
                width: 10,
              ),
              TestSelect(
                title: 'Price',
                dropDownItems: price,
              ),
              const SizedBox(
                width: 10,
              ),
              TestSelect(
                title: 'New',
                dropDownItems: time,
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          )
        ]),
      ),
    );
  }
}

class TestSelect extends StatefulWidget {
  final String title;
  final List<String> dropDownItems;
  const TestSelect(
      {super.key, required this.title, required this.dropDownItems});

  @override
  State<TestSelect> createState() => _TestSelectState();
}

class _TestSelectState extends State<TestSelect> {
  var myServices;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        height: 50,
        width: 150,
        decoration: const BoxDecoration(
            color: AppTheme.white,
            border:
                Border(bottom: BorderSide(width: 2, color: AppTheme.black))),
        child: Center(
          child: DropdownButton<String>(
              hint: Text(widget.title),
              elevation: 16,
              underline: const SizedBox(),
              isExpanded: true,
              style: const TextStyle(color: Colors.black, fontSize: 16.0),
              onChanged: (String? changedValue) {
                myServices = changedValue;
                setState(() {
                  myServices;
                });
              },
              value: myServices,
              items: widget.dropDownItems.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList()),
        ),
      ),
    ]);
  }
}

List<String> colors = [
  'Black',
  'White',
  'Grey',
  'Pink',
  'PinkLeo',
  'Leo',
  'Brown',
  'Beige',
  'Purple',
  'Zebra',
  'Jeans',
  'Green',
  'Bars',
  'Unified'
];
List<String> price = ['400-800', '800-1200', '1200<'];
List<String> time = [
  'New-Old',
  'Old-New',
];
