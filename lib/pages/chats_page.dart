import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../settings.dart';

class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  ScrollController _scrollController = ScrollController();

  _scrollToBottom() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  List messages = [];
  Future<void> getMessages() async {
    final String response = await rootBundle.loadString('assets/chats.json');
    setState(() {
      messages = json.decode(response);
      _scrollToBottom();
    });
  }

  @override
  void initState() {
    getMessages();
    Timer(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: background,
      body: Container(
        padding: EdgeInsets.only(top: 80),
        child: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  alignment: Alignment.center,
                  width: size.width,
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20)),
                          child: SvgPicture.asset(
                            'assets/arrow-left.svg',
                            color: Colors.white,
                            width: 40,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Doctor Mohammed",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Online",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20)),
                        child: SvgPicture.asset(
                          'assets/calling-solid.svg',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )),

            ///Chats------------------------
            Positioned(
              bottom: 80,
              right: 0,
              left: 0,
              child: Container(
                padding: EdgeInsets.only(top: 20),
                height: size.height * 0.7,
                width: size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40))),
                child: ListView.builder(
                  controller: _scrollController,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Column(
                      crossAxisAlignment: messages[i]['from'] == '1'
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: size.width * 0.78,
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          padding: const EdgeInsets.only(
                              bottom: 10, left: 25, right: 25, top: 20),
                          decoration: BoxDecoration(
                            borderRadius: messages[i]['from'] == '1'
                                ? const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(5))
                                : const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(20)),
                            color: messages[i]['from'] == '1'
                                ? background
                                : Color(0xfff0f5ff),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                messages[i]['message'],
                                style: TextStyle(
                                    color: messages[i]['from'] == '1'
                                        ? Colors.white
                                        : Color(0xff495369),
                                    fontSize: 17),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    messages[i]['time'],
                                    style: TextStyle(
                                        color: messages[i]['from'] == '1'
                                            ? Colors.white.withOpacity(0.5)
                                            : Color(0xff495369)
                                                .withOpacity(0.5),
                                        fontSize: 11),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            /// Text Box---------------------
            Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  width: size.width,
                  height: 120,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xfff0f5ff),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: size.width * 0.7,
                        height: 70,
                        child: TextFormField(
                          style: const TextStyle(
                              color: Colors.black54, fontSize: 17),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            counterText: "",
                            border: InputBorder.none,
                            hintText: 'Write a message...',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 17),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Color(0xff2684d6),
                            borderRadius: BorderRadius.circular(15)),
                        child: SvgPicture.asset(
                          'assets/mic-solid.svg',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
