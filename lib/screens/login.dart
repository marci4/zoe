import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    String? validateEmail(String? value) {
      const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
          r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
          r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
          r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
          r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
          r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
          r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
      final regex = RegExp(pattern);

      return value!.isEmpty || !regex.hasMatch(value)
          ? 'Bitte gebe eine gültige Email Adresse ein'
          : null;
    }

    String? validatePassword(String? value) {
      if (value != null && value.trim().isEmpty) {
        return 'Passwort wird benötigt';
      }
      return null;
    }

    return Scaffold(
        body: Container(
            height: 400,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(15),
              color: Colors.black.withOpacity(0.1),
            ),
            child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Center(
                          child: Text("Login to My Renault",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold))),
                      const Spacer(),
                      const Text("Email Adresse"),
                      const Spacer(),
                      Container(
                        height: 35,
                        decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide())),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.text,
                          validator: validateEmail,
                          style: const TextStyle(),
                          decoration: const InputDecoration(
                              hintText: "My Renault Email Adresse",
                              suffixIcon: Icon(
                                Icons.mail,
                              )),
                        ),
                      ),
                      const Spacer(),
                      const Text("Passwort"),
                      const Spacer(),
                      Container(
                          height: 35,
                          decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide())),
                          child: TextFormField(
                            obscureText: !_passwordVisible,
                            enableSuggestions: false,
                            autocorrect: false,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: validatePassword,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                              hintText: "My Renault Passwort",
                            ),
                          )),
                      const Spacer(),
                      Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: Text("Log In"),
                      )
                    ]))));
  }
}
