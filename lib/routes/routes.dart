import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:myapp/presentation/homepage.dart';
import 'package:myapp/presentation/chat_page.dart';
import 'package:myapp/presentation/new_message.dart';
import 'package:myapp/presentation/exists_chat.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static Handler _mainHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          HelPet()); // this one is for one paramter passing...

  // lets create for two parameters tooo...
  static Handler _mainHandler2 = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          ChatPage());
  static Handler _newMessageHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          NewMessage());
  static Handler _existChatHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          ExistsChat());

  // ok its all set now .....
  // now lets have a handler for passing parameter tooo....

  static void setupRouter() {
    router.define(
      '/',
      handler: _mainHandler,
    );
    router.define(
      '/chat',
      handler: _mainHandler2,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/newmessage',
      handler: _newMessageHandler,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/existschat',
      handler: _existChatHandler,
    );
  }
}
