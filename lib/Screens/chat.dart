import 'package:chat_app/Widget/chat_messages.dart';
import 'package:chat_app/Widget/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  void setupPushNotifications()async{
    final fcm= FirebaseMessaging.instance;
 await fcm.requestPermission();
  final token= await fcm.getToken();
  print(token);
  
  fcm.subscribeToTopic('chat-message');
  }


  @override
  void initState() {
    setupPushNotifications();
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterChat'),
        actions: [
          ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              showDialog(
                context: context,
                builder: (ctx) {
                  return AlertDialog(
                    title: const Text('SignOut'),
                    content: const Text('Are you sure you want to SignOut?'),
                    actions: [
                      TextButton(
                        child: const Text('Yes'),
                        onPressed: Navigator.of(ctx).pop,

                      ),
                    ],
                  );
                },
              );

            },
            child: Text("Signout"),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: ChatMessages()),
          NewMessage(),
        ],
      ),
    );
  }
}