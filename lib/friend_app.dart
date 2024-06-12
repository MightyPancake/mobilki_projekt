// friend_app.dart

class Friend {
  String name;
  String picture;
  DateTime birthday;
  List<String> tags;
  String desc;
  int notificationFreq;
  List<DateTime>? meetingList;

  Friend({
    required this.name,
    String? picture,
    required this.birthday,
    required this.tags,
    required this.desc,
    required this.notificationFreq,
    this.meetingList,
  }) : picture = picture == null || picture.isEmpty ? "assets/img/default_avatar.jpg" : picture;

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      name: json['name'],
      picture: json['picture'] ?? "assets/img/default_avatar.jpg",
      birthday: DateTime.parse(json['birthday']),
      tags: List<String>.from(json['tags']),
      desc: json['desc'],
      notificationFreq: json['notificationFreq'],
      meetingList: json['meetingList'] != null ? List<DateTime>.from(json['meetingList'].map((date) => DateTime.parse(date))) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'picture': picture,
      'birthday': birthday.toIso8601String(),
      'tags': tags,
      'desc': desc,
      'notificationFreq': notificationFreq,
      'meetingList': meetingList?.map((date) => date.toIso8601String()).toList(),
    };
  }

  factory Friend.fromMap(Map<String, dynamic> map) {
    return Friend(
      name: map['name'],
      picture: map['picture'],
      birthday: DateTime.parse(map['birthday']),
      tags: List<String>.from(map['tags']),
      desc: map['desc'],
      notificationFreq: map['notificationFreq'],
      meetingList: map['meetingList'] != null
          ? List<DateTime>.from(map['meetingList'].map((date) => DateTime.parse(date)))
          : [],
    );
  }
}

class Event {
  final String title;
  final DateTime date;
  final List<Friend> friends;

  Event({
    required this.title,
    required this.date,
    required this.friends,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': date.toIso8601String(),
      'friends': friends.map((friend) => friend.toMap()).toList(),
    };
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['title'],
      date: DateTime.parse(json['date']),
      friends: List<Friend>.from(json['friends'].map((friendJson) => Friend.fromJson(friendJson))),
    );
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      title: map['title'],
      date: DateTime.parse(map['date']),
      friends: List<Friend>.from(map['friends'].map((friend) => Friend.fromMap(friend))),
    );
  }
}
List<Friend> friends = [];

// List<Friend> friends = [
//   Friend(
//     name: "Alicja Przybylska",
//     picture: "assets/img/alicja.jpg",
//     birthday: DateTime(2002, 11, 23),
//     tags: ["rodzina", "przyjaciel"],
//     desc: "Hi, my name is Alice. I love ducks! They're so adorable <3 I also like dogs, but ducks are definitely superior. In my free time I like to jog and read books becasue I'm boring. Jk, books are awesome, change my mind!",
//     notificationFreq: 30,
//     meetingList: [DateTime(2024, 06, 01)],
//   ),
//   Friend(
//     name: "Marcin Wiśniewski",
//     picture: "assets/img/marcin.jpg",
//     birthday: DateTime(1999, 02, 12),
//     tags: ["praca"],
//     desc: "Mechanik samochodowy z kręconymi, rudymi włosami i piegowatą twarzą, miłośnik rajdów samochodowych i muzyki rockowej.",
//     notificationFreq: 45,
//     meetingList: [],
//   ),
//   Friend(
//     name: "Bob",
//     picture: "assets/img/bob.jpg",
//     birthday: DateTime(1989, 02, 12),
//     tags: ["praca", "znajomy"],
//     desc: "Bob to wysoki informatyk z ciemnymi, krótko przyciętymi włosami i okularami, który w weekendy wspina się po górach i gra w turniejach e-sportowych.",
//     notificationFreq: 14,
//     meetingList: [],
//   ),
//   Friend(
//     name: "Mama",
//     picture: "assets/img/mama.jpg",
//     birthday: DateTime(1965, 12, 12),
//     tags: ["rodzina"],
//     desc: "To moja mama.",
//     notificationFreq: 4,
//     meetingList: [],
//   ),
//   Friend(
//     name: "Roxanne",
//     picture: "",
//     birthday: DateTime(1989, 02, 12),
//     tags: ["znajomy"],
//     desc: "No description.",
//     notificationFreq: 144,
//     meetingList: [],
//   ),
// ];

List<Event> events = [];
// List<Event> events = [
//   Event(title: "Meet up!", date: DateTime(2024, 05, 12, 16, 30), friends: [friends[0]])
// ];
