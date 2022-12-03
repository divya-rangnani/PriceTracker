import 'package:flutter/material.dart';

class CommonDropDown extends StatelessWidget {
  final String? value;
  final String? hintText;
  final List<DropdownMenuItem<String>>? items;
  final void Function(String?)? onChanged;

  const CommonDropDown(
      {required this.value,
      this.hintText,
      required this.items,
      required this.onChanged,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        focusedBorder: commonBorder(),
        enabledBorder: commonBorder(),
        border: const OutlineInputBorder(),
      ),
      child: DropdownButton<String>(
        value: value,
        hint: Text(
          hintText ?? 'Select an Option',
          style: const TextStyle(color: Colors.black38),
        ),
        disabledHint: Text(
          hintText ?? 'Select an Option',
          style: const TextStyle(color: Colors.black38),
        ),
        underline: const SizedBox(),
        isExpanded: true,
        style: const TextStyle(color: Colors.black,fontSize:14.0 ),
        items: items,
        onChanged: onChanged,
      ),
    );
  }

  OutlineInputBorder commonBorder() {
    return  const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1.5),
      borderRadius: BorderRadius.all(Radius.circular(5.0))
    );
  }
}
