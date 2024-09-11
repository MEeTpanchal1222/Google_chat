
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_chat/controler/auth_controller.dart';
import 'package:google_chat/helper/Google_firebase_services.dart';
import '../controler/chat_controller.dart';

class ChatServices {
  static ChatServices chatServices =  ChatServices._();
  ChatServices._();
  Auth_Controller controller = Get.find();
  ChatController controller1 = Get.put(ChatController());
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

  void updateChat(String message, String chatId,String sender,
      String receiver) {
    // 1. chat id field
    // 2. docId access

    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join('_');
    FirebaseFirestore.instance
        .collection('chatroom')
        .doc(docId)
        .collection('chat')
        .doc(chatId)
        .update({
      'message': message,
    });
  }

  void deleteChat({required String chatId,required String sender,
      required String receiver}) {
    // 1. chat id field
    // 2. docId access

    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join('_');
    FirebaseFirestore.instance
        .collection('chatroom')
        .doc(docId)
        .collection('chat')
        .doc(chatId)
        .delete();
  }
}