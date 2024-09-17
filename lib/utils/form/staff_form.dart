import 'package:flutter/material.dart';

class StaffForm extends StatefulWidget {
  final double width;
  final double height;
  const StaffForm({super.key, required this.width, required this.height});

  @override
  State<StaffForm> createState() => _StaffFormState();
}

class _StaffFormState extends State<StaffForm> {
  @override
  Widget build(BuildContext context) {
    return widget.width >= 350
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
            ),
            height: widget.height,
            width: widget.width,
            child: const Text("hello"),
          )
        : Container();
  }
}
