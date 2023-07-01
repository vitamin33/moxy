import 'package:flutter/material.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class CustomRadio extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const CustomRadio({Key? key, required this.value, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onChanged != null) {
          onChanged!(!value);
        }
      },
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 2,
            color: value ? Colors.black : Colors.grey,
          ),
        ),
        child: value
            ? const CircleAvatar(
                backgroundColor: AppTheme.pink,
                child: Padding(
                  padding: EdgeInsets.all(3.0),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: AppTheme.black,
                  ),
                ),
              )
            : Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.pink,
                ),
              ),
      ),
    );
  }
}
