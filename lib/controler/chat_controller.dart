import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_chat/helper/chat_services.dart';

class ChatController extends GetxController{
  RxString chatMessage = ''.obs;
  ScrollController scrollController = ScrollController();
  TextEditingController txtChats = TextEditingController();
  void changeMessage(String value)
  {
    chatMessage.value = value;
  }

  RxInt bottomIndex=0.obs;

  void changeBottomIndex(int value)
  {
    bottomIndex.value=value;
  }

  RxString receiverEmail =''.obs;
  RxString receiverImageUrl =''.obs;
  RxString receivertoken =''.obs;

  void changeReceiverEmail(String email,String photoUrl,String token)
  {
    receiverEmail.value=email;
    receiverImageUrl.value =photoUrl;
    receivertoken.value = token;
  }

  void Delate({required String chatId,required String sender,
      required String receiver})
  {
    ChatServices.chatServices.deleteChat(chatId: chatId, sender: sender,receiver: receiver);
  }

  void edit({required String message, required String chatId,required String sender,
      required String receiver})
  {
    ChatServices.chatServices.updateChat(message, chatId, sender, receiver);
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {Future.delayed(Duration(milliseconds: 300), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

}