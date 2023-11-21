import 'package:flutter/material.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class ProductCategoryChooser extends StatefulWidget {
  final List<String> categories;
  final ValueChanged<String> onCategoryChosen;

  const ProductCategoryChooser(
      {super.key, required this.categories, required this.onCategoryChosen});

  @override
  // ignore: library_private_types_in_public_api
  _ProductCategoryChooserState createState() => _ProductCategoryChooserState();
}

class _ProductCategoryChooserState extends State<ProductCategoryChooser> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    if (widget.categories.isNotEmpty) {
      selectedValue = widget.categories.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Category: ',
            style: theme.titleText,
          ),
          const SizedBox(height: 20),
          DropdownButton<String>(
            value: selectedValue,
            onChanged: (newValue) {
              setState(() {
                selectedValue = newValue!;
                widget
                    .onCategoryChosen(newValue); // Callback with the new value.
              });
            },
            items: widget.categories.map((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
