//Friends
class Friend {
  String name;
  String picture;
  DateTime birthday;
  List<String> tags;
  String desc;
  int notificationFreq;
  List<DateTime>? meetingList;
  int meetingsCount;

  Friend({
    required this.name,
    String? picture,
    required this.birthday,
    required this.tags,
    required this.desc,
    required this.notificationFreq,
    required this.meetingsCount,
    this.meetingList,
  }) : picture = picture == null || picture.isEmpty ? "assets/img/default_avatar.jpg" : picture;
}

List<Friend> friends = [
    Friend(
      name:"Alicja Przybylska",
      picture: "assets/img/alicja.jpg",
      birthday: DateTime(2002, 11, 23),
      tags: ["rodzina", "przyjaciel"],
      desc: "Hi, my name is Alice. I love ducks! They're so adorable <3 I also like dogs, but ducks are definitely superior. In my free time I like to jog and read books becasue I'm boring. Jk, books are awesome, change my mind!",
      notificationFreq: 30,
      meetingList: [DateTime(2024, 06, 01)],
      meetingsCount: 0,
    ),
    Friend(
      name:"Marcin Wiśniewski",
      picture: "assets/img/marcin.jpg",
      birthday: DateTime(1999, 02, 12),
      tags: ["praca"],
      desc: "Mechanik samochodowy z kręconymi, rudymi włosami i piegowatą twarzą, miłośnik rajdów samochodowych i muzyki rockowej.",
      notificationFreq: 45,
      meetingList: [],
      meetingsCount: 0,
    ),
    Friend(
      name:"Bob",
      picture: "assets/img/bob.jpg",
      birthday: DateTime(1989, 02, 12),
      tags: ["praca", "znajomy"],
      desc: "Bob to wysoki informatyk z ciemnymi, krótko przyciętymi włosami i okularami, który w weekendy wspina się po górach i gra w turniejach e-sportowych.",
      notificationFreq: 14,
      meetingList: [],
      meetingsCount: 0,
    ),
    Friend(
      name:"Mama",
      picture: "assets/img/mama.jpg",
      birthday: DateTime(1965, 12, 12),
      tags: ["rodzina"],
      desc: "To moja mama.",
      notificationFreq: 4,
      meetingList: [],
      meetingsCount: 0,
    ),
    Friend(
      name:"Roxanne",
      picture: "",
      birthday: DateTime(1989, 02, 12),
      tags: ["znajomy"],
      desc: "No description.",
      notificationFreq: 144,
      meetingList: [],
      meetingsCount: 0,
    ),
];

//Events
class Event {
  final String title;
  final DateTime date;
  final List<Friend> friends;

  Event({
    required this.title,
    required this.date,
    required this.friends,
  });
}

List<Event> events = [
  Event(title: "Meet up!", date: DateTime(2024, 05, 12, 16, 30), friends: [friends[0]])
];