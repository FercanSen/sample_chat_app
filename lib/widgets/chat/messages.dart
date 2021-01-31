import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:sample_chat_app/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // When this future resolves it builds the listview
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
            stream: Firestore.instance
                .collection("chat")
                .orderBy(
                  "createTime",
                  descending: true,
                )
                .snapshots(),
            builder: (context, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final chatDocs = chatSnapshot.data.documents;
              return ListView.builder(
                reverse: true,
                // Reverses the order, in this case: messages will be shown bottom to the top
                itemCount: chatDocs.length,
                itemBuilder: (context, index) => MessageBubble(
                  chatDocs[index]["text"],
                  chatDocs[index]["username"],
                  chatDocs[index]["userImage"],
                  chatDocs[index]["userId"] == futureSnapshot.data.uid,
                ),
              );
            });
      },
    );
  }
}
