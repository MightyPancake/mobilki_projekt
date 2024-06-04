import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proj/themes.dart';
import 'friend_app.dart'; // Import your friend model or data class here

class FriendDetailView extends StatelessWidget {
  final Friend friend; // Replace with your actual data model

  FriendDetailView({required this.friend});

  @override
  Widget build(BuildContext context) {
    var tagColors = {
      "przyjaciel": COLOR_TAG_PINK,
      "praca": COLOR_TAG_PURPLE,
      "rodzina": COLOR_TAG_GREEN,
      "znajomy": COLOR_TAG_YELLOW,
    };

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
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 100.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(friend.picture),
                radius: 90.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 180.0, left: 20.0, right: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 28.0),
                  Text(
                    friend.name,
                    textAlign: TextAlign.center,
                    style: titleStyle,
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (String tag in friend.tags)
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 6.0),
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color:
                                tagColors[tag],
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  // Add more details as needed, such as birthdays, upcoming meetings, etc.
                  // For example:
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0), // Add horizontal margins
                    child: Text(
                      friend.desc, 
                      textAlign: TextAlign.justify,
                      style: paragraphStyle,
                    ),
                  ),
                  SizedBox(
                    height: 100.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Birthday:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary, // Use primary color
                        ),
                      ),
                      SizedBox(width: 8.0), // Add spacing between texts
                      Text(
                        DateFormat('MMM d').format(
                            friend.birthday), // Format the birthday date
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: 100.0,
                  // ),
                  Text(
                    'Upcoming Meeting: Nothing yet', // Replace with actual meeting data
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
