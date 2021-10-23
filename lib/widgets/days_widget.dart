import 'package:flutter/material.dart';

class DaysWidget extends StatefulWidget {
  String? label;
  bool value;
  Function? onChanged;

  DaysWidget({this.label, this.value = false, this.onChanged});

  @override
  _DaysWidgetState createState() => _DaysWidgetState();
}

class _DaysWidgetState extends State<DaysWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 60,
        height: 65,
        child: Column(
          children: [
            FittedBox(child: Text(widget.label!)),
            Checkbox(
              value: widget.value,
              onChanged: (v) {
                return widget.onChanged!(v);
              },
            )
          ],
        ),
      ),
    );
  }
}
