import 'package:cloud_firestore/cloud_firestore.dart';

class Choice {
  final String pollId;
  final String content;
  final String imageUrl;
  final List<dynamic> votes;

  const Choice(
      {required this.pollId,
      required this.content,
      required this.imageUrl,
      required this.votes});

  Map<String, dynamic> toJson() => {
        "pollId": pollId,
        "content": content,
        "imageUrl": imageUrl,
        "votes": votes,
      };

  static Choice fromSnap(Map<String, dynamic> snap) {
    return Choice(
      content: snap['content'],
      pollId: snap['pollId'],
      imageUrl: snap['imageUrl'],
      votes: snap['votes'],
    );
  }
}

class Poll {
  final String uid;
  final String username;
  final String description;
  final String pollId;
  final DateTime datePublished;
  final List<Choice> choices;

  const Poll({
    required this.uid,
    required this.username,
    required this.description,
    required this.pollId,
    required this.datePublished,
    required this.choices,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "description": description,
        "pollId": pollId,
        "datePublished": datePublished,
        "choices": choices,
      };

  static Poll fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;

    return Poll(
      uid: snap['uid'],
      username: snap['username'],
      description: snap['description'],
      pollId: snap['pollId'],
      datePublished: snap['datePublished'].toDate(),
      choices: snap['choices'],
    );
  }
}
