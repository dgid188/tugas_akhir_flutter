import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UpdateTujuan extends StatefulWidget {
  @override
  _UpdateTujuanState createState() => _UpdateTujuanState();

  final String id_order;
  final String asal;
  UpdateTujuan({this.id_order, this.asal});
}

class _UpdateTujuanState extends State<UpdateTujuan> {
  var selectedtujuan, selectedType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(21, 25, 101, 1),
        title: Text(
          'Kirim ke Tempat Tujuan',
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
                              "Tujuan Pengiriman : ",
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
              padding: EdgeInsets.only(left: 15),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection("harga").where("asal", isEqualTo: widget.asal).snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      const Text("Loading.....");
                    else {
                      List<DropdownMenuItem> currencyItems = [];
                      for (int i = 0; i < snapshot.data.documents.length; i++) {
                        DocumentSnapshot snap = snapshot.data.documents[i];
                        currencyItems.add(
                          DropdownMenuItem(
                            child: Text(
                              snap.data["tujuan"],
                              style: TextStyle(
                                  fontFamily: 'GoogleFont', fontSize: 20, color: Colors.red),
                            ),
                            value: '${snap.documentID}',
                          ),
                        );
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 30,
                            child: DropdownButton(
                            items: currencyItems,
                            isExpanded: true,
                            onChanged: (currencyValue) {
                              // final snackBar = SnackBar(
                              //   content: Text(
                              //     'Tujuannya adalah $valuenya',
                              //     style: TextStyle(color: Color(0xff11b719)),
                              //   ),
                              // );
                              setState(() {
                                selectedtujuan = currencyValue;
                              });
                            },
                            value: selectedtujuan,
                            hint: new Text(
                              "Pilih Tujuan Pengiriman",
                              style: TextStyle(
                                  fontFamily: 'GoogleFont', fontSize: 20, color: Colors.red),
                            ),
                          ),
                          )
                        ],
                      );
                    }
                  }),
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
                              "Total Kubik Pengiriman : ",
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
                                decoration: InputDecoration(
                                    hintText: "Berapa M\u00B3",
                                    ),
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
                                  onPressed: () {
                                    print("object");
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(6)),
                                  child: Text(
                                    "Perbaharui Order",
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
