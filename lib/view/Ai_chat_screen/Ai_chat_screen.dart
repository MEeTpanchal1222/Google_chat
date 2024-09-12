import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_chat/controler/auth_controller.dart';
import 'package:google_chat/helper/Ai_chat_services.dart';
import 'package:google_chat/helper/chat_services.dart';
import '../../controler/Ai_ChatController.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AiChatScreen extends StatelessWidget {
  AiChatScreen({Key? key}) : super(key: key);

  final Auth_Controller authController = Get.put(Auth_Controller());
  final AIChatController aiChatController = Get.put(AIChatController());

  void _showMessageOptions(BuildContext context, {required String messageId, required String currentMessage}) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 50, 50),
      items: [
        PopupMenuItem(
          value: 'edit',
          child: ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit'),
            onTap: () {
              Navigator.pop(context);
              _editMessage(currentMessage: currentMessage, messageId: messageId, context: context);
            },
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete'),
            onTap: () {
              Navigator.pop(context);
              _deleteMessage(messageId);
            },
          ),
        ),
      ],
    );
  }

  void _editMessage({required String messageId, required String currentMessage, required BuildContext context}) {
    TextEditingController _editController = TextEditingController(text: currentMessage);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Message'),
          content: TextField(
            controller: _editController,
            decoration: const InputDecoration(hintText: 'Enter new message'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_editController.text.isNotEmpty) {
                  String senderID = authController.getCurrentUser()!.email!;
                  aiChatController.editAIChat(
                    chatId: messageId,
                    message: _editController.text,
                    sender: senderID,
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteMessage(String messageId) {
    String senderID = authController.getCurrentUser()!.email!;
    aiChatController.deleteAIChat(chatId: messageId, sender: senderID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          const Text('Gemini'),
          Hero(
            tag: 'Gemini',
              transitionOnUserGestures: bool.fromEnvironment(AutofillHints.email),
              child: Image.asset("assets/icons/google-gemini-icon.png",height: 30.h,width: 20.h,)),
        ],),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: AiChatServices.chatServices.getAIChat(authController.getCurrentUser()!.email!),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                var queryData = snapshot.data!.docs;
                List chats = queryData.map((e) => e.data()).toList();
                List chatsId = queryData.map((e) => e.id).toList();

                return ListView.builder(
                  controller: aiChatController.scrollController,
                  itemCount: chats.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: chats[index]['sender'] == authController.getCurrentUser()!.email
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: GestureDetector(
                        onLongPress: () {
                          if (chats[index]['sender'] == authController.getCurrentUser()!.email) {
                            _showMessageOptions(context,
                                messageId: chatsId[index],
                                currentMessage: chats[index]['message']);
                          }
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(chats[index]['message']),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${(chats[index]['timestamp']).toDate().hour}:${(chats[index]['timestamp']).toDate().minute}",
                                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: aiChatController.txtAIChat,
                    onChanged: (value) => aiChatController.changeMessage(value),
                    decoration: const InputDecoration(
                      hintText: 'Message',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    aiChatController.sendMessage(authController.getCurrentUser()!.email!);
                    aiChatController.scrollToBottom();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
