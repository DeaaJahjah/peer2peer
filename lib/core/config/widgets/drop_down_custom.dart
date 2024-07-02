import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/constant/constant.dart';

class DropDownCustom extends StatefulWidget {
  List<String> categories;
  String selectedItem;
  Function(String?)? onChanged;
  DropDownCustom({Key? key, required this.categories, required this.selectedItem, this.onChanged}) : super(key: key);

  @override
  State<DropDownCustom> createState() => _DropDownCustomState();
}

class _DropDownCustomState extends State<DropDownCustom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 40,
      // width: 120,
      decoration: BoxDecoration(
        border: Border.all(color: dark),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          dropdownColor: white,
          elevation: 10,
          iconEnabledColor: purple,
          style: style1,
          alignment: AlignmentDirectional.center,
          focusColor: purple,
          isDense: true,
          value: widget.selectedItem,
          onChanged: widget.onChanged,
          items: widget.categories.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(items),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
