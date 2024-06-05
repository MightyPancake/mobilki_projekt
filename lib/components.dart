import 'package:flutter/material.dart';
import 'package:proj/themes.dart';

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