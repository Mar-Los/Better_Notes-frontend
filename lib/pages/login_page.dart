import 'package:cloud_note_app/helper_widgets/connection_sensitive.dart';
import 'package:cloud_note_app/utils/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_note_app/controllers/user_controller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum UserAction { login, register }

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final UserController userController = UserController();
  final FlutterSecureStorage storage = FlutterSecureStorage();

  UserAction action = UserAction.login;

  void displayDialog(BuildContext context, String title, String text) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(text),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final String actionText =
        '${describeEnum(action)[0].toUpperCase()}${describeEnum(action).substring(1)}';

    return ConnectionSensitive(
      child: Scaffold(
        appBar: AppBar(
          title: Text(actionText),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    width: double.infinity,
                    height: 40.0,
                    child: RaisedButton(
                      child: Text(actionText,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          )),
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: () async {
                        String email = _emailController.text;
                        String password = _passwordController.text;

                        if (action == UserAction.login) {
                          String jwt =
                              await userController.login(email, password);
                          if (jwt != null) {
                            Map user = await userController.getUser(jwt);

                            Provider.of<UserModel>(context, listen: false)
                                .initialize(user['id'], jwt, user['email']);

                            Navigator.pushReplacementNamed(context, '/home');
                          } else {
                            displayDialog(context, 'An error occurred',
                                'No acount was found matching these credentials');
                          }
                        } else if (action == UserAction.register) {
                          Map newUser =
                              await userController.register(email, password);
                          String jwt =
                              await userController.login(email, password);
                          Provider.of<UserModel>(context, listen: false)
                              .initialize(newUser['id'], jwt, newUser['email']);
                          Navigator.pushReplacementNamed(context, '/home');
                          displayDialog(context, 'Registered successfully',
                              'Create new folders and files with the plus button below');
                        }
                      },
                    ),
                  ),
                ],
              ),
              Positioned.fill(
                bottom: 10.0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text((action == UserAction.login)
                          ? "Don't have an acount? "
                          : "Already have an acount? "),
                      InkWell(
                        child: Text(
                          (action == UserAction.login)
                              ? '${describeEnum(UserAction.register)[0].toUpperCase()}${describeEnum(UserAction.register).substring(1)}'
                              : '${describeEnum(UserAction.login)[0].toUpperCase()}${describeEnum(UserAction.login).substring(1)}',
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                        onTap: () => setState(() {
                          action = (action == UserAction.login)
                              ? UserAction.register
                              : UserAction.login;
                        }),
                      )
                    ],
                  ),
                  // child: Center(child: Text('ahoj')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
