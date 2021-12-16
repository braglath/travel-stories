import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_io_socket/flutter_io_socket.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:travel_diaries/app/data/theme/theme_service.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';

class FirstCharPage extends StatefulWidget {
  @override
  _FirstCharPage createState() => _FirstCharPage();
}

class _FirstCharPage extends State<FirstCharPage> {
  late Socket socket;
  late List<String> messages = <String>[];
  double height = 0, width = 0;
  late TextEditingController textController;
  late ScrollController scrollController;

  @override
  void initState() {
    //Initializing the message list
    //Initializing the TextEditingController and ScrollController
    textController = TextEditingController();
    scrollController = ScrollController();
    //Creating the socket
    socket =
        io('https://travelstoriesflutter.herokuapp.com/', <String, dynamic>{
      'transports': ['polling', 'websocket'],
      'pingTimeout': 180000,
      'pingInterval': 25000,
      'autoConnect': true
    });
    //Call init before doing anything with socket
    socket.connect();
    // connectAndListen();
    //Subscribe to an event to listen to
    socket.on('receive_message', (jsonData) {
      //Convert the JSON data received into a Map
      Map<String, dynamic> data = json.decode(jsonData);
      setState(() => messages.add(data['message']));
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 600),
        curve: Curves.ease,
      );
    });
    //Connect to the socket
    socket.connect();
    super.initState();
  }

  Widget buildSingleMessage(int index) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.only(bottom: 20.0, left: 20.0),
        decoration: BoxDecoration(
          color: ThemeService().theme == ThemeMode.light
              ? ColorResourcesLight.mainLIGHTColor
              : ColorResourcesDark.mainDARKColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          messages[index],
          style: TextStyle(color: Colors.white, fontSize: 15.0),
        ),
      ),
    );
  }

  Widget buildMessageList() {
    return Container(
      // height: height,
      child: ListView.builder(
        controller: scrollController,
        itemCount: messages.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return buildSingleMessage(index);
        },
      ),
    );
  }

  Widget buildChatInput() {
    return Container(
      width: width * 0.8,
      padding:
          const EdgeInsets.only(top: 5.0, bottom: 10.0, left: 1.0, right: 5),
      margin: const EdgeInsets.only(left: 15.0),
      child: TextFormField(
          style: TextStyle(color: ColorResourcesLight.mainTextHEADINGColor),
          cursorColor: ThemeService().theme == ThemeMode.light
              ? ColorResourcesLight.mainTextHEADINGColor
              : ColorResourcesDark.mainDARKTEXTICONcolor,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          maxLines: null,
          maxLength: null,
          expands: true,
          controller: textController,
          // autovalidate: true,
          validator: (val) {},
          decoration: InputDecoration(
            labelText: 'Send a message',
            labelStyle: Theme.of(context).textTheme.caption,
          )),
    );
  }

  Widget buildSendButton() {
    return FloatingActionButton(
      mini: true,
      backgroundColor: ThemeService().theme == ThemeMode.light
          ? ColorResourcesLight.mainLIGHTColor
          : ColorResourcesDark.mainDARKColor,
      onPressed: () {
        //Check if the textfield has text or not
        if (textController.text.isNotEmpty) {
          //Send the message as JSON data to send_message event
          socket.emit(
              'send_message', json.encode({'message': textController.text}));
          //Add the message to the list
          setState(() => messages.add(textController.text));
          textController.text = '';
          //Scrolldown the list to show the latest message
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 600),
            curve: Curves.ease,
          );
        }
      },
      child: FaIcon(
        FontAwesomeIcons.paperPlane,
        color: ColorResourcesLight.mainLIGHTAPPBARcolor,
        size: 20,
      ),
    );
  }

  Widget buildInputArea() {
    return Container(
      height: height * 0.1,
      width: width,
      child: Row(
        children: <Widget>[
          buildChatInput(),
          buildSendButton(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(height: 10),
              buildMessageList(),
              buildInputArea(),
            ],
          ),
        ),
      ),
    );
  }
}
