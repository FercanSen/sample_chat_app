import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection("chat").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = snapshot.data.documents;
        return ListView.builder(
          reverse: true,
          // Reverses the order, in this case: messages will be shown bottom to the top
          itemCount: chatDocs.length,
          itemBuilder: (context, index) => Text(chatDocs[index]["text"]),
        );
      },
    );
  }
}
