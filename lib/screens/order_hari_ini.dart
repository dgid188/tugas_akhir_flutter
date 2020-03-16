import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jasaharum/screens/lapor_order.dart';
import 'package:jasaharum/screens/update_kirim.dart';
import 'package:map_launcher/map_launcher.dart';

class OrderHariIni extends StatefulWidget {
  @override
  _OrderHariIniState createState() => _OrderHariIniState();
}

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}

class _OrderHariIniState extends State<OrderHariIni> {
  var lat;
  var lng;
  String IDData;
  String status;
  String status_muatan;
  String barang;
  String alamatgudang;
  String gudang;
  String status_pengiriman;
  String uid;
  String error;
  String kotaasal;
  final databaseReference = Firestore.instance;
  var lokasiindex;

  getUid() {}

  @override
  void initState() {
    this.uid = '';
    FirebaseAuth.instance.currentUser().then((val) {
      print(val);
      setState(() {
        this.uid = val.uid;
      });
    }).catchError((e) {
      print(e);
    });
    super.initState();
  }

  void _showDialog() {
    if (status_muatan == "menunggu konfirmasi") {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Perhatian!"),
              content: new Text(
                  "Anda akan mengambil ${barang} di Gudang ${gudang}."),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: new Text("Tidak")),
                new FlatButton(
                    onPressed: () {
                      Firestore.instance
                          .document("order/${IDData}")
                          .updateData({"status": "Sedang Ambil"}).then((error) {
                        print("Data Berhasil Update");
                      }).catchError((onError) {
                        print(onError);
                      });
                      Navigator.pop(context);
                    },
                    child: new Text("Ya"))
              ],
            );
          });
    } else if (status_muatan == "Sedang Ambil") {}
    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: new Text("Perhatian!"),
    //         content: new Text("Anda Akan merubah Status Pengirman."),
    //         actions: <Widget>[
    //           new FlatButton(
    //               onPressed: () {
    //                 Navigator.pop(context);
    //               },
    //               child: new Text("Tidak")),
    //           new FlatButton(
    //               onPressed: () {
    //                 _updateData();
    //                 Navigator.pop(context);
    //               },
    //               child: new Text("Ya, saya akan merubah Status Pengiriman"))
    //         ],
    //       );
    //     });
  }

  Widget _bodyku() {
    return new StreamBuilder(
        stream: Firestore.instance
            .collection("order")
            .where("id_driver", isEqualTo: uid.toString())
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return new Padding(
              padding: EdgeInsets.all(50),
              child: Center(
                child: new CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.hasData && snapshot.data.documents.isNotEmpty) {
            var banyakdata = snapshot.data.documents.length;
            print("UID YANG LOGIN " + uid);
            for (var i = 0; i < banyakdata; i++) {
              if (snapshot.data.documents[i]["status"].toString() ==
                  "menunggu konfirmasi") {
                kotaasal = snapshot.data.documents[i]["asal_tujuan"];
                status = "Sedang Mengambil";
                IDData = snapshot.data.documents[i].documentID;
                status_muatan = snapshot.data.documents[i]["status"].toString();
                barang = snapshot.data.documents[i]["barang"];
                gudang = snapshot.data.documents[i]["asal_tujuan"];

                var datalokasi = Firestore.instance
                    .collection('gudang')
                    .document(snapshot.data.documents[i]["asal_tujuan"])
                    .get()
                    .then((DocumentSnapshot ds) {
                  lat = ds.data["lat"];
                  lng = ds.data["lng"];
                  alamatgudang = ds.data["alamatgudang"];
                });

                return Column(
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
                                      "Status : ",
                                      style: TextStyle(
                                          fontFamily: 'GoogleFont',
                                          fontSize: 16),
                                    ),
                                    Text(
                                      snapshot.data.documents[i]['status']
                                          .toString(),
                                      style: TextStyle(
                                          fontFamily: 'GoogleFont',
                                          fontSize: 17,
                                          color: Colors.red),
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
                      padding: EdgeInsets.only(left: 15, top: 10),
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
                                          fontFamily: 'GoogleFont',
                                          fontSize: 22),
                                    ),
                                    Text(
                                      snapshot.data.documents[i]['barang']
                                          .toString(),
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
                      padding: EdgeInsets.only(left: 15, top: 10),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "Asal : ",
                                      style: TextStyle(
                                          fontFamily: 'GoogleFont',
                                          fontSize: 30),
                                    ),
                                    Text(
                                      "Gudang " +
                                          snapshot
                                              .data.documents[i]['asal_tujuan']
                                              .toString(),
                                      style: TextStyle(
                                        fontFamily: 'GoogleFont',
                                        fontSize: 30,
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

                    // Padding(
                    //   padding: EdgeInsets.only(left: 15, top: 5),
                    //   child: Column(
                    //     children: <Widget>[
                    //       Container(
                    //           child: Column(
                    //         children: <Widget>[
                    //           Row(
                    //             children: <Widget>[
                    //               Text(
                    //                 "Asal : ",
                    //                 style: TextStyle(
                    //                     fontFamily: 'GoogleFont',
                    //                     fontSize: 30),
                    //               ),
                    //               Text(
                    //                 "Gudang " +
                    //                     snapshot
                    //                         .data.documents[i]['asal_tujuan']
                    //                         .toString(),
                    //                 style: TextStyle(
                    //                     fontFamily: 'GoogleFont',
                    //                     fontSize: 30,
                    //                     fontWeight: FontWeight.w800),
                    //               )
                    //             ],
                    //           ),
                    //           Row(
                    //             children: <Widget>[
                    //               Text(
                    //                 "Alamat : ",
                    //                 style: TextStyle(
                    //                     fontFamily: 'GoogleFont',
                    //                     fontSize: 25,
                    //                     color: Colors.black),
                    //               ),
                    //               Text(
                    //                 alamatgudang,
                    //                 style: TextStyle(
                    //                     fontFamily: 'GoogleFont',
                    //                     fontSize: 22,
                    //                     fontWeight: FontWeight.w800),
                    //               )
                    //             ],
                    //           ),
                    //         ],
                    //       )),
                    //     ],
                    //   ),
                    // ),
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
                                    style: TextStyle(
                                        fontFamily: 'GoogleFont', fontSize: 22),
                                  ),
                                  Text(
                                    "19:00 WIB",
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
                          new MaterialButton(
                            minWidth: MediaQuery.of(context).size.width - 30,
                            child: new Text(status,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'GoogleFont',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16)),
                            color: Color.fromRGBO(15, 76, 117, 1),
                            onPressed: () async {
                              _showDialog();
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, top: 5),
                      child: Column(
                        children: <Widget>[
                          new MaterialButton(
                            minWidth: MediaQuery.of(context).size.width - 30,
                            child: new Text("Tunjukkan Arah",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'GoogleFont',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16)),
                            color: Color.fromRGBO(15, 76, 117, 1),
                            onPressed: () async {
                              if (await MapLauncher.isMapAvailable(
                                  MapType.google)) {
                                await MapLauncher.launchMap(
                                  mapType: MapType.google,
                                  coords: Coords(
                                      double.parse(lat), double.parse(lng)),
                                  title: snapshot
                                      .data.documents[i]["asal_tujuan"]
                                      .toString(),
                                  description: snapshot
                                      .data.documents[i]["asal_tujuan"]
                                      .toString(),
                                );
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, top: 30, right: 15),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Tidak Bisa Mengambil? Lapor ke Operator",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'OpenSansRegular'),
                          ),
                          new MaterialButton(
                            minWidth: MediaQuery.of(context).size.width - 30,
                            child: new Text("Lapor Operator",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'GoogleFont',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16)),
                            color: Colors.red,
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => new LaporOrder(
                                          id_order: IDData,
                                        )),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                );
              } else if (snapshot.data.documents[i]["status"].toString() ==
                  "Sedang Ambil") {
                status = "Sedang Mengambil";
                IDData = snapshot.data.documents[i].documentID;
                status_muatan = snapshot.data.documents[i]["status"].toString();

                var datalokasi = Firestore.instance
                    .collection('gudang')
                    .document(snapshot.data.documents[i]["asal_tujuan"])
                    .get()
                    .then((DocumentSnapshot ds) {
                  lat = ds.data["lat"];
                  lng = ds.data["lng"];
                  alamatgudang = ds.data["alamatgudang"];
                });

                return Column(
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
                                      "Status : ",
                                      style: TextStyle(
                                          fontFamily: 'GoogleFont',
                                          fontSize: 16),
                                    ),
                                    Text(
                                      snapshot.data.documents[i]['status']
                                          .toString(),
                                      style: TextStyle(
                                          fontFamily: 'GoogleFont',
                                          fontSize: 17,
                                          color: Colors.red),
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
                      padding: EdgeInsets.only(left: 15, top: 10),
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
                                          fontFamily: 'GoogleFont',
                                          fontSize: 22),
                                    ),
                                    Text(
                                      snapshot.data.documents[i]['barang']
                                          .toString(),
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
                      padding: EdgeInsets.only(left: 15, top: 10),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "Asal : ",
                                      style: TextStyle(
                                          fontFamily: 'GoogleFont',
                                          fontSize: 30),
                                    ),
                                    Text(
                                      "Gudang " +
                                          snapshot
                                              .data.documents[i]['asal_tujuan']
                                              .toString(),
                                      style: TextStyle(
                                        fontFamily: 'GoogleFont',
                                        fontSize: 30,
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
                                    "Batas Ambil : ",
                                    style: TextStyle(
                                        fontFamily: 'GoogleFont', fontSize: 22),
                                  ),
                                  Text(
                                    "19:00 WIB",
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
                          new MaterialButton(
                            minWidth: MediaQuery.of(context).size.width - 30,
                            child: new Text("Kirim Tujuan",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'GoogleFont',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16)),
                            color: Color.fromRGBO(15, 76, 117, 1),
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => new UpdateTujuan(
                                            id_order: IDData,
                                            asal: snapshot.data
                                                .documents[i]['asal_tujuan']
                                                .toString(),
                                          )));
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, top: 5),
                      child: Column(
                        children: <Widget>[
                          new MaterialButton(
                            minWidth: MediaQuery.of(context).size.width - 30,
                            child: new Text("Tunjukkan Arah",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'GoogleFont',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16)),
                            color: Color.fromRGBO(15, 76, 117, 1),
                            onPressed: () async {
                              if (await MapLauncher.isMapAvailable(
                                  MapType.google)) {
                                await MapLauncher.launchMap(
                                  mapType: MapType.google,
                                  coords: Coords(
                                      double.parse(lat), double.parse(lng)),
                                  title: snapshot
                                      .data.documents[i]["asal_tujuan"]
                                      .toString(),
                                  description: snapshot
                                      .data.documents[i]["asal_tujuan"]
                                      .toString(),
                                );
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, top: 30, right: 15),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Tidak Bisa Mengambil? Lapor ke Operator",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'OpenSansRegular'),
                          ),
                          new MaterialButton(
                            minWidth: MediaQuery.of(context).size.width - 30,
                            child: new Text("Lapor Operator",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'GoogleFont',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16)),
                            color: Colors.red,
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => new LaporOrder(
                                          id_order: IDData,
                                        )),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return new Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Tidak ada Order \nbaru untuk anda",
                            style: TextStyle(
                                fontFamily: 'GoogleFont', fontSize: 25),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }
            }
          } else {
            return new Container(
              width: 0.0,
              height: 0.0,
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _bodyku(),
    );
  }
}
