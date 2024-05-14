import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        backgroundColor: Colors.grey[400],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {

          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: Text('Loading..'));
          }

          if(snapshot.data == null){
            return const Text('No Data');
          }
          //show loading circle
          final users = snapshot.data!.docs;

          if (users.isEmpty) {
            return const Center(child: Text('No Users Found'));
          }

          return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index){
                final  user = users[index];
                return ListTile(
                  title: Text('${user['first name']}',style: TextStyle(color: Colors.black),),
                  subtitle: Text(user['email']),
                  trailing: Text(user['age'].toString()),
                );
              }
          );
        },
      )
    );
  }
}
