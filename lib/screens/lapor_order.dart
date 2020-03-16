import 'package:flutter/material.dart';

class LaporOrder extends StatefulWidget {
  @override
  _LaporOrderState createState() => _LaporOrderState();

  final String id_order;
  LaporOrder({this.id_order});
}

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}

class _LaporOrderState extends State<LaporOrder> {
  String dropdownvalue = '';
  Item selectedUser;

  

  List<Item> users = <Item>[
    const Item(
        'Sakit',
        Icon(
          Icons.sentiment_very_dissatisfied,
          color: const Color.fromRGBO(21, 25, 101, 1),
        )),
    const Item(
        'Kendaraan Bermasalah',
        Icon(
          Icons.local_shipping,
          color: const Color.fromRGBO(21, 25, 101, 1),
        )),
    const Item(
        'Urusan Pribadi',
        Icon(
          Icons.directions_run,
          color: const Color.fromRGBO(21, 25, 101, 1),
        )),
    const Item(
        'Lainnya',
        Icon(
          Icons.warning,
          color: const Color.fromRGBO(21, 25, 101, 1),
        )),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(21, 25, 101, 1),
        title: Text(
          'Driver Jasa Harum',
          style: TextStyle(
            fontFamily: 'GoogleFont',
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Kategori Laporan : ",
                              style: TextStyle(
                                  fontFamily: 'GoogleFont', fontSize: 22),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 30,
                              child: DropdownButton<Item>(
                                isExpanded: true,
                                hint: Text(
                                  "Alasan Laporan",
                                ),
                                value: selectedUser,
                                onChanged: (Item Value) {
                                  setState(() {
                                    selectedUser = Value;
                                  });
                                  print(selectedUser.name);
                                },
                                items: users.map((Item user) {
                                  return DropdownMenuItem<Item>(
                                    value: user,
                                    child: Row(
                                      children: <Widget>[
                                        user.icon,
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          user.name,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Penjelasan Laporan : ",
                              style: TextStyle(
                                  fontFamily: 'GoogleFont', fontSize: 22),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 30,
                              child: TextField(
                                maxLength: 150,
                                maxLines: 5,
                                decoration: InputDecoration(
                                    hintText: "Alasan Tidak Bisa Mengambil"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 15),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(
                                width: MediaQuery.of(context).size.width - 30,
                                child: RaisedButton(
                                  color: Colors.red,
                                  onPressed: () {},
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(6)),
                                  child: Text(
                                    "Kirim Laporan",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'GoogleFont',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ),
                                )),
                                //BUAT MANGGIL PARSINGAN DATA
                                // widget.id_order
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
