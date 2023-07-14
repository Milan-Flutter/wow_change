import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wow/Model/All_Data.dart';
import 'package:wow/constant.dart';

import '../../Api/All_Data.dart';
import '../story_profile.dart';

class ChatRoom extends StatefulWidget {
  final Map<String, dynamic> userMap;
  final String chatRoomId;

  ChatRoom({required this.chatRoomId, required this.userMap});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController _message = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  File? imageFile;
  AllData? data1;
  String? name;
  bool all = false;
  String? User_id;
  AllData? data;
  String? name_2;
  String? photo;

  @override
  void initState() {

    print("jhkjgewriwuea");

    print(widget.userMap['w_id'].toString());

    User_id = widget.userMap['w_id'].toString();
    profile();
    super.initState();
  }

  void profile1() {
    print("KAUSFfpAfA");
    print(User_id.toString());
    userData().data3(id: User_id.toString()).then((value) {
      data = value;
      setState(() {
        name_2 = data!.data![0].name.toString();
        photo = data!.data![0].photoUrl.toString();
        print("dkjhgdGLOs");
        all = true;
      });
    });
  }

  void profile() {
    userData().data().then((value) {
      data1 = value;
      setState(() {
        name = data1!.data![0].name.toString();
        profile1();
      });
    });
  }

  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": name.toString(),
        "message": _message.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };

      _message.clear();
      await _firestore
          .collection('chatroom')
          .doc(widget.chatRoomId)
          .collection('chats')
          .add(messages);
    } else {
      print("Enter Some Text");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: all
          ? SafeArea(
              child: Stack(
                children: [
                  Image.asset(
                    'assets/all.png', // replace with your image path
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 40, left: 16, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  height:
                                  MediaQuery.of(context).size.height * .06,
                                  width: MediaQuery.of(context).size.width * .13,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: s1.withOpacity(.5),
                                      border: Border.all(
                                          color: s1
                                      )
                                  ),
                                  child: Icon(
                                    Icons.arrow_back_ios_new_outlined,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .04,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .785,
                                height: MediaQuery.of(context).size.height * .06,
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                                decoration: BoxDecoration(
                                   gradient: LinearGradient(
                                     colors: [
                                       s2,
                                       main_color
                                     ],
                                     begin: Alignment.centerLeft,
                                     end: Alignment.centerRight
                                   ),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type:
                                                    PageTransitionType.rightToLeft,
                                                child: st_profile(
                                                  id: User_id,
                                                )));
                                      },
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius:
                                                20.0, // Adjust the radius according to your desired size
                                            backgroundImage:
                                                NetworkImage(photo.toString()),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          SizedBox(
                                            width:
                                                MediaQuery.of(context).size.width *
                                                    .4,
                                            child: Text(
                                              name_2.toString(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: font,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      child: Center(child: Image.asset("assets/img_35.png",height: 54,width: 54,)),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * .725,
                              width: size.width,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: _firestore
                                    .collection('chatroom')
                                    .doc(widget.chatRoomId)
                                    .collection('chats')
                                    .orderBy("time", descending: false)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.data != null) {
                                    return ListView.builder(
                                      reverse: true,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        int abc =
                                            snapshot.data!.docs.length - 1 - index;
                                        Map<String, dynamic> map =
                                            snapshot.data!.docs[abc].data()
                                                as Map<String, dynamic>;
                                        return messages(size, map, context);
                                      },
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ),
                            Container(
                              height: size.height / 10,
                              width: size.width,
                              alignment: Alignment.center,

                              child: Container(
                                height: size.height / 12,
                                width: size.width / 1.1,
                                
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: size.height / 17,
                                      width: size.width / 1.4,
                                     decoration: BoxDecoration(
                                       color: s2.withOpacity(.3),
                                       borderRadius: BorderRadius.circular(20)
                                     ),
                                      child: TextField(
                                        controller: _message,
                                        style: TextStyle(
                                          color: Colors.white
                                        ),
                                        decoration: InputDecoration(
                                            hintText: "Send Message",
                                            contentPadding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 15),
                                            hintStyle: TextStyle(
                                                fontSize: 16,
                                                color: font),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide:
                                                  BorderSide(color: s_color),
                                            ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                              color:
                                              s2, // Set the border color when the TextField is focused
                                            ),

                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                              color:
                                              s2, // Set the border color when the TextField is focused
                                            ),

                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                              color:
                                              s2, // Set the border color when the TextField is focused
                                            ),),
                                      ),
                                    ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        onSendMessage();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        height: MediaQuery.of(context).size.height *
                                            .06,
                                        width:
                                            MediaQuery.of(context).size.width * .13,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            border: Border.all(color: s2),
                                            color: s2.withOpacity(.3)),
                                        child: Icon(
                                          Icons.send,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(
              color: s2,
            )),
    );
  }

  Widget messages(Size size, Map<String, dynamic> map, BuildContext context) {
    return map['type'] == "text"
        ? Container(
            width: size.width,
            alignment: map['sendby'] == name.toString()
                ? Alignment.bottomRight
                : Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: map['sendby'] == name.toString()? BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                ):BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                ),
                color: map['sendby'] == name.toString() ? s2 : main_color,
              ),
              child: Text(
                map['message'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          )
        : Container(
            height: size.height / 2.5,
            width: size.width,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            alignment: map['sendby'] == _auth.currentUser!.displayName
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: InkWell(
              onTap: () {},
              child: Container(
                height: size.height / 2.5,
                width: size.width / 2,
                decoration: BoxDecoration(border: Border.all()),
                alignment: map['message'] != "" ? null : Alignment.center,
                child: map['message'] != ""
                    ? Image.network(
                        map['message'],
                        fit: BoxFit.cover,
                      )
                    : CircularProgressIndicator(),
              ),
            ),
          );
  }
}

//
