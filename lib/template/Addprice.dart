import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:Login_test/template/dialog.dart';
import 'package:Login_test/template/AddUser.dart';
import 'package:Login_test/template/Home_page.dart';

class MyAddprice extends StatefulWidget {
  @override
  _MyAddpriceState createState() => _MyAddpriceState();
}

class _MyAddpriceState extends State<MyAddprice> {
  @override
  initState() {
    super.initState();
    checkRoom();
  }

  final db = FirebaseDatabase.instance.reference();

  var selectedType;
  List<String> _bloodType = <String>[
    'มกราคม',
    'กุมภาพันธ์',
    'มีนาคม',
    'เมษายน',
    'พฤษภาคม',
    'มิถุนายน',
    'กรกฎาคม',
    'สิงหาคม',
    'กันยายน',
    'ตุลาคม',
    'พฤศจิกายน',
    'ธันวาคม'
  ];

  // Completer<List<Year>> completer = new Completer<List<Year>>();

  // var idroom_;
  var idroomNo, month;
  List<String> _showIdroom = <String>[
    'เลือก',
  ];

  var _priceroom, _electric, _water, _other;

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
                      'assets/money-bag.png',
                      height: 80.0,
                      width: 80.0,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text("เพิ่มค่าเช่ารายเดือน",
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
                              BoxConstraints.expand(height: 450, width: 350),
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
                              buildTextFieldRoom(),
                              buildTextFieldPriceRoom(),
                              buildTextFieldMonth(),
                              buildTextFieldElectric(),
                              buildTextFieldWater(),
                              buildTextFieldOther(),
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

  Container buildTextFieldRoom() {
    return Container(
        child: DropdownButton(
      items: _showIdroom.map((value) {
        var dropdownMenuItemRoom = DropdownMenuItem(
          child: Text(
            value,
          ),
          value: value,
        );
        return dropdownMenuItemRoom;
      }).toList(),
      onChanged: (selectBloodType) {
        setState(() {
          idroomNo = selectBloodType;
        });
      },
      value: idroomNo,
      hint: Text('เลขห้อง', style: TextStyle(fontSize: 20)),
    ));
  }

  Container buildTextFieldPriceRoom() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 10),
        constraints: BoxConstraints.expand(height: 50, width: 300),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 3.0),
            color: Colors.yellow[50],
            borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
            keyboardType: TextInputType.number,
            onChanged: (value) => _priceroom = value.trim(),
            decoration: InputDecoration.collapsed(hintText: "ค่าห้อง"),
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

  Container buildTextFieldMonth() {
    return Container(
        child: DropdownButton(
      items: _bloodType.map((value) {
        var dropdownMenuItem = DropdownMenuItem(
          child: Text(
            value,
          ),
          value: value,
        );
        return dropdownMenuItem;
      }).toList(),
      onChanged: (selectMonth) {
        setState(() {
          month = selectMonth;
        });
      },
      value: month,
      hint: Text('เดือน', style: TextStyle(fontSize: 20)),
    ));
  }

  Container buildTextFieldElectric() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 10),
        constraints: BoxConstraints.expand(height: 50, width: 300),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 3.0),
            color: Colors.yellow[50],
            borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
            keyboardType: TextInputType.number,
            onChanged: (value) => _electric = value.trim(),
            decoration: InputDecoration.collapsed(hintText: "ค่าไฟฟ้า / หน่วย"),
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

  Container buildTextFieldWater() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 10),
        constraints: BoxConstraints.expand(height: 50, width: 300),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 3.0),
            color: Colors.yellow[50],
            borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
            keyboardType: TextInputType.number,
            onChanged: (value) => _water = value.trim(),
            decoration: InputDecoration.collapsed(hintText: "ค่าน้ำ  / หน่วย"),
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

  Container buildTextFieldOther() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 10),
        constraints: BoxConstraints.expand(height: 50, width: 300),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 3.0),
            color: Colors.yellow[50],
            borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
            keyboardType: TextInputType.number,
            onChanged: (value) => _other = value.trim(),
            decoration: InputDecoration.collapsed(hintText: "ค่าอื่น ๆ :"),
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
              idroom();
            },
            child: Text("บันทึกค่าหอ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white))),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 3.0),
            borderRadius: BorderRadius.circular(16),
            color: Colors.green[200]),
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(12));
  }

  void idroom() {
    var rootPrice = db.child("PriceRoom");
    var rootowner = db.child("Room");
    var priceroom = int.parse(_priceroom);
    var priceEletric = int.parse(_electric);
    var pricewater = int.parse(_water);
    var priceOther = int.parse(_other);
    rootowner.child(idroomNo).once().then((DataSnapshot snapshot) {
      var _nameOwner = snapshot.value['owner'];

      rootPrice.child(idroomNo).set({
        'owner': _nameOwner,
        'PeiceRoom': priceroom,
        'Month': month,
        'PriceEletric': priceEletric * 7,
        'PriceWater': pricewater * 10,
        'PriceOther': priceOther,
        'IDRoom': idroomNo,
        'Status': 'ค้างจ่าย',
        'Total':
            (priceroom + priceOther) + (priceEletric * 7) + (pricewater * 10)
      });
      normalDialog(
          context,
          "ทำการบันทึกค่าเช่าของห้อง :" +
              idroomNo +
              " เดือน : " +
              month +
              " เรียบร้อยแล้ว");
      // MaterialPageRoute materialPageRoute =
      //     MaterialPageRoute(builder: (BuildContext context) => MyAddprice());
      // Navigator.of(context).pushAndRemoveUntil(
      //     materialPageRoute, (Route<dynamic> route) => false);
    });
  }

  void checkRoom() {
    var idroom = db.child("Room");
    idroom.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      // print(values);
      values.forEach((k, v) {
        String no_room = k.toString();

        _showIdroom.add(no_room);
      });
    });
  }
}
