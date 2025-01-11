import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? _email = null;
  String? _password = null;

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

    isButtonEnabled() {
      return _email != null &&
          _password != null &&
          formKey.currentState != null &&
          formKey.currentState!.validate();
    }

    Function()? onPressed() {
      if (formKey.currentState!.validate()) {
        return () {
          formKey.currentState!.save();
        };
      }
      return () {};
    }

    ;

    return Scaffold(
        body: Container(
            height: 400,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(15),
              color: Colors.black.withOpacity(0.1),
            ),
            child: Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          Center(
                              child: Text("Login to My Renault",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold))),
                          const Spacer(),
                          const Spacer(),
                          const Text("Email Adresse"),
                          const Spacer(),
                          SizedBox(
                            height: 75,
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) =>
                                  setState(() => _email = value),
                              validator: validateEmail,
                              key: const Key("email"),
                              style: const TextStyle(),
                              decoration: const InputDecoration(
                                  hintText: "My Renault Email Adresse",
                                  counterText: ' ',
                                  suffixIcon: Icon(
                                    Icons.mail,
                                  )),
                            ),
                          ),
                          const Spacer(),
                          const Text("Passwort"),
                          const Spacer(),
                          SizedBox(
                              height: 75,
                              child: TextFormField(
                                obscureText: !_passwordVisible,
                                enableSuggestions: false,
                                onChanged: (value) =>
                                    setState(() => _password = value),
                                autocorrect: false,
                                key: const Key("password"),
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
                          SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: FilledButton(
                                onPressed: isButtonEnabled() ? onPressed : null,
                                statesController: WidgetStatesController(),
                                child: const Text("Log In")),
                          )
                        ])))));
  }
}
