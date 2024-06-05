import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:proj/themes.dart';

class AddMeetingDialog extends StatefulWidget {
  const AddMeetingDialog({super.key});

  @override
  _AddMeetingDialogState createState() => _AddMeetingDialogState();
}

class _AddMeetingDialogState extends State<AddMeetingDialog> {
  final TextEditingController _descriptionController = TextEditingController();

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
    var theme = myTheme;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        title: Text('Spotkanie', style: titleStyle,),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        backgroundColor: theme.colorScheme.surface,
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.symmetric(vertical: 15.0), child: Text(
                'Opis:',
                style: TextStyle(
                  color: theme.colorScheme.inversePrimary,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Montserrat',
                ),
              ),),
              TextField(
                maxLines: null,
                controller: _descriptionController,
                decoration: InputDecoration(
                  // labelText: 'Opis',
                  hintText: 'opis...',
                  hintStyle: TextStyle(color: theme.colorScheme.shadow, fontFamily: 'Montserrat'),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0),
              Padding(padding: EdgeInsets.symmetric(vertical: 15.0), child: Text(
                'Data:',
                style: TextStyle(
                  color: theme.colorScheme.inversePrimary,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Montserrat',
                ),
              ),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Anuluj',
              style: TextStyle(
                color: theme.colorScheme.inversePrimary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle save logic
              // For example, save the entered data
              Navigator.of(context).pop();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(theme.colorScheme.inversePrimary),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
            ),
            child: Text(
              'Zapisz',
              style: TextStyle(
                color: theme.colorScheme.surface,
                fontFamily: 'Monserrat',
              ),
            ),
          ),
        ],
      ),
    );
  }
}