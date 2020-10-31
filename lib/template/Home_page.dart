import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:Login_test/template/AddUser.dart';
import 'package:Login_test/template/Addprice.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  initState() {
    super.initState();
    _getData01();
  }

  List<DataRow> modelsShowData = [];
  final db = FirebaseDatabase.instance.reference();
  var showtable;
  List<String> idrooms1 = [], month1 = [], total1 = [], status1 = [];
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
                      'assets/debts.png',
                      height: 100.0,
                      width: 100.0,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text("รายชื่อผู้ที่ค้างค่าเช่า",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      constraints:
                          BoxConstraints.expand(height: 50, width: 350),
                      decoration: BoxDecoration(
                        color: Colors.yellow[300],
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
                              BoxConstraints.expand(height: 400, width: 400),
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
                              DataTable(columns: const <DataColumn>[
                                DataColumn(
                                  label: Text(
                                    'ห้อง',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'เดือน',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'ยอด',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'สถานะ',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ], rows: modelsShowData),
                              // // buildTextFieldUsername(),
                              // // buildTextFieldPassword(),
                              // // buildTextFieldTel(),
                              // // buildTextFieldEmail(),
                              // // buildTextFieldRoom(),
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

  void _getData01() {
    // List idr = [], months = [], totals = [], statuss = [];
    db.child('PriceRoom').once().then((DataSnapshot snapshot) {
      // print(snapshot.value);
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((k, v) {
        db.child('PriceRoom').child(k).once().then((DataSnapshot snapshotRoom) {
          Map<dynamic, dynamic> valuesRoom = snapshotRoom.value;
          print(valuesRoom);

          var _idr = valuesRoom['IDRoom'].toString(),
              month = valuesRoom['Month'].toString(),
              total = valuesRoom['Total'].toString(),
              status = valuesRoom['Status'].toString();

          modelsShowData.add(
            DataRow(
              cells: [
                DataCell(
                  Text(_idr),
                ),
                DataCell(
                  Text(month),
                ),
                DataCell(
                  Text(total),
                ),
                DataCell(
                  Text(status),
                ),
              ],
            ),
          );
        });
        return modelsShowData;
      });
    });
  }
}
