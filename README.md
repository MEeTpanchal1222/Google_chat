<h1>Google Chat App</h1>
### Key Features:
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


<img src =""  alt="slash screen" width="200"/></p>



This architecture provides scalability, security, and real-time updates, making Firebase a powerful backend for chat applications in Flutter.





https://github.com/user-attachments/assets/cece3851-5c9e-4240-8fe3-591d79a72cbb

