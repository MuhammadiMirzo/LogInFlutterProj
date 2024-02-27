import 'package:flutter/material.dart';
import '../mixins/validation_mixin.dart';

class LoginScreen extends StatefulWidget {
  createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> with ValidatioMixin {
  final formKey = GlobalKey<FormState>();
  String? email = '';
  String? password = '';

  Widget build(context) {
    return Container(
      margin: const EdgeInsets.all(25.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            emailField(),
            Container(margin: EdgeInsets.only(top: 25.0)),
            passwordField(),
            Container(margin: EdgeInsets.only(top: 25.0)),
            submitButton(),
          ],
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
          labelText: "Email Adress", hintText: "mad@gmail.com"),
      validator: validateEmail,
      onSaved: (String? value) {
        email = value;
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(
        labelText: " Password",
        hintText: "Password",
      ),
      validator: validatePassword,
      onSaved: (String? value) {
        password = value;
      },
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Theme.of(context).colorScheme.primary.withOpacity(0.5);
            }
            return null; // Use the component's default.
          },
        ),
      ),
      onPressed: () {
        setState(() {});
        var b = formKey.currentState?.validate();
        if (b != null && b) {
          formKey.currentState?.save();
          print('Time to post $email and $password to my Api');
        }
      },
      child: const Text("Submit"),
    );
  }
}
