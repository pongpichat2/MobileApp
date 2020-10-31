import 'package:Login_test/template/dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:Login_test/template/Home_page.dart';
import 'package:firebase_database/firebase_database.dart';

// class Login extends StatefulWidget {
//   @override
//   LoginPage createState() => new LoginPage();
// }

// class MyLoginPage extends StatefulWidget {
//   MyLoginPage({Key key}) : super(key: key);

//   @override
//   LoginPage createState() => LoginPage();
// }

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  final db = FirebaseDatabase.instance.reference();
  String _username, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[100],
        body: Container(
            child: Center(
          key: formkey,
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: EdgeInsets.only(top: 5),
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: new Image.asset(
                      'assets/building.png',
                      height: 140.0,
                      width: 140.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  buildTextFieldEmail(),
                  buildTextFieldPassword(),
                  buildButtonSignIn(),
                ],
              )),
        )));
  }

  Container buildTextFieldEmail() {
    return Container(
        padding: EdgeInsets.all(12),
        constraints: BoxConstraints.expand(height: 50, width: 300),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 3.0),
            color: Colors.yellow[50],
            borderRadius: BorderRadius.circular(16)),
        child: TextFormField(
            onChanged: (value) => _username = value.trim(),
            decoration: InputDecoration.collapsed(hintText: "Username"),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter username';
              }
              return null;
            },
            textAlign: TextAlign.center,
            autofocus: true,
            style: TextStyle(fontSize: 18)));
  }

  Container buildTextFieldPassword() {
    return Container(
        constraints: BoxConstraints.expand(height: 50, width: 300),
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 3.0),
            color: Colors.yellow[50],
            borderRadius: BorderRadius.circular(16)),
        child: TextFormField(
            onChanged: (value) => _password = value.trim(),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter password';
              }
              return null;
            },
            obscureText: true,
            decoration: InputDecoration.collapsed(hintText: "Password"),
            textAlign: TextAlign.center,
            autofocus: true,
            style: TextStyle(fontSize: 18)));
  }

  Container buildButtonSignIn() {
    return Container(
        constraints: BoxConstraints.expand(height: 50, width: 100),
        child: FlatButton(
            onPressed: () {
              // print('email = $_username, Password = $_password');

              signIn();
            },
            child: Text("Sign in",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white))),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.green[200]),
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(12));
  }

  void signIn() {
    // var username = _username;
    // var pass = _password;

    var rootAdmin = db.child("Member");

    rootAdmin.child(_username).once().then((DataSnapshot snapshot) {
      // print('Data : ${snapshot.value}');
      if ('${snapshot.value}' == 'null') {
        normalDialog(context, "ไม่พบผู้ใช้งาน โปรดทำรายการใหม่");
      } else {
        db
            .child('Member')
            .child(_username)
            .once()
            .then((DataSnapshot snapshot) {
          // print('Data : ${snapshot.value['Password']}');
          try {
            if (_password == '${snapshot.value['Password']}') {
              MaterialPageRoute materialPageRoute = MaterialPageRoute(
                  builder: (BuildContext context) => MyHomePage());
              Navigator.of(context).pushAndRemoveUntil(
                  materialPageRoute, (Route<dynamic> route) => false);
            } else {
              normalDialog(context, "รหัสผ่านไม่ถูกต้องครับ โปรดทำรายการใหม่");
            }
          } catch (e) {
            normalDialog(context, "ไม่พบผู้ใช้งาน โปรดทำรายการใหม่");
          }
        });
      }
    });
  }
}
