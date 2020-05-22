// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/ui/common/enter_exit_route.dart';
import 'package:wr_app/ui/root_view.dart';
import 'package:wr_app/ui/signin_page.dart';

class OnBoardModal extends StatefulWidget {
  @override
  _OnBoardModalState createState() => _OnBoardModalState();
}

class _OnBoardModalState extends State<OnBoardModal> {
  String _email;
  String _password;

  @override
  initState() {
    super.initState();
    _email = '';
    _password = '';
  }

  Future<void> _signUpEmailAndPassword() async {
    final userStore = Provider.of<UserStore>(context, listen: false);
    print('email: $_email password: $_password');
    try {
      await userStore
          .signInWithMock(email: 'a@b.com', password: 'hoge')
          .catchError(print);
      userStore.setFirstLaunch(flag: false);
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RootView(),
        ),
      );
    } on Exception catch (e) {
      print(e);
      return;
    }
  }

  Future<void> _signUpWithGoogle() async {
    final userStore = Provider.of<UserStore>(context, listen: false);
    try {
      await userStore.signUpWithGoogle();

      userStore.setFirstLaunch(flag: false);

      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RootView(),
        ),
      );
    } on Exception catch (e) {
      print(e);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final logo = Image.asset(
      'assets/icon/wr_icon.jpg',
      fit: BoxFit.contain,
    );

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
//            Container(
//              decoration: BoxDecoration(
//                image: DecorationImage(
//                  image: const NetworkImage(
//                    'https://tk.ismcdn.jp/mwimgs/c/9/1140/img_c9630b9589b0bdf06ca0cc10a8de3ebf5387846.jpg',
//                  ),
//                  fit: BoxFit.cover,
//                  colorFilter: ColorFilter.mode(
//                      Colors.black.withOpacity(0.2), BlendMode.dstATop),
//                ),
//              ),
//            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: logo,
                    ),
                    // Form
                    Column(
                      children: <Widget>[
                        TextField(
                          onChanged: (text) {
                            setState(() {
                              _email = text;
                            });
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',
                          ),
                        ),
                        TextField(
                          onChanged: (text) {
                            setState(() {
                              _password = text;
                            });
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: FlatButton(
                              onPressed: _signUpEmailAndPassword,
                              child: const Padding(
                                padding: EdgeInsets.all(12),
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
//                        fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              color: Colors.blueAccent,
                              shape: const StadiumBorder(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: FlatButton(
                              onPressed: _signUpWithGoogle,
                              child: const Padding(
                                padding: EdgeInsets.all(12),
                                child: Text(
                                  'Sign up with Google',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
//                        fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              color: Colors.redAccent,
                              shape: const StadiumBorder(),
                            ),
                          ),
                          InkWell(
                            child: const Text('Sign in'),
                            onTap: () {
                              Navigator.of(context).push(EnterExitRoute(
                                exitPage: widget,
                                enterPage: SignInPage(),
                              ));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
