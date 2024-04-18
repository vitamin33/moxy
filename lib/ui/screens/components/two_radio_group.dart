import 'package:flutter/material.dart';
import 'package:moxy/ui/theme/app_theme.dart';

// ignore: must_be_immutable
class TwoRadioGroup extends StatelessWidget {
  RadioItem firstOption;
  RadioItem secondOption;
  int? selectedIndex;
  ValueChanged<RadioItem> onItemSelected;
  ButtonsOrientation orientation;
  bool showOnlySelected;

  TwoRadioGroup({
    super.key,
    required this.firstOption,
    required this.secondOption,
    required this.onItemSelected,
    this.orientation = ButtonsOrientation.vertical,
    this.showOnlySelected = false,
    this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    bool firstSelected = firstOption.index == selectedIndex;
    bool secondSelected = secondOption.index == selectedIndex;
    bool showFirst = firstSelected || !showOnlySelected;
    bool showSecond = secondSelected || !showOnlySelected;
    List<Widget> radioButtons = [
      showFirst
          ? ListTile(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: firstSelected ? AppTheme.pinkDark : AppTheme.gray,
                    width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              onTap: () {
                onItemSelected(firstOption);
              },
              selected: firstSelected,
              title: Text(firstOption.label),
              subtitle: firstOption.subtitle != null
                  ? Text(firstOption.subtitle!)
                  : Container(),
              leading: firstOption.icon,
              selectedColor: AppTheme.textColor,
              trailing: Radio<RadioItem>(
                value: firstOption,
                groupValue: _getSelectedItem(),
                onChanged: (RadioItem? value) {
                  selectedIndex = value?.index;
                  final selected = _getSelectedItem();
                  if (selected != null) {
                    onItemSelected(selected);
                  }
                },
              ),
            )
          : const SizedBox.shrink(),
      const SizedBox(height: 10),
      showSecond
          ? ListTile(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: secondSelected ? AppTheme.pinkDark : AppTheme.gray,
                    width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              onTap: () {
                onItemSelected(secondOption);
              },
              selected: secondSelected,
              selectedColor: AppTheme.textColor,
              title: Text(secondOption.label),
              subtitle: secondOption.subtitle != null
                  ? Text(secondOption.subtitle!)
                  : Container(),
              leading: secondOption.icon,
              trailing: Radio<RadioItem>(
                value: secondOption,
                groupValue: _getSelectedItem(),
                onChanged: (RadioItem? value) {
                  selectedIndex = value?.index;
                  final selected = _getSelectedItem();
                  if (selected != null) {
                    onItemSelected(selected);
                  }
                },
              ),
            )
          : const SizedBox.shrink(),
    ];

    if (orientation == ButtonsOrientation.vertical) {
      return Column(
        children: radioButtons,
      );
    } else {
      return Row(
        children: radioButtons,
      );
    }
  }

  RadioItem? _getSelectedItem() {
    if (firstOption.index == selectedIndex) {
      return firstOption;
    } else if (secondOption.index == selectedIndex) {
      return secondOption;
    } else {
      return null;
    }
  }
}

class RadioItem {
  int index;
  Widget icon;
  String label;
  String? subtitle;
  RadioItem(this.index, this.icon, this.label, [this.subtitle]);
}

enum ButtonsOrientation { horizontal, vertical }
