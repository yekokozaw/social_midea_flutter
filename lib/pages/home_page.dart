import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_midea_flutter/components/my_drawer.dart';
import 'package:social_midea_flutter/components/my_post_button.dart';
import 'package:social_midea_flutter/database/firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final FirestoreDatabase database = FirestoreDatabase();
  final TextEditingController newPostController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;

  void PostMessage(){
    if(newPostController.text.isNotEmpty){
      String message = newPostController.text;
      database.addPost(message);
    }
    newPostController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: TextField(
                      controller: newPostController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Say Something..'
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                PostButton(
                  onTap: PostMessage,
                )
              ],
            )
          ),
          //Posts
          StreamBuilder(
              stream: database.getPostsStream(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final posts = snapshot.data!.docs;
                if(snapshot.data == null || posts.isEmpty){
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(25),
                      child: Text('No posts.. Post something!'),
                    ),
                  );
                }

                return Expanded(
                    child: ListView.builder(
                  itemCount: posts.length,
                    itemBuilder: (context, index) {
                      //get each individual post
                      final post = posts[index];

                      String message = post['PostMessage'];
                      String userEmail = post['UserEmail'];
                      Timestamp timestamp = post['TimeStamp'];

                      return Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: ListTile(
                          title: Text(message),
                          subtitle: Text(userEmail,style: TextStyle(color: Colors.grey[400]),),
                          trailing: Icon(Icons.date_range),
                        ),
                      );
                    },)
                );
              },
          )
        ],
      ),
    );
  }
}
