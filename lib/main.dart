import 'package:flutter/material.dart';
import 'package:jasaharum/screens/wrapper.dart';
import 'package:jasaharum/services/auth.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
        title: "Jasa Harum",
      ),
    );
  }
}