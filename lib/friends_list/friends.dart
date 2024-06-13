import 'dart:io';
import 'package:flutter/material.dart';
import 'package:proj/main.dart';
import 'package:proj/utils/themes.dart';
import 'package:provider/provider.dart';
import '../friend_detail/friend_detail.dart';
import '../friend_app.dart';
import 'add_friend.dart';

class FriendsView extends StatefulWidget {
  @override
  _FriendsViewState createState() => _FriendsViewState();
}

class _FriendsViewState extends State<FriendsView> {
  void _refreshState() {
    setState(() {});
  }

  void _addFriend(Friend newFriend) {
    final myAppState = Provider.of<MyAppState>(context);
    setState(() {
      myAppState.friends.add(newFriend);
    });
  }

  @override
  Widget build(BuildContext context) {
    final myAppState = Provider.of<MyAppState>(context);
    var theme = myTheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
          color: theme.colorScheme.surface,
        ),
        toolbarHeight: 90.0,
        title: Text(
          'Bliscy',
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
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 90.0,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: myAppState.friends.length,
                      itemBuilder: (context, index) {
                        final friend = myAppState.friends[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FriendDetailView(
                                    friend: myAppState.friends[index],
                                    onUpdate: _refreshState,
                                  ),
                                ),
                              ).then((_) => _refreshState()); // Refresh when returning from detail view
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: tagColors[friend.tags[0]],
                              ),
                              child: Container(
                                margin: const EdgeInsets.only(right: 15.0),
                                padding: const EdgeInsets.all(10.0),
                                width: double.infinity,
                                height: 160.0,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.tertiary,
                                  borderRadius: BorderRadius.circular(15.0),
                                  border: Border.all(color: theme.colorScheme.shadow, width: 0.5),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(right: 20.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15.0),
                                        child: friend.picture.startsWith("assets/img/")
                                          ? Image.asset(
                                              friend.picture,
                                              height: 155.0,
                                              width: 120.0,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.file(
                                              File(friend.picture),
                                              height: 155.0,
                                              width: 120.0,
                                              fit: BoxFit.cover,
                                            ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
                                            child: Text(
                                              friend.name,
                                              style: displayFriendNameStyle,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Expanded(
                                            child: Wrap(
                                              alignment: WrapAlignment.start,
                                              // spacing: 5.0,
                                              // runSpacing: 5.0,
                                              children: [
                                                for (String tag in friend.tags)
                                                  Container(
                                                    margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                                                    padding: const EdgeInsets.all(5.0),
                                                    decoration: BoxDecoration(
                                                      color: tagColors[tag],
                                                      borderRadius: BorderRadius.circular(5.0),
                                                    ),
                                                    child: Text(tag, style: tagTextStyle),
                                                  ),
                                              ],
                                            ),
                                          ),
                                          // Optionally, you can add the "Last meeting" info here
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 30.0,),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddFriendView(
                onAdd: _refreshState,
              ),
            ),
          ).then((_) => _refreshState()); // Refresh when returning from add friend view
        },
        child: Icon(Icons.add),
      ),
    );
  }
}