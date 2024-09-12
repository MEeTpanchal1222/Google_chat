
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../helper/Ai_chat_services.dart';

class AIChatController extends GetxController {
  RxString chatMessage = ''.obs;
  TextEditingController txtAIChat = TextEditingController();
  ScrollController scrollController = ScrollController();

  void changeMessage(String value) {
    chatMessage.value = value;
  }

  RxList<String> chatIds = <String>[].obs;
  RxList<Map<String, dynamic>> aiChats = <Map<String, dynamic>>[].obs;

  void sendMessage(String sender) {
    Map<String, dynamic> chat = {
      'sender': sender,
      'receiver': "AI",
      'message': txtAIChat.text,
      'timestamp': DateTime.now(),
    };
    AiChatServices.chatServices.InsertAIChat(chat, sender);
    txtAIChat.clear();
    update();
  }

  void editAIChat({required String message, required String chatId, required String sender}) {
    AiChatServices.chatServices.updateAIChat(message, chatId, sender);
  }

  void deleteAIChat({required String chatId, required String sender}) {
    AiChatServices.chatServices.deleteAIChat(chatId: chatId, sender: sender);
  }

  void scrollToBottom() {
    Future.delayed(Duration(milliseconds: 300), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
