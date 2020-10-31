import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:Login_test/template/dialog.dart';
import 'package:Login_test/template/Addprice.dart';
import 'package:Login_test/template/Home_page.dart';

class MyAdduserPage extends StatefulWidget {
  @override
  _MyAdduserPageState createState() => _MyAdduserPageState();
}

class _MyAdduserPageState extends State<MyAdduserPage> {
  @override
  initState() {
    super.initState();
  }

  final db = FirebaseDatabase.instance.reference();
  String _username, _password, _email, _tel, _room;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          backgroundColor: Colors.indigo[300],
          title:
              Text("PP phaplen Hotel", style: TextStyle(color: Colors.white)),
        ),
        drawer: showDrawer(),
        body: Container(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(5),
                  child: Center(
                      child: Column(mainAxisSize: MainAxisSize.min, children: <
                          Widget>[
                    new Image.asset(
                      'assets/profile.png',
                      height: 80.0,
                      width: 80.0,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text("เพิ่มผู้เช้าห้องพัก",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      constraints:
                          BoxConstraints.expand(height: 50, width: 350),
                      decoration: BoxDecoration(
                        color: Colors.indigo[300],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        border: Border.all(color: Colors.black, width: 3.0),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          constraints:
                              BoxConstraints.expand(height: 400, width: 350),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            border: Border.all(color: Colors.black, width: 3.0),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              buildTextFieldUsername(),
                              buildTextFieldPassword(),
                              buildTextFieldTel(),
                              buildTextFieldEmail(),
                              buildTextFieldRoom(),
                              buildButtonAdd(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]))),
            ),
          ),
        ));
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            homepage(),
            homeAddprice(),
            homeAddmember(),
            logOut(),
          ],
        ),
      );
  ListTile homepage() {
    return ListTile(
      leading: Icon(Icons.home_outlined),
      title: Text('หน้าหลัก'),
      onTap: () {
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => MyHomePage());
        Navigator.of(context).pushAndRemoveUntil(
            materialPageRoute, (Route<dynamic> route) => false);
      },
    );
  }

  ListTile homeAddprice() {
    return ListTile(
      leading: Icon(Icons.attach_money),
      title: Text('หน้าเพิ่มเค่าเช่ารายเดือน'),
      onTap: () {
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => MyAddprice());
        Navigator.of(context).pushAndRemoveUntil(
            materialPageRoute, (Route<dynamic> route) => false);
      },
    );
  }

  ListTile homeAddmember() {
    return ListTile(
      leading: Icon(Icons.attribution_rounded),
      title: Text('หน้าเพิ่มผู้เช่า'),
      onTap: () {
        MaterialPageRoute materialPageRoute = MaterialPageRoute(
            builder: (BuildContext context) => MyAdduserPage());
        Navigator.of(context).pushAndRemoveUntil(
            materialPageRoute, (Route<dynamic> route) => false);
      },
    );
  }

  ListTile logOut() {
    return ListTile(
      leading: Icon(Icons.logout),
      title: Text('Sign out'),
      onTap: () {
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => MyHomePage());
        Navigator.of(context).pushAndRemoveUntil(
            materialPageRoute, (Route<dynamic> route) => false);
      },
    );
  }

  Container buildTextFieldUsername() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 10),
        constraints: BoxConstraints.expand(height: 50, width: 300),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 3.0),
            color: Colors.yellow[50],
            borderRadius: BorderRadius.circular(10)),
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
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 10),
        constraints: BoxConstraints.expand(height: 50, width: 300),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 3.0),
            color: Colors.yellow[50],
            borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
            onChanged: (value) => _password = value.trim(),
            decoration: InputDecoration.collapsed(hintText: "Password"),
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

  Container buildTextFieldTel() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 10),
        constraints: BoxConstraints.expand(height: 50, width: 300),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 3.0),
            color: Colors.yellow[50],
            borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
            onChanged: (value) => _tel = value.trim(),
            decoration: InputDecoration.collapsed(hintText: "Tel :"),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter Tel :';
              }
              return null;
            },
            textAlign: TextAlign.center,
            autofocus: true,
            style: TextStyle(fontSize: 18)));
  }

  Container buildTextFieldEmail() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 10),
        constraints: BoxConstraints.expand(height: 50, width: 300),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 3.0),
            color: Colors.yellow[50],
            borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
            onChanged: (value) => _email = value.trim(),
            decoration: InputDecoration.collapsed(hintText: "Email  :"),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter Email :';
              }
              return null;
            },
            textAlign: TextAlign.center,
            autofocus: true,
            style: TextStyle(fontSize: 18)));
  }

  Container buildTextFieldRoom() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 10),
        constraints: BoxConstraints.expand(height: 50, width: 300),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 3.0),
            color: Colors.yellow[50],
            borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
            onChanged: (value) => _room = value.trim(),
            decoration: InputDecoration.collapsed(hintText: "Room :"),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter Room :';
              }
              return null;
            },
            textAlign: TextAlign.center,
            autofocus: true,
            style: TextStyle(fontSize: 18)));
  }

  Container buildButtonAdd() {
    return Container(
        constraints: BoxConstraints.expand(height: 60, width: 200),
        child: FlatButton(
            onPressed: () {
              // print('email = $_username, Password = $_password');

              addMember();
            },
            child: Text("เพิ่มผู้เช่า",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white))),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 3.0),
            borderRadius: BorderRadius.circular(16),
            color: Colors.green[200]),
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(12));
  }

  void addMember() {
    var rootTenant = db.child("Tenant");
    var room = db.child("Room");
    room.child(_room).once().then((DataSnapshot snapshot) {
      var checkRoom = '${snapshot.value}';

      if (checkRoom == 'null') {
        rootTenant.child(_username).set({
          'Username': _username,
          'Password': _password,
          'Tel': _tel,
          'Email': _email,
          'IDRoom': _room,
          'Status': 'Tenant',
        });

        room.child(_room).set({'owner': _username, 'IDRoom': _room});
        normalDialog(context, "ทำการบันทึกผู้เช่าเสร็จสิ้น");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyAdduserPage()));
      } else {
        normalDialog(context, "ห้องนี้มีผู้ใช้แล้วครับ");
      }
    });
  }
}
