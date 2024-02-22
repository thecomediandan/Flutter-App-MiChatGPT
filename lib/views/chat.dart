//import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_chatgpt/infrastructure/helpers/api_keys.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class Chat extends StatefulWidget {


  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKeyGemini);

  List<String> chat = [];

  final TextEditingController controllerText = TextEditingController();

  final FocusNode focusText = FocusNode();

  final ScrollController listController = ScrollController();
  //late String responseChat;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              if(index < 0) return null;
              //listController.animateTo(listController.position.maxScrollExtent, duration: const Duration(seconds: 1), curve: Curves.bounceOut);
              return (index % 2 == 0) ? ChatUser(chat[index]) : ChatBot(chat[index]);
            },
            itemCount: chat.length,
            controller: listController,
            addAutomaticKeepAlives: true,
            dragStartBehavior: DragStartBehavior.down,
          )),
          TextFormField(
      onTapOutside: (event) {
        focusText.unfocus();
      },
      focusNode: focusText,
      controller: controllerText,
      onFieldSubmitted: (value) async {
        // Cuando se presiona enter
        focusText.unfocus();
        //FocusScope.of(context).requestFocus(focusText2);
        setState(() {
          chat.add(value);
        });
        chat.add(await responseGemini(controllerText.text)
        .then((value) {
          setState(() {
            listController.animateTo(listController.position.maxScrollExtent, duration: const Duration(seconds: 1), curve: Curves.bounceOut);
          });
          return value;
          })
        .onError((error, stackTrace) => error.toString()));
        print(value);
        controllerText.clear();
      },
      decoration: InputDecoration(
        //icon: const Icon(Icons.send_and_archive_outlined),
        hintText: 'Escribe una consulta...',
        suffix: IconButton(onPressed: () async{
          focusText.unfocus();
          //FocusScope.of(context).requestFocus(focusText2);
          setState(() {
            chat.add(controllerText.text);
          });
        chat.add(await responseGemini(controllerText.text)
        .then((value) {
          setState(() {
            listController.animateTo(listController.position.maxScrollExtent, duration: const Duration(seconds: 1), curve: Curves.bounceOut);
          });
          return value;
          })
        .onError((error, stackTrace) => error.toString()));
          print(controllerText.text);
          controllerText.clear();
        }, icon: const Icon(Icons.send_outlined)),
        prefix: const CircleAvatar(
          backgroundColor: Colors.deepPurple,               
          ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0), borderSide: const BorderSide(color: Colors.greenAccent)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0), borderSide: const BorderSide(color: Colors.blueAccent)),
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5)
      ),
    
    )
        ],
      ),
    );
  }

  Future<String> responseGemini(String requestGemini) async{
    final content = [Content.text(requestGemini)];
    final response = await model.generateContent(content);
    return response.text?? '';
  }
}

class InputChat extends StatelessWidget {
  const InputChat({
    super.key,
    required this.focusText,
    required this.controllerText,
  });

  final FocusNode focusText;
  final TextEditingController controllerText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) {
        focusText.unfocus();
      },
      focusNode: focusText,
      controller: controllerText,
      onFieldSubmitted: (value) {
        // Cuando se presiona enter
        focusText.unfocus();
        //FocusScope.of(context).requestFocus(focusText2);
        print(value);
      },
      decoration: InputDecoration(
        //icon: const Icon(Icons.send_and_archive_outlined),
        hintText: 'Escribe una consulta...',
        suffix: IconButton(onPressed: () {
          focusText.unfocus();
          //FocusScope.of(context).requestFocus(focusText2);
          
          print(controllerText.text);
          controllerText.clear();
        }, icon: const Icon(Icons.send_outlined)),
        prefix: const CircleAvatar(
          backgroundColor: Colors.deepPurple,               
          ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0), borderSide: const BorderSide(color: Colors.greenAccent)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0), borderSide: const BorderSide(color: Colors.blueAccent)),
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5)
      ),
    
    );
  }
}

class ChatUser extends StatelessWidget {
  final String chatOf;

  const ChatUser(String chat, {
    super.key,
  }): chatOf = chat;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 15, 15, 7.5),
      padding: const EdgeInsets.all(5),
      //color: Colors.amber,
      decoration: const BoxDecoration(
        //color: Colors.cyanAccent,
        border: Border(
          top: BorderSide(color: Colors.black),
          left: BorderSide(color: Colors.black),
          right: BorderSide(color: Colors.black),
          bottom: BorderSide(color: Colors.black),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      child: Text(chatOf),
    );
  }
}

class ChatBot extends StatelessWidget {
  final String chatOf;

  const ChatBot(String chat, {
    super.key,
  }): chatOf = chat;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 30, 7.5),
      padding: const EdgeInsets.all(5),
      //color: Colors.amber,
      decoration: const BoxDecoration(
        //color: Colors.cyanAccent,
        border: Border(
          top: BorderSide(color: Colors.black),
          left: BorderSide(color: Colors.black),
          right: BorderSide(color: Colors.black),
          bottom: BorderSide(color: Colors.black),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Text(chatOf),
    );
  }
}