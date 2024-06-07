import 'package:flutter/material.dart';
import 'package:proj/utils/themes.dart';

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
      padding: EdgeInsets.symmetric(vertical: 20.0), 
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
        hintText: '$caption...',
        hintStyle: TextStyle(color: theme.colorScheme.shadow, fontFamily: 'Montserrat'),
        border: OutlineInputBorder(),
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.shadow),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.primary),
        ),
      ),
    ),
    ],
  );
}


class DatePickerField extends StatefulWidget {
  final String caption;

  const DatePickerField({Key? key, required this.caption}) : super(key: key);

  @override
  _DatePickerFieldState createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  int _selectedDay = 1;
  String _selectedMonth = 'Styczeń';
  int _selectedYear = DateTime.now().year;

  final List<int> _days = List<int>.generate(31, (i) => i + 1);
  final List<String> _months = [
    'Styczeń', 'Luty', 'Marzec', 'Kwiecień', 'Maj', 'Czerwiec',
    'Lipiec', 'Sierpień', 'Wrzesień', 'Październik', 'Listopad', 'Grudzień'
  ];
  final List<int> _years = List<int>.generate(DateTime.now().year - 1899, (i) => 1900 + i);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context); // Make sure to define or pass the theme appropriately

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            '${widget.caption}:',
            style: TextStyle(
              color: theme.colorScheme.inversePrimary,
              fontWeight: FontWeight.w700,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 50,
              child: DropdownButton<int>(
                value: _selectedDay,
                onChanged: (int? newValue) {
                  setState(() {
                    _selectedDay = newValue!;
                  });
                },
                items: _days.map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
            ),
            SizedBox(width: 10),
            Container(
              width: 120,
              child: DropdownButton<String>(
                value: _selectedMonth,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedMonth = newValue!;
                  });
                },
                items: _months.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SizedBox(width: 10),
            Container(
              width: 70,
              child: DropdownButton<int>(
                value: _selectedYear,
                onChanged: (int? newValue) {
                  setState(() {
                    _selectedYear = newValue!;
                  });
                },
                items: _years.map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}


Widget tagsPicker(String caption) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Text(
          '$caption:',
          style: TextStyle(
            color: theme.colorScheme.inversePrimary,
            fontWeight: FontWeight.w700,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
      Row(
        children: [
          Expanded(
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 3.0,
              runSpacing: -5.0,
              children: [
                for (String tag in tagColors.keys) 
                  drawTag(tag, tagColors),
              ],
            ),
          ),
        ],
      ),
    ],
  );

}
