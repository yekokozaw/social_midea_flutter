import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final User? currentUser = FirebaseAuth.instance.currentUser;

  Future<DocumentSnapshot<Map<String,dynamic>>> getUserDetails() async{
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.grey[400],
      ),
      backgroundColor: Colors.grey[300],
      body: FutureBuilder<DocumentSnapshot<Map<String,dynamic>>>(
        future: getUserDetails(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const CircularProgressIndicator();
          }
          else if (snapshot.hasError){
            return Text('Error : ${snapshot.error}');
          }
          else if(snapshot.hasData){
            Map<String,dynamic>? user = snapshot.data!.data();
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Icon(Icons.person,size: 30,),
                  ),
                  const SizedBox(height: 20),
                  Text('${user?['first name']}' ' ${user?['last name']}',
                    style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.email,color: Colors.grey[600],),
                      SizedBox(width: 10),
                      Text('${user?['email']}'),
                    ],
                  )
                ],
              ),
            );
          }
          else{
            return Text("No data");
          }
        },
      ),
    );
  }
}
