import 'package:flutter/material.dart';

class OrderBesok extends StatefulWidget {
  @override
  _OrderBesokState createState() => _OrderBesokState();
}

class _OrderBesokState extends State<OrderBesok> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                            "Barang : ",
                            style: TextStyle(
                                fontFamily: 'GoogleFont', fontSize: 22),
                          ),
                          Text(
                            "n/A",
                            style: TextStyle(
                              fontFamily: 'GoogleFont',
                              fontSize: 22,
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
            padding: EdgeInsets.only(left: 15, top: 5),
            child: Column(
              children: <Widget>[
                Container(
                    child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Asal : ",
                          style:
                              TextStyle(fontFamily: 'GoogleFont', fontSize: 30),
                        ),
                        Text(
                          "n/A",
                          style: TextStyle(
                              fontFamily: 'GoogleFont',
                              fontSize: 30,
                              fontWeight: FontWeight.w800),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Asal :    ",
                          style: TextStyle(
                              fontFamily: 'GoogleFont',
                              fontSize: 25,
                              color: Color.fromRGBO(255, 255, 255, 0)),
                        ),
                        Text(
                          "n/A",
                          style: TextStyle(
                              fontFamily: 'GoogleFont',
                              fontSize: 22,
                              fontWeight: FontWeight.w800),
                        )
                      ],
                    ),
                  ],
                )),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, top: 5),
            child: Column(
              children: <Widget>[
                Container(
                    child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Batas Ambil : ",
                          style:
                              TextStyle(fontFamily: 'GoogleFont', fontSize: 22),
                        ),
                        Text(
                          "n/A",
                          style: TextStyle(
                              fontFamily: 'GoogleFont',
                              fontSize: 22,
                              fontWeight: FontWeight.w800),
                        )
                      ],
                    ),
                  ],
                )),
              ],
            ),
          ),
          
          Padding(
            padding: EdgeInsets.only(left: 15, top: 30, right: 15),
            child: Column(
              children: <Widget>[
                Text(
                  "Tidak Bisa Mengambil? Lapor ke Operator",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'OpenSansRegular'),
                )
                ,
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(6)),
                    onPressed: () async {},
                    child: Text(
                      "Lapor Operator",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'GoogleFont',
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}