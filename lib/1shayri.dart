import 'configpage.dart';
import '3rdpage.dart';
import 'package:flutter/material.dart';


import '3rdpage.dart';

class shubhkamnai extends StatefulWidget {
  int sy;

  shubhkamnai(this.sy);

  @override
  State<shubhkamnai> createState() => _shubhkamnaiState();
}

class _shubhkamnaiState extends State<shubhkamnai> {
  List l = [];



  @override
  void initState() {
    super.initState();
    if (widget.sy == 0) {
      l.addAll(data.shubhkamnye);
    } else if (widget.sy == 1) {
      l.addAll(data.Dosti);
    } else if (widget.sy == 2) {
      l.addAll(data.majedar);
    } else if (widget.sy == 3) {
      l.addAll(data.bhagavan);
    } else if (widget.sy == 4) {
      l.addAll(data.prerna);
    } else if (widget.sy == 5) {
      l.addAll(data.jivan);
    } else if (widget.sy == 6) {
      l.addAll(data.mohabbat);
    } else if (widget.sy == 7) {
      l.addAll(data.yaadein);
    } else if (widget.sy == 8) {
      l.addAll(data.anya);
    } else {
      l.add("");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.greenAccent, title: Text("Love Shayri")),
        body: ListView.separated(
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return shayari(l,index);
                      },
                    ));
                  },
                  child: ListTile(
                    leading: Image(
                        image: AssetImage("${data.cat_image[widget.sy]}")),
                    tileColor: Colors.pink,
                    title: Text("${l[index].toString().substring(0,20)}",
                        style: TextStyle(color: Colors.white)),
                  ));
            },
            separatorBuilder: (context, index) {
              return Divider(
                thickness: 8,
              );
            },
            itemCount: l.length));
  }
}