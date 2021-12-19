import 'package:aplicacion_petbia/domain/controller/authentication_controller.dart';
import 'package:aplicacion_petbia/domain/controller/chat_controller.dart';
import 'package:aplicacion_petbia/ui/pages/addEstados.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  AuthenticationController authenticationController = Get.find();
  ChatController chatController = Get.find();

  Widget _textInput(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 3,
          child: Container(
            margin: const EdgeInsets.only(left: 5.0, top: 5.0),
          ),
        ),
        IconButton(
            icon: Icon(Icons.add_a_photo),
            iconSize: 40,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => addEstados()),
              );
            }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [_textInput(context)],
      ),
    );
  }
}
