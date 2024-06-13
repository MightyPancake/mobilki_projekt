import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proj/utils/themes.dart';
import 'package:provider/provider.dart';  // Import provider
import '../../friend_app.dart';
import '../../main.dart';  // Import main.dart to access MyAppState

class AddFriendView extends StatefulWidget {
  final Function() onAdd;

  AddFriendView({required this.onAdd});

  @override
  _AddFriendViewState createState() => _AddFriendViewState();
}

class _AddFriendViewState extends State<AddFriendView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _freqController = TextEditingController();
  int _selectedDay = 1;
  String _selectedMonth = 'Styczeń';
  int _selectedYear = DateTime.now().year;
  String? _tempImagePath;
  List<String> _selectedTags = [];
  final List<int> _days = List<int>.generate(31, (i) => i + 1);
  final List<String> _months = [
    'Styczeń', 'Luty', 'Marzec', 'Kwiecień', 'Maj', 'Czerwiec',
    'Lipiec', 'Sierpień', 'Wrzesień', 'Październik', 'Listopad', 'Grudzień'
  ];
  final List<int> _years = List<int>.generate(DateTime.now().year - 1899, (i) => 1900 + i);

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _tempImagePath = pickedFile.path;
      });
    }
  }

  void _toggleTag(String tag) {
    setState(() {
      if (_selectedTags.contains(tag)) {
        _selectedTags.remove(tag);
      } else {
        _selectedTags.add(tag);
      }
    });
  }

  void _addFriend() {
    if (_nameController.text.isEmpty ||
        _descController.text.isEmpty ||
        _freqController.text.isEmpty ||
        _tempImagePath == null ||
        _selectedTags.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Brak danych'),
            content: Text('Musisz uzupełnić wszystkie pola.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    final newFriend = Friend(
      name: _nameController.text,
      desc: _descController.text,
      birthday: DateTime(_selectedYear, _months.indexOf(_selectedMonth) + 1, _selectedDay),
      notificationFreq: int.parse(_freqController.text),
      tags: List.from(_selectedTags),
      picture: _tempImagePath ?? 'assets/img/default_avatar.jpg',
    );

    // Add friend to MyAppState
    Provider.of<MyAppState>(context, listen: false).friends.add(newFriend);

    widget.onAdd();
    
    // Call saveDataToFirebase after adding the new friend
    Provider.of<MyAppState>(context, listen: false).saveDataToFirebase();

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var theme = myTheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: IconThemeData(
          color: theme.colorScheme.surface,
        ),
        toolbarHeight: 90.0,
        actions: const [
          SizedBox(
            width: 15.0,
          ),
        ],
        title: Text(
          'Dodaj Przyjaciela',
          style: toolbarTextStyle,
        ),
        backgroundColor: theme.colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 150.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 120.0),
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 240.0,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 110.0, left: 45.0, right: 45.0),
                child: Column(
                  children: [
                    inputTextField("Imię i nazwisko", _nameController),
                    tagsPicker("Tag"),
                    inputTextField("Opis", _descController),
                    datePickerField("Urodziny"),
                    inputTextField("Częstość powiadomień [dni]", _freqController, isNumeric: true),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
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
                          const SizedBox(width: 10.0,),
                          ElevatedButton(
                            onPressed: _addFriend,
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(theme.colorScheme.inversePrimary),
                              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                ),
                              ),
                            ),
                            child: Text(
                              'Zapisz',
                              style: TextStyle(
                                color: theme.colorScheme.surface,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ]
                ),
              ),
            ),
            Positioned(
              top: 30.0,
              child: Stack(
                children: [
                  CircleAvatar(
                    backgroundImage: _tempImagePath != null
                      ? FileImage(File(_tempImagePath!))
                      : const AssetImage('assets/img/default_avatar.jpg') as ImageProvider,
                    radius: 90.0,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: ElevatedButton(
                      onPressed: _pickImage,
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(5),
                        backgroundColor: theme.colorScheme.primary,
                      ),
                      child: Icon(Icons.edit, color: theme.colorScheme.surface, size: 20,),
                    ),
                  )
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget inputTextField(String caption, TextEditingController controller, {bool isNumeric = false}) {
    var theme = myTheme;
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
        TextField(
          maxLines: null,
          controller: controller,
          keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
          inputFormatters: isNumeric ? [FilteringTextInputFormatter.digitsOnly] : [],
          decoration: InputDecoration(
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

  Widget datePickerField(String caption) {
    var theme = myTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
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

  Widget tagsPicker(String caption) {
    var theme = myTheme;
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
                spacing: 5.0,
                runSpacing: 7.0,
                children: [
                  for (String tag in tagColors.keys) 
                    GestureDetector(
                      onTap: () => _toggleTag(tag),
                      child: drawEditableTag(tag, tagColors),
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget drawEditableTag(String tag, Map<String, Color> tagColors) {
    var theme = myTheme;
    bool isSelected = _selectedTags.contains(tag);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: tagColors[tag],
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: isSelected ? theme.colorScheme.inversePrimary : Colors.transparent,
          width: 3.0,
        ),
      ),
      child: Text(
        tag,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontFamily: 'Montserrat',
        ),
      ),
    );
  }
}
