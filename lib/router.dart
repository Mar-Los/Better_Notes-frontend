import 'package:cloud_note_app/folder_arguments.dart';
import 'package:cloud_note_app/pages/create_page.dart';
import 'package:cloud_note_app/pages/dictionary_file_page.dart';
import 'package:cloud_note_app/pages/folders_page.dart';
import 'package:cloud_note_app/pages/home_page.dart';
import 'package:cloud_note_app/pages/initial_loading.dart';
import 'package:cloud_note_app/pages/login_page.dart';
import 'package:cloud_note_app/pages/text_file_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => InitialLoading());

      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());

      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage());

      case '/folders':
        if (args is FolderArguments) {
          return MaterialPageRoute(
              builder: (_) => FoldersPage(
                    parentId: args.parentId,
                    parentName: args.parentName,
                  ));
        }
        return _errorRoute();

      case '/create':
        if (args is int) {
          return MaterialPageRoute(builder: (_) => CreatePage(parentId: args));
        }
        return _errorRoute();

      case '/profile':

      case '/text':
        if (args is Map) {
          return MaterialPageRoute(
              builder: (_) => TextFilePage(textFile: args));
        }
        return _errorRoute();

      case '/dictionary':
        if (args is Map) {
          return MaterialPageRoute(
              builder: (_) => DictionaryFilePage(dictFile: args));
        }
        return _errorRoute();

      default:
        throw 'Route ${settings.name} is not defined';
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('An Error in the routing occured'),
        ),
      );
    });
  }
}
