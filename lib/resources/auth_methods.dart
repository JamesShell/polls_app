import 'dart:typed_data';

import 'package:polls_app/resources/storage_methods.dart';

import '../models/user.dart' as model;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timeago/timeago.dart' as timeago;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }

  // Sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List? file,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty && password.isNotEmpty && username.isNotEmpty) {
        // Register user
        UserCredential ucred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        // Upload image if there is
        String photoUrl = "";
        if (file != null) {
          List<String> photos = await StorageMethods()
              .uploadImageToStorage('ProfilePics', [file], false);
          photoUrl = photos[0];
        }

        // Add user to DB
        model.User user = model.User(
          uid: ucred.user!.uid,
          email: email,
          username: username,
          profileUrl: photoUrl,
          bio: '',
          modifyAt: DateTime.now(),
          polls: [],
          followers: [],
          following: [],
        );

        await _firestore
            .collection('users')
            .doc(ucred.user!.uid)
            .set(user.toJson());

        res = "success";
      } else {
        res = "Please fill all the fields";
      }
    } on FirebaseAuthException catch (err) {
      AuthResultStatus authResultStatus = getFirebaseExepError(err.code);
      res = generateExceptionMessage(authResultStatus);
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Modifying User
  Future<String> editUser({
    required model.User user,
    required String username,
    required String bio,
  }) async {
    String res = "Some error occurred";

    try {
      if (username.replaceAll(" ", "").isNotEmpty) {
        bool usernameModified = username != user.username;
        bool bioModified = bio != user.bio;
        // Check if data is modified
        if (usernameModified || bioModified) {
          // Check if user can modify
          if (user.modifyAt!.isBefore(DateTime.now())) {
            await _firestore.collection('users').doc(user.uid).update({
              'modifyAt': DateTime.now().add(const Duration(days: 30)),
              'username': username,
              'bio': bio,
            });

            if (usernameModified) {
              for (var post in user.polls) {
                await _firestore.collection('posts').doc(post).update({
                  'username': username,
                });
              }
            }

            res = "success";
          } else {
            var defference = user.modifyAt!.difference(DateTime.now());
            res = "${defference.inDays.abs()} days left to update again";
          }
        } else {
          res = "Nothing changed!";
        }
      } else {
        res = "Please fill all the fields";
      }
    } on FirebaseAuthException catch (err) {
      AuthResultStatus authResultStatus = getFirebaseExepError(err.code);
      res = generateExceptionMessage(authResultStatus);
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Logging user
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occurred";

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential ucred = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please fill all the fields";
      }
    } on FirebaseAuthException catch (err) {
      AuthResultStatus authResultStatus = getFirebaseExepError(err.code);
      res = generateExceptionMessage(authResultStatus);
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Signing out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Error Handling
  AuthResultStatus getFirebaseExepError(String err) {
    AuthResultStatus result;
    switch (err.toUpperCase()) {
      case "INVALID-EMAIL":
        result = AuthResultStatus.invalidEmail;
        break;
      case "WRONG-PASSWORD":
        result = AuthResultStatus.wrongPassword;
        break;
      case "USER-NOT-FOUND":
        result = AuthResultStatus.userNotFound;
        break;
      case "USER-DISABLED":
        result = AuthResultStatus.userDisabled;
        break;
      case "TOO-MANY-REQUESTS":
        result = AuthResultStatus.tooManyRequests;
        break;
      case "OPERATION-NOT-ALLOWED":
        result = AuthResultStatus.operationNotAllowed;
        break;
      case "EMAIL-ALREADY-IN-USE":
        result = AuthResultStatus.emailAlreadyExists;
        break;
      default:
        result = AuthResultStatus.undefined;
    }
    return result;
  }

  String generateExceptionMessage(AuthResultStatus exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      case AuthResultStatus.invalidEmail:
        errorMessage = "Your email address appears to be malformed.";
        break;
      case AuthResultStatus.wrongPassword:
        errorMessage = "Your password is wrong.";
        break;
      case AuthResultStatus.userNotFound:
        errorMessage = "User with this email doesn't exist.";
        break;
      case AuthResultStatus.userDisabled:
        errorMessage = "User with this email has been disabled.";
        break;
      case AuthResultStatus.tooManyRequests:
        errorMessage = "Too many requests. Try again later.";
        break;
      case AuthResultStatus.operationNotAllowed:
        errorMessage = "Signing in with Email and Password is not enabled.";
        break;
      case AuthResultStatus.emailAlreadyExists:
        errorMessage =
            "The email has already been registered. Please login or reset your password.";
        break;
      default:
        errorMessage = "An undefined Error happened.";
    }

    return errorMessage;
  }
}

enum AuthResultStatus {
  successful,
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  undefined,
}
