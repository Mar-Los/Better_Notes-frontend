# Better Notes - frontend
This is a frontend for a mobile app, its backend can be found in this [repository](https://github.com/Mar-Los/Better_Notes-backend). The goal of this app is to enable users to store their note files in specific folders of a folder system created by them and to give them an opportunity to access their files and folders from a different device.

## Description of the app
This app behaves like "better" notes. Users need to authenticate in order to use the app. Each file belongs to a folder of a folder tree. This tree is created by users themselves. This whole structure is stored in a database.

## Features
- A simple MVC architecture
- Routing of a folder tree
- All Data acquired from an API
- Opportunity to create, edit and delete folders and note files
- The whole app is connection sensitive

## Used technologies
- [Flutter](https://flutter.dev/)
- [Http](https://pub.dev/packages/http) - Flutter library for making HTTP requests
- [Provider](https://pub.dev/packages/provider) - Flutter package for managing the state of the app
- [Connectivity](https://pub.dev/packages/connectivity) - Flutter plugin for discovering the state of the network
- [Flutter Launcher Icons](https://pub.dev/packages/flutter_launcher_icons) - package which simplifies the task of updating launcher icons for Flutter apps.
