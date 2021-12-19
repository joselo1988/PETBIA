import 'package:aplicacion_petbia/domain/controller/authentication_controller.dart';
import 'package:aplicacion_petbia/domain/controller/ui.dart';
import 'package:aplicacion_petbia/ui/widgets/HomeWidget.dart';
import 'package:aplicacion_petbia/ui/widgets/appbar.dart';
import 'package:aplicacion_petbia/ui/widgets/comunidadWidget.dart';
import 'package:aplicacion_petbia/ui/widgets/myPostWidget.dart';
import 'package:aplicacion_petbia/ui/widgets/ubicacionWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/chat_page.dart';

class ContentPage extends StatefulWidget {
  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  int _selectIndex = 0;
  final UIController controller = Get.find<UIController>();
  AuthenticationController authenticationController = Get.find();
  static List<Widget> _widgets = <Widget>[
    HomeWidget(),
    myPostWidget(),
    comunidadWidget(),
    ubicacionWidget(),
    ChatPage(),
  ];

  int? get selectIndex => null;

  _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  _logout() async {
    try {
      await authenticationController.logOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final UIController controller = Get.find<UIController>();
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        controller: controller,
        picUrl: 'https://uifaces.co/our-content/donated/gPZwCbdS.jpg',
        tile: const Text("Bienvenido a PETBIA"),
        onSignOff: () {
          _logout();
        },
      ),
      body: _widgets.elementAt(selectIndex!),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_outlined),
            label: 'Mis estados',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Social',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.place_outlined,
            ),
            label: 'Ubicacion',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.chat_rounded), label: "Chat")
        ],
        currentIndex: _selectIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
