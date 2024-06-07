import 'package:flutter/material.dart';
import 'package:proj/utils/components.dart';
import 'package:proj/utils/themes.dart';
import '../friend_app.dart';


class EditFriendView extends StatefulWidget {
  final Friend friend;

  EditFriendView({required this.friend});

  @override
  _EditFriendViewState createState() => _EditFriendViewState();
}


class _EditFriendViewState extends State<EditFriendView> {
  @override
  Widget build(BuildContext context) {
    var theme = myTheme;
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _descController = TextEditingController();
    final TextEditingController _freqController = TextEditingController();

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
        actions: [
          IconButton(
            icon: const Icon(Icons.edit), // Replace with your desired icon
            onPressed: () {
              // Handle button press
            },
          ),
          const SizedBox(
            width: 15.0,
          ),
        ],
        title: Text(
          'Profil',
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
                    const DatePickerField(caption: "Urodziny"),
                    inputTextField("Częstość powiadomień [dni]", _freqController),
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
                            onPressed: () {
                              // Handle save action
                            },
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
                                fontFamily: 'Monserrat',
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
                    backgroundImage: AssetImage(widget.friend.picture),
                    radius: 90.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 120.0, left: 120.0),
                    child: ElevatedButton(
                      onPressed: () {},
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
}