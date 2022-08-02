import 'dart:html';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import '../models/poll.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Upload post
  Future<String> uploadPost(
    String description,
    List<Choice> choices,
    String uid,
    String username,
    String face,
  ) async {
    String res = "some error occurred";
    try {
      if (description.replaceAll(" ", "").isNotEmpty) {
        String pollId = const Uuid().v1();
        Poll post = Poll(
            pollId: pollId,
            uid: uid,
            username: username,
            description: description,
            datePublished: DateTime.now(),
            choices: choices);

        await _firestore.collection('users').doc(uid).update({
          'posts': FieldValue.arrayUnion([pollId])
        }).whenComplete(() async {
          await _firestore.collection('posts').doc(pollId).set(post.toJson());
        });
        res = "success";
      } else {
        res = "Not valid post!";
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  // (Like || Dislike) a Post
  Future<void> voteForAPost(
      int choiceIndex, String postId, String uid, List<Choice> choices) async {
    try {
      if (choices[choiceIndex].votes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'choices.$choiceIndex.votes': FieldValue.arrayUnion([uid]),
        });
        return;
      }
      await _firestore.collection('posts').doc(postId).update({
        'choices.$choiceIndex.votes': FieldValue.arrayUnion([uid]),
      });
    } catch (e) {
      debugPrint("Can't vote due to this error: $e");
    }
  }

  // Delete post
  Future<void> deletePost(String postId, String uid) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'posts': FieldValue.arrayRemove([postId])
      }).whenComplete(() async {
        await _firestore.collection('posts').doc(postId).delete();
      });
    } catch (e) {
      debugPrint("Can't delete post due to this error: $e");
    }
  }
}
