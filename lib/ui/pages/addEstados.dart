import 'package:aplicacion_petbia/ui/widgets/HomeWidget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:async_button_builder/async_button_builder.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';

import 'package:intl/intl.dart';

class addEstados extends StatefulWidget {
  const addEstados({Key? key}) : super(key: key);

  @override
  State<addEstados> createState() => _addEstadosState();
}

class _addEstadosState extends State<addEstados> {
  File? sampleImage;
  final formkey = GlobalKey<FormState>();
  String? url;

  get _myValue => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Añadir estado"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(32),
            child: Column(
              children: [
                sampleImage == null
                    ? FlutterLogo(
                        size: 400,
                      )
                    : enableUpload(),
                // : Image.file(
                //     sampleImage!,
                //     height: 300,
                //   ),
                const SizedBox(height: 24),
                AsyncButtonBuilder(
                  child: Text('Aceptar'),
                  loadingWidget: Text('Loading...'),
                  onPressed: () async {
                    await Future.delayed(Duration(seconds: 1));

                    // See the examples file for a way to handle timeouts
                    throw 'shucks';
                  },
                  builder: (context, child, callback, buttonState) {
                    final buttonColor = buttonState.when(
                      idle: () => Colors.green[200],
                      loading: () => Colors.grey,
                      success: () => Colors.orangeAccent,
                      error: () => Colors.orange,
                    );

                    return OutlinedButton(
                      child: child,
                      onPressed: getImage,
                      style: OutlinedButton.styleFrom(
                        primary: Colors.black,
                        backgroundColor: buttonColor,
                      ),
                    );
                  },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        AsyncButtonBuilder(
                          child: Text('Click Me'),
                          loadingWidget: Text('Loading...'),
                          onPressed: () async {
                            await Future.delayed(Duration(seconds: 1));

                            // See the examples file for a way to handle timeouts
                            throw 'shucks';
                          },
                          builder: (context, child, callback, buttonState) {
                            final buttonColor = buttonState.when(
                              idle: () => Colors.green[100],
                              loading: () => Colors.grey,
                              success: () => Colors.orangeAccent,
                              error: () => Colors.orange,
                            );

                            return OutlinedButton(
                              child: Icon(Icons.add_a_photo_outlined),
                              onPressed: getImage,
                              style: OutlinedButton.styleFrom(
                                primary: Colors.black,
                                backgroundColor: buttonColor,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Future getImage() async {
    final sampleImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (sampleImage == null) return;
    final imageTemporary = File(sampleImage.path);
    setState(() => this.sampleImage = imageTemporary);
  }

  Widget enableUpload() {
    return Container(
      child: Form(
        key: formkey,
        child: Column(
          children: <Widget>[
            sampleImage != null
                ? Image.file(
                    sampleImage!,
                    height: 200.0,
                    width: 200.0,
                  )
                : FlutterLogo(size: 160),
            SizedBox(
              height: 15.0,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Descripcion"),
              validator: (value) {
                return value!.isEmpty ? "Descripcion is required" : null;
              },
              onSaved: (value) {},
            ),
            SizedBox(height: 15.0),
            ElevatedButton(
                onPressed: uploadImage, child: Text("Añadir nuevo post"))
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = formkey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void uploadImage() async {
    if (validateAndSave()) {
      FirebaseStorage.instance
          .ref("desiredPathForImage/")
          .putFile(File(sampleImage!.path))
          .then((TaskSnapshot taskSnapshot) {
        if (taskSnapshot.state == TaskState.success) {
          print("Image uploaded Successful");
          // Get Image URL Now
          taskSnapshot.ref.getDownloadURL().then((imageURL) {
            print("Image Download URL is $imageURL");
          });
        } else if (taskSnapshot.state == TaskState.running) {
          // Show Prgress indicator
        } else if (taskSnapshot.state == TaskState.error) {
          // Handle Error Here
        }
      });
    }
    // Guardar el post en la bbdd
    saveToDatabase(url!);

    // Regresar a Home
    Navigator.pop(context);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return HomeWidget();
      // Guardar el post en la bbdd
    }));
  }

  void saveToDatabase(String url) {
    //   // Guardar un post (image, descripcion, date, time)
    var dbTimeKey = DateTime.now();
    var formatDate = DateFormat('MMM d, yyyy');
    var formatTime = DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);

    DatabaseReference ref = FirebaseDatabase.instance.reference();
    var data = {
      "image": url,
      "description": _myValue,
      "date": date,
      "time": time
    };

    ref.child("Posts").push().set(data);
  }
}
