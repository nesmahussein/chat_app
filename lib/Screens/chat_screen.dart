import 'package:chatting_app/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;
late User signInUser;

class ChattingScreen extends StatefulWidget {

  @override
  _ChattingScreenState createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  final messageTextController=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  final _auth = FirebaseAuth.instance;

  String? messageText;

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constant.color2,
        title: Row(
          children: [
            Image.asset('images/logo.png', height: 27),
            SizedBox(width: 10),
            Text('Message Me'),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
               _auth.signOut();
                 Navigator.pop(context);
               // messageSnapshot();
              },
              icon: Icon(Icons.close)),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            messageStreamBulider(),

            Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                color: Constant.color2,
                width: 2,
              ))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: TextField(
                        controller: messageTextController,
                    onChanged: (value) {
                      messageText = value;
                    },
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      hintText: 'Enter your message here',
                      border: InputBorder.none,
                    ),
                  )),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
                      _firestore.collection('messages').add({
                        'senderEmail': signInUser.email,
                        'message': messageText,
                        'time':FieldValue.serverTimestamp(),
                      });
                    },
                    child: Text(
                      'send',
                      style: TextStyle(
                          color: Constant.color2,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
class messageStreamBulider extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').orderBy('time').snapshots(),
        builder: (context, snapShot) {
          List<MessageLine> messageWidgets = [];
          if (!snapShot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Constant.color2,
              ),
            );
          }
          final messages = snapShot.data!.docs.reversed;
          for (var message in messages) {
            final messageText = message.get('message');
            final messageEmail = message.get('senderEmail');
            final currentUser=signInUser.email;
            if(currentUser==messageEmail)
            {

            }
            final messageWidget = MessageLine(
                message: messageText, senderEmail: messageEmail, isMe: currentUser==messageEmail,);
            messageWidgets.add(messageWidget);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: const EdgeInsets.all(15),
              children: messageWidgets,
            ),
          );
        });
  }

}

class MessageLine extends StatelessWidget {
  const MessageLine({this.message, this.senderEmail, Key? key, required this.isMe})
      : super(key: key);
  final String? message;
  final String? senderEmail;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:isMe? CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [ Text('$senderEmail',style: TextStyle(fontSize: 10,color: Colors.blueGrey),) ,
      Material(
        borderRadius:isMe? BorderRadius.only(
          topLeft:Radius.circular(20) ,
          bottomLeft: Radius.circular(20) ,
          bottomRight: Radius.circular(20)
        ):BorderRadius.only(
            topRight:Radius.circular(20) ,
            bottomLeft: Radius.circular(20) ,
            bottomRight: Radius.circular(20)),
        elevation: 5,
          color: isMe?Colors.black45:Colors.redAccent,
            child: Padding(
              padding:const  EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              child: Text(
          '$message',
          style: TextStyle(fontSize: 15,color:Colors.white),
        ),
            )),
     ] ),
    );
  }
}
