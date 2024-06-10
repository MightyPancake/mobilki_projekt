import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proj/friend_detail/friend_edit.dart';
import 'package:proj/utils/components.dart';
import 'package:proj/utils/dialog_windows.dart';
import 'package:proj/utils/themes.dart';
import '../friend_app.dart';


class FriendDetailView extends StatefulWidget {
  final Friend friend;
  final Function() onUpdate;

  FriendDetailView({required this.friend, required this.onUpdate});

  @override
  _FriendDetailViewState createState() => _FriendDetailViewState();
}

class _FriendDetailViewState extends State<FriendDetailView> {
  int daysUntilNextMeeting(Friend friend) {
    if (friend.meetingList == null || friend.meetingList!.isEmpty) {
      return 0;
    } else {
      final today = DateTime.now();
      final diff = today.difference(friend.meetingList!.last).inDays;
      final daysLeft = friend.notificationFreq - diff;
      if (daysLeft < 0) {
        return 0;
      }
      return daysLeft;
    }
  }

  void _updateState() {
    setState(() {});
    widget.onUpdate(); // Notify parent
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
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditFriendView(
                    friend: widget.friend,
                    onUpdate: _updateState,
                  ),
                ),
              );
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 110.0, left: 45.0, right: 45.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.friend.name,
                          textAlign: TextAlign.center,
                          style: titleStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 3.0,
                                runSpacing: -5.0,
                                children: [
                                  for (String tag in widget.friend.tags) drawTag(tag, tagColors),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30.0),
                          child: Text(
                            widget.friend.desc,
                            textAlign: TextAlign.justify,
                            style: paragraphStyle,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Urodziny:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.inversePrimary,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: theme.colorScheme.shadow),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                DateFormat('MMM d').format(widget.friend.birthday),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Asap',
                                  fontWeight: FontWeight.w700,
                                  color: theme.colorScheme.outline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 20.0, bottom: 10.0, right: 5.0),
                              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                              width: 190,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: theme.colorScheme.tertiary,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const Icon(Icons.notifications_active_outlined, color: COLOR_TAG_PINK, size: 35,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'powiadomienia',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w300,
                                          color: theme.colorScheme.inversePrimary,
                                        ),
                                      ),
                                      Row(children: [
                                        Text(
                                          "co ",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Asap',
                                            fontWeight: FontWeight.w400,
                                            color: theme.colorScheme.inversePrimary,
                                          ),
                                        ),
                                        Text(
                                          "${widget.friend.notificationFreq} dni",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Asap',
                                            fontWeight: FontWeight.w700,
                                            color: theme.colorScheme.inversePrimary,
                                          ),
                                        ),
                                      ],)
                                    ],
                                  ),
                                ]
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                              padding: const EdgeInsets.symmetric(vertical: 15.0),
                              width: 105,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0x7f9db3f9),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'spotkań',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w300,
                                          color: theme.colorScheme.inversePrimary,
                                        ),
                                      ),
                                      Row(children: [
                                        Text(
                                          "${widget.friend.meetingList?.length}",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Asap',
                                            fontWeight: FontWeight.w400,
                                            color: theme.colorScheme.inversePrimary,
                                          ),
                                        ),
                                      ],)
                                    ],
                                  ),
                                ]
                              ),
                            ),
                          ]
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10.0, bottom: 100.0),
                          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                          width: 300,
                          decoration: BoxDecoration(
                            border: Border.all(color: theme.colorScheme.shadow),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.access_time_rounded, color: theme.colorScheme.outline, size: 35.0,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Następny kontakt:',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Asap',
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  Text(
                                    "${daysUntilNextMeeting(widget.friend)} dni",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Asap',
                                      fontWeight: FontWeight.w700
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(Icons.arrow_forward_ios, color: theme.colorScheme.inversePrimary, size: 40.0,),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AddMeetingDialog(friend: widget.friend),
                                  ).then((_) => _updateState());
                                },
                              ),
                            ]
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 30.0,
              child: CircleAvatar(
                backgroundImage: widget.friend.picture.startsWith("assets/img/")
                      ? AssetImage(widget.friend.picture)
                      : FileImage(File(widget.friend.picture)) as ImageProvider,
                radius: 90.0,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 50,
        width: 180,
        margin: const EdgeInsets.all(10.0),
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AddMeetingDialog(friend: widget.friend),
            ).then((_) => _updateState());
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add),
              Text(
                'zapisz spotkanie',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.w400,
                    color: theme.colorScheme.surface,
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}