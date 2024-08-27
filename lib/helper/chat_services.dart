
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServices {
  static ChatServices chatServices =  ChatServices._();
  ChatServices._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> Insertchat(Map<String,dynamic>chat, String sender ,String receiver)async {
    List doc  =[ sender, receiver];
    doc.sort();
    String docId = doc.join("_");
    await firestore.collection("chatroom").doc(docId).collection("chat").add(chat);
  }
  Stream<QuerySnapshot<Map<String,dynamic>>> getchat(String sender, String receiver){
    List doc  = [sender,receiver];
    doc.sort();
    String docId = doc.join("_");
    print("---------------------$docId---------------------");
    return firestore.
    collection("chatroom").doc(docId).collection("chat")
        .orderBy("timestamp",descending: false).snapshots();

  }
}