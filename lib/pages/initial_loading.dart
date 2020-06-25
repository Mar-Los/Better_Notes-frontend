import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class InitialLoading extends StatelessWidget {
//   final FlutterSecureStorage storage = FlutterSecureStorage();

//   Future<String> get jwtOrEmpty async {
//     String jwt = await storage.read(key: 'jwt');
//     if (jwt == null) return '';
//     return jwt;
//   }

//   Widget navigateToScreen(context, snapshot) {
//     if (!snapshot.hasData) return CircularProgressIndicator();
//     if (snapshot.data != '') {
//       String jwt = snapshot.data;
//       List jwtParts = jwt.split('.');

//       if (jwtParts.length != 3) {
//         Navigator.popAndPushNamed(context, '/login');
//       } else {
//         Navigator.popAndPushNamed(context, '/home', arguments: jwt);
//       }
//     } else {
//       Navigator.popAndPushNamed(context, '/login');
//     }
//     return CircularProgressIndicator();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: jwtOrEmpty,
//       builder: navigateToScreen,
//     );
//   }
// }

class InitialLoading extends StatelessWidget {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<String> jwtOrEmpty() async {
    String jwt = await storage.read(key: 'jwt');
    if (jwt == null) return '';
    return jwt;
  }

  @override
  Widget build(BuildContext context) {
    jwtOrEmpty().then((jwt) {
      if (jwt == null) Navigator.pushReplacementNamed(context, '/login');
      if (jwt != '') {
        List jwtParts = jwt.split('.');
        if (jwtParts.length != 3) {
          Navigator.pushReplacementNamed(context, '/login');
        } else {
          // Navigator.pushReplacementNamed(context, '/home');
          Navigator.pushReplacementNamed(context, '/login');
        }
      }
      if (jwt == '') {
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });

    return Container(
      child: CircularProgressIndicator(),
    );
  }
}
