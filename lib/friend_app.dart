//Friends
class Friend {
  final String name;
  final String picture;
  final DateTime birthday;
  final List<String> tags;
  final String desc;

  Friend({
    required this.name,
    required this.picture,
    required this.birthday,
    required this.tags,
    required this.desc,
  });
}

List<Friend> friends = [
    Friend(
      name:"Alicja Przybylska",
      picture: "https://hips.hearstapps.com/hmg-prod/images/how-to-keep-ducks-call-ducks-1615457181.jpg?resize=2048:*",
      birthday: DateTime(2002, 11, 23),
      tags: ["rodzina", "przyjaciel"],
      desc: "Hi, my name is Alice. I love ducks! They're so adorable <3 I also like dogs, but ducks are definitely superior. In my free time I like to jog and read books becasue I'm boring. Jk, books are awesome, change my mind!"
      ),
    Friend(
      name:"Marcin Wiśniewski",
      picture: "https://hips.hearstapps.com/hmg-prod/images/how-to-keep-ducks-call-ducks-1615457181.jpg?resize=2048:*",
      birthday: DateTime(1989, 02, 12),
      tags: ["praca", "znajomy"],
      desc: "No description."
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