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
  void _showMessageOptions(BuildContext context,
      {required String messageId, required String currentMessage}) {
    showMenu(
      context: context,
      position:
          RelativeRect.fromLTRB(100, 100, 50, 50), // Adjust position as needed
      items: [
        PopupMenuItem(
          value: 'edit',
          child: ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit'),
            onTap: () {
              Navigator.pop(context);
              _editMessage(
                  currentMessage: currentMessage,
                  messageId: messageId,
                  context: context);
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

  void _editMessage(
      {required String messageId,
      required String currentMessage,
      required BuildContext context}) {
    TextEditingController _editController =
        TextEditingController(text: currentMessage);
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
                  controller.edit(
                      chatId: messageId,
                      message: _editController.text,
                      receiver: controller.receiverEmail.value,
                      sender: senderID);
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
    String senderID = auth_controller.getCurrentUser()!.email!;
    String recvierId = controller.receiverEmail.value;
    controller.Delate(sender: senderID, chatId: messageId, receiver: recvierId);
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
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp),
          ),
        ),
        actions: [
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
                          .email ??
                      auth_controller.phone.value,
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
                List chatsId = queryData.map((e) => e.id).toList();
                List<ChatModal> chatList =
                    chats.map((e) => ChatModal(e)).toList();
                return ListView.builder(
                  itemCount: chatList.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.all(8.0.h),
                    child: Align(
                        alignment: GoogleFirebaseServices.googleFirebaseServices
                                    .currentUser()!
                                    .email ==
                                chatList[index].sender
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: GestureDetector(
                          onLongPress: () {
                            if (chatList[index].sender ==
                                GoogleFirebaseServices.googleFirebaseServices
                                    .currentUser()!
                                    .email) {
                              _showMessageOptions(context,
                                  messageId: chatsId[index],
                                  currentMessage: chatList[index].message!);
                            }
                          },
                          child: Card(
                              child: Padding(
                            padding: EdgeInsets.all(8.0.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(chatList[index].message!),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${chatList[index].timestamp!.toDate().hour.toString()}:${chatList[index].timestamp!.toDate().second.toString()}",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )),
                        )),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.h, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 45.h,
                  width: 240.h,
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10.r),
                      ),
                  child: Obx(
                    () => TextField(
                      controller: controller.txtChats,
                      onChanged: (value) => controller.changeMessage(value),
                      decoration: InputDecoration(
                        hintText: 'Message',
                        hintStyle: TextStyle(fontSize: 20.sp),
                        border: InputBorder.none,
                        prefixIcon:  Icon(Icons.emoji_emotions_outlined),
                        suffixIcon: controller.chatMessage.value.isEmpty
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.attach_file),
                                  SizedBox(
                                    width: 15.h,
                                  ),
                                  Icon(CupertinoIcons.money_dollar_circle_fill),
                                  SizedBox(
                                    width: 15.h,
                                  ),
                                  Icon(Icons.photo_camera),
                                  SizedBox(
                                    width: 15.h,
                                  ),
                                ],
                              )
                            : Row(
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
                    padding: EdgeInsets.only(bottom: 8.0.h, right: 4.h),
                    child: Obx(
                      () => FloatingActionButton(
                        shape:  CircleBorder(),
                        onPressed: () {
                          Map<String, dynamic> chat = {
                            'sender': GoogleFirebaseServices
                                    .googleFirebaseServices
                                    .currentUser()!
                                    .email ??
                                auth_controller.phone.value,
                            'receiver': controller.receiverEmail.value,
                            'message': controller.txtChats.text,
                            'timestamp': DateTime.now()
                          };
                          ChatServices.chatServices.Insertchat(
                              chat,
                              GoogleFirebaseServices.googleFirebaseServices
                                      .currentUser()!
                                      .email ??
                                  auth_controller.phone.value,
                              controller.receiverEmail.value);
                          controller.txtChats.clear();
                        },
                        child: controller.chatMessage.value.isEmpty
                            ?  Icon(Icons.mic,color: Theme.of(context).colorScheme.primary,)
                            :  Icon(Icons.send,color: Theme.of(context).colorScheme.primary,),
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
