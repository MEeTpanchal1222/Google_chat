import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:google_chat/controler/auth_controller.dart';

class AiChatServices {
  final gemini = Gemini.instance;
  static AiChatServices chatServices = AiChatServices._();
  AiChatServices._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Insert chat message between AI and user
  Future<void> InsertAIChat(Map<String, dynamic> chat, String sender) async {
    String aiReceiver = "AI"; // Static identifier for AI
    String docId = "${sender}_$aiReceiver";

    await firestore.collection("ai_chatroom")
        .doc(docId)
        .collection("chat")
        .add(chat);

    String? aiResponse = await getAIResponse(chat['message']);

    // Send AI response
    Map<String, dynamic> aiChat = {
      'sender': "AI",
      'receiver': sender,
      'message': aiResponse,
      'timestamp': DateTime.now(),
    };

    await firestore.collection("ai_chatroom")
        .doc(docId)
        .collection("chat")
        .add(aiChat);
  }

  // Stream of AI chat messages
  Stream<QuerySnapshot<Map<String, dynamic>>> getAIChat(String sender) {
    String aiReceiver = "AI";
    String docId = "${sender}_$aiReceiver";
    return firestore
        .collection("ai_chatroom")
        .doc(docId)
        .collection("chat")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  void updateAIChat(String message, String chatId, String sender) {
    String aiReceiver = "AI";
    String docId = "${sender}_$aiReceiver";
    firestore
        .collection('ai_chatroom')
        .doc(docId)
        .collection('chat')
        .doc(chatId)
        .update({'message': message});
  }

  void deleteAIChat({required String chatId, required String sender}) {
    String aiReceiver = "AI";
    String docId = "${sender}_$aiReceiver";
    firestore
        .collection('ai_chatroom')
        .doc(docId)
        .collection('chat')
        .doc(chatId)
        .delete();
  }


  Future<String?> getAIResponse(String userMessage) async {
    try {
      final gemini = Gemini.instance; // Use your API key
      final response = await gemini.text(userMessage);
      return response!.output!;
    }catch (error) {
      return "Error: Unable to generate response.";
    }

  }

}
