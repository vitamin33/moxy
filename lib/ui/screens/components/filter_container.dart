import 'package:flutter/material.dart';
import 'package:moxy/ui/theme/app_theme.dart';

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
          Text(
            "Сумки",
            style: TextStyle(
              color: Color(0xFF0C0C0C),
              fontSize: 42,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              DropdownButtonExample(),
              SizedBox(
                width: 20,
              ),
              DropdownButtonExample(),
              SizedBox(
                width: 20,
              ),
              DropdownButtonExample(),
            ],
          )
        ]),
      ),
    );
  }
}

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

enum ColorLabel {
  blue('Blue', Colors.blue),
  pink('Pink', Colors.pink),
  green('Green', Colors.green),
  yellow('Yellow', Colors.yellow),
  grey('Grey', Colors.grey);

  const ColorLabel(this.label, this.color);
  final String label;
  final Color color;
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  ColorLabel dropdownValue = ColorLabel.blue;
  final TextEditingController colorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<ColorLabel>> colorEntries =
        <DropdownMenuEntry<ColorLabel>>[];
    for (final ColorLabel color in ColorLabel.values) {
      colorEntries.add(
        DropdownMenuEntry<ColorLabel>(
          value: color,
          label: color.label,
        ),
      );
    }

    return DropdownMenu<ColorLabel>(
      inputDecorationTheme: const InputDecorationTheme(
          fillColor: AppTheme.black,
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: AppTheme.black))),
      initialSelection: ColorLabel.green,
      controller: colorController,
      dropdownMenuEntries: colorEntries,
      onSelected: (ColorLabel? color) {
        setState(() {
          dropdownValue = color!;
        });
      },
    );
  }
}
