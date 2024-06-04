import 'package:flutter/material.dart';
import 'package:proj/themes.dart';
import 'friend_detail.dart';
import 'friend_app.dart';
import 'add_friend.dart';

class FriendsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = myTheme;
    var tagColors = {
      "przyjaciel": COLOR_TAG_PINK,
      "praca": COLOR_TAG_PURPLE,
      "rodzina": COLOR_TAG_GREEN,
      "znajomy": COLOR_TAG_YELLOW,
    };
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
          color: myTheme.colorScheme.surface,
        ),
        toolbarHeight: 90.0,
        title: Text(
          'Bliscy',
          style: toolbarTextStyle,
        ),
        backgroundColor: theme.colorScheme.primary,
      ),
      body: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (context, index) {
          final friend = friends[index];
          return Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 8.0), // Add vertical margin
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            FriendDetailView(friend: friends[index])),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                  padding: EdgeInsets.only(right: 50.0),
                  decoration: BoxDecoration(
                    color: tagColors[friend.tags],
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: .0, horizontal: 8.0),
                      width: 100.0,
                      height: 260.0,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.inversePrimary,
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 14),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                40.0), // Adjust the radius as needed
                            child: Image.network(
                              friend.picture,
                              height: 240.0,
                              width: 240.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 40),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                friend.name,
                                style: TextStyle(
                                  color: theme.colorScheme.primary,
                                  fontSize: 32.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (String tag in friend.tags)
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 6.0),
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: tagColors[tag],
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Text(
                                        tag,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              const Row(
                                children: [
                                  Text(
                                    "Last meeting:",
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Never",style: TextStyle(
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      )),
                ),
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add friend screen
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AddFriendView()), // Replace with your new screen
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
