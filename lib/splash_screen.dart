import 'dart:async';

import 'package:countdown/countdown.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'future_song_list.dart';
import 'login_page_cooler.dart';

class SplashScreen extends StatefulWidget {
  static String tag = '/';

  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  StreamSubscription sub;

  @override
  Widget build(BuildContext context) {
    // TODO: implement buildStatelessWidget
    return Scaffold(
      body: Center(
        child: Hero(
          tag: "logo",
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: CircleAvatar(
              radius: 72.0,
              backgroundColor: Colors.transparent,
              child: Image.asset('assets/flutter_logo_round.png'),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    checkLoginState();
  }

  void checkLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = (prefs.getBool('isLoggedIn') ?? false);

    CountDown cd = CountDown(Duration(seconds: 3));
    sub = cd.stream.listen(null);
    sub.onDone(() {
      if (isLoggedIn) {
        Navigator.of(context).pushNamed(AsyncCallFuture.tag);
      } else {
        Navigator.of(context).pushNamed(LoginPageCooler.tag);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    sub.cancel();
  }
}
