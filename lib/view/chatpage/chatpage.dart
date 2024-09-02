

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controler/auth_controller.dart';
import '../../controler/chat_controller.dart';
import '../../helper/Google_firebase_services.dart';
import '../../helper/chat_services.dart';
import '../../modal/chat_modal.dart';
import '../../themes/themes.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  Auth_Controller auth_controller = Get.put(Auth_Controller());
  ChatController controller = Get.put(ChatController());
  void _showMessageOptions(BuildContext context, String messageId, String currentMessage) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 50, 50), // Adjust position as needed
      items: [
        PopupMenuItem(
          value: 'edit',
          child: ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit'),
            onTap: () {
              Navigator.pop(context);
              _editMessage(messageId, currentMessage);
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

  void _editMessage(String messageId, String currentMessage,BuildContext context) {
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
              onPressed: () async {
                if (_editController.text.isNotEmpty) {
                  String senderID = auth_controller.getCurrentUser()!.email!;
                  List<String> ids = [widget.receiverEmail, senderID];
                  ids.sort();
                  String chatRoomID = ids.join('_');

                  await _chatService.updateMessage(chatRoomID, messageId, _editController.text);
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

  void _deleteMessage(String messageId) async {
    String senderID = _authService.getCurrentUser()!.email!;
    List<String> ids = [widget.receiverEmail, senderID];
    ids.sort();
    String chatRoomID = ids.join('_');

    await _chatService.deleteMessage(chatRoomID, messageId);
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              hintText: "Type a message",
              obscureText: false,
              controller: _messageController,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100.h,
        toolbarHeight: 60.h,
        elevation: 1,
        leading: Row(
          children: [
            const BackButton(),
            Obx(
                  () => CircleAvatar(
                radius: 25.r,
                backgroundImage: NetworkImage(
                  controller.receiverImageUrl.value,
                ),
              ),
            ),
          ],
        ),
        title: Obx(
              () => Text(
            controller.receiverEmail.value,
            overflow: TextOverflow.ellipsis,
            style:  TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp),
          ),
        ),
        actions:  [
          Padding(
            padding: EdgeInsets.only(left: 16.0.h, right: 8.h),
            child: Icon(Icons.add_call),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.h),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: ChatServices.chatServices.getchat(
                  GoogleFirebaseServices.googleFirebaseServices
                      .currentUser()!
                      .email??auth_controller.phone.value,
                  controller.receiverEmail.value),
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
                List<ChatModal> chatList =
                chats.map((e) => ChatModal(e)).toList();
                return ListView.builder(
                  itemCount: chatList.length,
                  itemBuilder: (context, index) => Padding(
                    padding:  EdgeInsets.all(8.0.h),
                    child: Align(
                        alignment: GoogleFirebaseServices.googleFirebaseServices
                            .currentUser()!
                            .email ==
                            chatList[index].sender
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Card(
                            child: Padding(
                          padding:  EdgeInsets.all(8.0.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(chatList[index].message!),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("${chatList[index].timestamp!.toDate().hour.toString()}:${chatList[index].timestamp!.toDate().second.toString()}",style: TextStyle(color: Colors.grey,fontSize: 12),),
                                ],
                              )
                            ],
                          ),
                        ))),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 8.0.h, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50.h,
                  width: 220.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(10.r),
                    border:Border(top: BorderSide(color:Theme.of(context).primaryColor ))
                    //Theme.of(context).primaryColor
                  ),
                  child: Obx(
                        () => TextField(
                      controller: controller.txtChats,
                      onChanged: (value) => controller.changeMessage(value),
                      decoration: InputDecoration(
                        hintText: 'Message',
                        hintStyle:  TextStyle(fontSize: 20.sp),
                        border: InputBorder.none,
                        prefixIcon: const Icon(Icons.emoji_emotions_outlined),
                        suffixIcon: controller.chatMessage.value.isEmpty
                            ?  Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.attach_file),
                            SizedBox(
                              width: 15.h,
                            ),
                            Icon(CupertinoIcons
                                .money_dollar_circle_fill),
                            SizedBox(
                              width: 15.h,
                            ),
                            Icon(Icons.photo_camera),
                            SizedBox(
                              width: 15.h,
                            ),
                          ],
                        )
                            :  Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.attach_file),
                            SizedBox(
                              width: 10.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60.h,
                  child: Padding(
                    padding:  EdgeInsets.only(bottom: 8.0.h, right: 4.h),
                    child: Obx(
                          () => FloatingActionButton(
                        shape: const CircleBorder(),
                        onPressed: () {
                          Map<String, dynamic> chat = {
                            'sender': GoogleFirebaseServices
                                .googleFirebaseServices
                                .currentUser()!
                                .email??auth_controller.phone.value,
                            'receiver': controller.receiverEmail.value,
                            'message': controller.txtChats.text,
                            'timestamp': DateTime.now()
                          };
                          ChatServices.chatServices.Insertchat(
                              chat,
                              GoogleFirebaseServices.googleFirebaseServices
                                  .currentUser()!
                                  .email??auth_controller.phone.value,
                              controller.receiverEmail.value);
                          controller.txtChats.clear();
                        },
                        child: controller.chatMessage.value.isEmpty
                            ? const Icon(Icons.mic)
                            : const Icon(Icons.send),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

}
