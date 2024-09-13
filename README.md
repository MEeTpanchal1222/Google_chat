<h1>Google Chat App</h1>


1. **User Authentication**: 
   - Users can sign up and log in using Firebase Authentication.
   - You can implement multiple login methods (email/password, Google, Facebook, or Apple sign-in).
   
2. **Real-Time Messaging**:
   - Messages are stored and synced using **Cloud Firestore**, which allows real-time updates across devices.
   - Users can send text messages, images, and even files.
   
3. **One-on-One and Group Chats**:
   - Chats can be either one-on-one between two users or in groups with multiple participants.
   
4. **Cloud Storage**:
   - Firebase Cloud Storage is used to store media files (such as images and videos) that are shared in the chat.
   
5. **Push Notifications**:
   - Using **Firebase Cloud Messaging (FCM)**, users receive real-time push notifications when they get new messages, even when the app is closed.
   
6. **User Presence**:
   - Firebase allows tracking of online status, showing whether a user is online, typing, or last seen.

7. **Chat History & Persistence**:
   - The chat history is saved in Firestore, allowing users to see previous messages when they open the app.

8. **Message Read Status**:
   - You can implement message delivery and read status to show whether messages have been delivered or read by the recipient.

### App Structure:

1. **Firebase Authentication Integration**: 
   - Users authenticate using Firebase’s built-in authentication methods.
   - Once logged in, users are directed to the main chat interface.

2. **Firestore as the Database**:
   - Firestore stores the chat messages. Each chat room can be a document containing an array of messages (or individual messages can be stored as separate documents for scalability).
   - Each user has a user profile in Firestore that can store their display name, profile picture URL, and last seen status.

3. **Chat UI with Flutter**:
   - The user interface is created using Flutter widgets, including `ListView` to display messages, `TextField` for input, and message bubbles to distinguish between sent and received messages.

4. **Firebase Cloud Messaging (FCM)**:
   - FCM is used to send push notifications when a new message is received, even if the app is in the background.

### Sample Flow:

1. **User Registration/Login**:
   - Users register or log in using Firebase Authentication.
   
2. **Chat Room**:
   - After authentication, users enter a chat room where they can see a list of active chats or create a new chat.

3. **Sending Messages**:
   - Users type and send messages, which are uploaded to Firestore.
   - Messages can be text, emojis, or media files (stored in Firebase Cloud Storage).

4. **Receiving Messages**:
   - Other users in the chat room see messages in real-time thanks to Firestore’s real-time syncing.
   
5. **Notifications**:
   - If a message is received when the app is closed, Firebase Cloud Messaging sends a push notification.

### Code Snippets:

1. **Firebase Authentication**:
   ```dart
   FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
   ```

2. **Sending a Message to Firestore**:
   ```dart
   FirebaseFirestore.instance.collection('chats').add({
     'text': message,
     'senderId': FirebaseAuth.instance.currentUser.uid,
     'timestamp': FieldValue.serverTimestamp(),
   });
   ```

3. **Receiving Messages in Real-Time**:
   ```dart
   FirebaseFirestore.instance.collection('chats').orderBy('timestamp').snapshots().listen((snapshot) {
     setState(() {
       messages = snapshot.docs.map((doc) => doc.data()).toList();
     });
   });
   ```

### Firebase Services Used:
- **Firebase Authentication**: For user login and registration.
- **Cloud Firestore**: For storing chat data and user profiles.
- **Firebase Cloud Storage**: For storing media files shared in chat.
- **Firebase Cloud Messaging (FCM)**: For push notifications.

 ### Light Theme
<row>
  
<img src ="https://github.com/user-attachments/assets/a383a93c-7746-4a45-9e54-8adfa1a1c365"  alt="slash screen" width="200"/>
<img src ="https://github.com/user-attachments/assets/4d36a9e6-93f7-404a-a57c-b2f7f57c6b11" alt="slashscreen" width="200"/>
<img src ="https://github.com/user-attachments/assets/1877d2f8-78d3-42bc-ac97-961abe6fd32c"  alt="slash screen" width="200"/>
<img src ="https://github.com/user-attachments/assets/edef6890-2664-45a9-b466-c62b1fa66319"  alt="slash screen" width="200"/>
<img src ="https://github.com/user-attachments/assets/6c0a7fa0-8600-4661-bf73-adf0022e2a26"  alt="slash screen" width="200"/>
<img src ="https://github.com/user-attachments/assets/b536e591-9607-4b67-9671-16d6b2604a9a"  alt="slash screen" width="200"/>
<img src ="https://github.com/user-attachments/assets/8a8de408-1a4c-4fd2-bcd9-f99f159b88c8"  alt="slash screen" width="200"/>
<img src ="https://github.com/user-attachments/assets/8ab2e0a3-29c0-4895-92ee-e9734d4d3f46"  alt="slash screen" width="200"/>
<img src ="https://github.com/user-attachments/assets/228512b0-6b0c-4b56-9e62-b51010046355"  alt="slash screen" width="200"/>
<img src ="https://github.com/user-attachments/assets/0603770c-0ca8-4821-b895-67f4c28c5811"  alt="slash screen" width="200"/>
<img src ="https://github.com/user-attachments/assets/d53523b1-b7db-4e01-ba63-f069a90c7bc4"  alt="slash screen" width="200"/>
<img src ="https://github.com/user-attachments/assets/16b0985b-2573-47a7-b25e-e195e855d64b"  alt="slash screen" width="200"/>
</row>

### Dark Theme

<row>
<img src ="https://github.com/user-attachments/assets/d7e22a14-9954-4e6b-b5d7-17066748779b"  alt="slash screen" width="200"/>
<img src ="https://github.com/user-attachments/assets/bc8e9c02-2fc6-454c-9657-bc0fdfefaeee"  alt="slash screen" width="200"/>
<img src ="https://github.com/user-attachments/assets/09e6de0f-739c-4d9d-871e-0407a514a088"  alt="slash screen" width="200"/>
<img src ="https://github.com/user-attachments/assets/4aac9591-3245-4bbc-bce3-b25374ec6d51"  alt="slash screen" width="200"/>
<img src ="https://github.com/user-attachments/assets/d396ba50-0620-418c-8bd6-d3fe733bc486"  alt="slash screen" width="200"/>
<img src ="https://github.com/user-attachments/assets/939ac31a-f40a-4317-8847-f35317aa83a9"  alt="slash screen" width="200"/>
<img src ="https://github.com/user-attachments/assets/5dddab13-976e-4e9a-bd5a-590a67f822df"  alt="slash screen" width="200"/>
<img src ="https://github.com/user-attachments/assets/7a07e7d3-450f-4bb0-8b29-4b8a774e4b52"  alt="slash screen" width="200"/>
<img src ="https://github.com/user-attachments/assets/dd2be908-7e66-441f-845b-eea49bef1fd6"  alt="slash screen" width="200"/>
<img src ="https://github.com/user-attachments/assets/1ea338ec-51d4-4efe-8825-d651af101389"  alt="slash screen" width="200"/>
   
</row>
</p>




This architecture provides scalability, security, and real-time updates, making Firebase a powerful backend for chat applications in Flutter.





https://github.com/user-attachments/assets/cece3851-5c9e-4240-8fe3-591d79a72cbb

