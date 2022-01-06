import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map? _userData;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue[200],
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                ElevatedButton(
                    child: Text('Log In'),
                    onPressed: () async {
                      final result = await FacebookAuth.i
                          .login(permissions: ["public_profile", "email"]);

                      if (result.status == LoginStatus.success) {
                        final userData = await FacebookAuth.i.getUserData(
                          fields: "email,name",
                        );

                        setState(() {
                          _userData = userData;
                        });
                      }
                    }),
                ElevatedButton(
                    onPressed: () async {
                      await FacebookAuth.i.logOut();
                      setState(() {
                        _userData = null;
                      });
                    },
                    child: Text('logout ')),
                if (_userData != null)
                  Text('user loged In with  ' + _userData!['name'])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
