 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase{
    User? user = FirebaseAuth.instance.currentUser;

    final CollectionReference posts =
        FirebaseFirestore.instance.collection('Posts');

    Future<void> addPost(String message){
      return posts.add({
        'UserEmail' : user!.email,
        'PostMessage' : message ,
        'TimeStamp' : Timestamp.now()
      });
    }

    Stream<QuerySnapshot> getPostsStream() {
      final postStream = FirebaseFirestore.instance
          .collection('Posts')
          .orderBy('TimeStamp',descending: true)
          .snapshots();

      return postStream;
    }
 }