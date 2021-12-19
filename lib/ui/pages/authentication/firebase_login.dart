import 'package:aplicacion_petbia/domain/controller/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_signup.dart';

class FirebaseLogIn extends StatefulWidget {
  @override
  _FirebaseLogInState createState() => _FirebaseLogInState();
}

class _FirebaseLogInState extends State<FirebaseLogIn> {
  final _formKey = GlobalKey<FormState>();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  AuthenticationController authenticationController = Get.find();

  _login(theEmail, thePassword) async {
    print('_login $theEmail $thePassword');
    try {
      await authenticationController.login(theEmail, thePassword);
    } catch (err) {
      Get.snackbar(
        "Login",
        err.toString(),
        icon: Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/gatito.jpg'), fit: BoxFit.fitWidth)),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          nombre(),
          Form(
            key: _formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: this.controllerEmail,
                decoration: InputDecoration(labelText: "Correo electronico"),
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
              OutlinedButton(
                  onPressed: () async {
                    // this line dismiss the keyboard by taking away the focus of the TextFormField and giving it to an unused
                    FocusScope.of(context).requestFocus(FocusNode());
                    final form = _formKey.currentState;
                    form!.save();
                    if (_formKey.currentState!.validate()) {
                      await _login(
                          controllerEmail.text, controllerPassword.text);
                    }
                  },
                  child: Text("Enviar")),
            ]),
          ),
          TextButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  primary: Colors.green.shade400,
                  onPrimary: Colors.white,
                  onSurface: Colors.black),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FirebaseSignUp()));
              },
              child: Text("Crear cuenta"))
        ],
      ),
    );
  }
}
