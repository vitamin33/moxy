import 'package:flutter/material.dart';
import 'package:moxy/ui/screens/components/onhover.dart';
import 'package:moxy/ui/theme/app_theme.dart';

import '../../../constant/product_colors.dart';

class FilterContainer extends StatelessWidget {
  const FilterContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        height: 150,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Сумки ",
              style: TextStyle(
                color: Color(0xFF0C0C0C),
                fontSize: 42,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "(34)",
              style: TextStyle(
                color: Color(0xFF0C0C0C),
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ]),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              DropdownButtonExample(),
              SizedBox(
                width: 20,
              ),
            ],
          )
        ]),
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  ProductColor dropdownValue = ProductColor.black;

  @override
  Widget build(BuildContext context) {
    return OnHover(builder: (isHovered) {
      return Container(
        color: isHovered ? AppTheme.white : AppTheme.white,
        child: DropdownButton<ProductColor>(
          focusColor: AppTheme.white,
          dropdownColor: AppTheme.white,
          iconEnabledColor: AppTheme.black,
          iconDisabledColor: AppTheme.black,
          value: dropdownValue,
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
          ),
          onChanged: (ProductColor? color) {
            setState(() {
              dropdownValue = color!;
            });
          },
          items: ProductColor.values.map((ProductColor color) {
            return DropdownMenuItem<ProductColor>(
              value: color,
              child: Text(
                color.color,
              ),
            );
          }).toList(),
        ),
      );
    });
  }
}
