import 'package:aplicacion_petbia/ui/widgets/HomeWidget.dart';
import 'package:flutter/material.dart';

class comunidadWidget extends StatelessWidget {
  const comunidadWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Este es un post "),
          ElevatedButton(
              child: Row(
                children: [
                  Text('Entrar'),
                ],
              ),
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  primary: Colors.lightGreen,
                  onPrimary: Colors.black,
                  onSurface: Colors.black),
              onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeWidget()),
                    ),
                  })
        ],
      ),
    );
  }
}
