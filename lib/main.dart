import 'package:cloud_note_app/router.dart';
import 'package:cloud_note_app/utils/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserModel(),
      child: MaterialApp(
        title: 'My Notes',
        onGenerateRoute: RouteGenerator.generateRoute,
        theme: ThemeData(
            buttonTheme: ButtonThemeData(
          buttonColor: Theme.of(context).colorScheme.primary,
        )),
      ),
    );
  }
}
