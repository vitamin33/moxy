import 'package:flutter/material.dart';

class ExpandableShippingText extends StatefulWidget {
  final String collapsedText;
  final int maxLines;
  final String? additionalText;
  final String? price;

  ExpandableShippingText({
    required this.collapsedText,
    required this.price,
    this.maxLines =
        1, // Change this to the desired number of lines to display initially
    this.additionalText,
  });

  @override
  _ExpandableShippingTextState createState() => _ExpandableShippingTextState();
}

class _ExpandableShippingTextState extends State<ExpandableShippingText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final richTextCollapsed = Text.rich(
      TextSpan(
        children: [
          TextSpan(text: widget.collapsedText),
          const TextSpan(text: ' '),
          TextSpan(
              text: widget.price,
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      maxLines: widget.maxLines,
      overflow: TextOverflow.ellipsis,
    );
    final richTextExpanded = Text.rich(
      TextSpan(
        children: [
          TextSpan(text: widget.collapsedText),
          const TextSpan(text: ' '),
          TextSpan(
              text: widget.price,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const TextSpan(text: '\n'),
          TextSpan(text: widget.additionalText),
        ],
      ),
    );
    return InkWell(
      hoverColor: Colors.transparent,
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AnimatedCrossFade(
                crossFadeState: _isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: Duration(milliseconds: 300), // Customize the duration
                firstChild: richTextCollapsed,
                secondChild: richTextExpanded,
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Icon(
              _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: Colors.blue, // Customize the color
            ),
          ),
        ],
      ),
    );
  }
}
