import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String email;
  final String username;
  final String profileUrl;
  final String bio;
  final DateTime? modifyAt;
  final List polls;
  final List followers;
  final List following;

  const User({
    this.modifyAt,
    required this.uid,
    required this.email,
    required this.username,
    required this.profileUrl,
    required this.bio,
    required this.polls,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "username": username,
        "profileUrl": profileUrl,
        "bio": bio,
        "modifyAt": modifyAt,
        "polls": polls,
        "followers": followers,
        "following": following,
      };

  static User fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;

    return User(
        uid: snap['uid'],
        email: snap['email'],
        username: snap['username'],
        profileUrl: snap['profileUrl'],
        bio: snap['bio'],
        modifyAt: snap['modifyAt'].toDate(),
        polls: snap['polls'],
        followers: snap['followers'],
        following: snap['following']);
  }
}
