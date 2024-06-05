import 'package:flutter/material.dart';
import 'package:proj/themes.dart';

var theme = myTheme;

Widget drawTag(String tag, var tagColors) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
    padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 6.0, top: 6.0),
    decoration: BoxDecoration(
      color: tagColors[tag],
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Text(
      tag,
      style: tagTextStyle,
    ),
  );
}


Widget inputTextField(String caption, TextEditingController controller) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0), 
      child: Text(
        '$caption:',
        style: TextStyle(
          color: theme.colorScheme.inversePrimary,
          fontWeight: FontWeight.w700,
          fontFamily: 'Montserrat',
        ),
      ),
    ),
    TextField(
      maxLines: null,
      controller: controller,
      decoration: InputDecoration(
        // labelText: 'Opis',
        hintText: 'opis...',
        hintStyle: TextStyle(color: theme.colorScheme.shadow, fontFamily: 'Montserrat'),
        border: OutlineInputBorder(),
      ),
    ),
    ],
  );
}
