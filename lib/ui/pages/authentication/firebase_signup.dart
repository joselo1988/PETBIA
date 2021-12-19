import 'package:aplicacion_petbia/domain/controller/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseSignUp extends StatefulWidget {
  @override
  _FirebaseSignUpState createState() => _FirebaseSignUpState();
}

class _FirebaseSignUpState extends State<FirebaseSignUp> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  AuthenticationController authenticationController = Get.find();

  _signup(theEmail, thePassword) async {
    try {
      await authenticationController.signUp(theEmail, thePassword);

      Get.snackbar(
        "Sign Up",
        'OK',
        icon: Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (err) {
      Get.snackbar(
        "Sign Up",
        err.toString(),
        icon: Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/gatito.jpg'),
                        fit: BoxFit.fitWidth)),
                padding: EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        nombre(),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: this.nameController,
                          decoration: InputDecoration(labelText: "Nickname"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Nickname";
                            }
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: this.controllerEmail,
                          decoration:
                              InputDecoration(labelText: "Email address"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter email";
                            } else if (!value.contains('@')) {
                              return "Enter valid email address";
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: this.controllerPassword,
                          decoration: InputDecoration(labelText: "Password"),
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter password";
                            } else if (value.length < 6) {
                              return "Password should have at least 6 characters";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                            onPressed: () {
                              final form = _formKey.currentState;
                              form!.save();
                              // this line dismiss the keyboard by taking away the focus of the TextFormField and giving it to an unused
                              FocusScope.of(context).requestFocus(FocusNode());
                              if (_formKey.currentState!.validate()) {
                                _signup(controllerEmail.text,
                                    controllerPassword.text);
                              }
                            },
                            child: Text("Enviar")),
                      ]),
                ))));
  }
}

Widget nombre() {
  return Text(
    'Registrarse',
    style: TextStyle(
        color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
  );
}
