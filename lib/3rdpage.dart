import 'dart:math';

import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:share_plus/share_plus.dart';
import '4thpage.dart';
import 'configpage.dart';

class shayari extends StatefulWidget {
  List l1 = [];
  int index;

  shayari(this.l1, this.index);

  @override
  State<shayari> createState() => _shayariState();
}

class _shayariState extends State<shayari> {
  PageController? pc;

  int c_index = 0;
  int a = 0;
  Color clr=Colors.pink;
  int clrind =0;
  bool clrtemp=false;

  @override
  void initstate() {
    super.initState();
    c_index = widget.index;
    pc = PageController(initialPage: widget.index);


  }

  Widget build(BuildContext context) {
    double statusbarheight = MediaQuery.of(context).viewPadding.top;
    double appbarheight = kToolbarHeight;
    double total = statusbarheight + appbarheight;
    double height = MediaQuery.of(context).size.height - total;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.greenAccent, title: Text(" Love Shayari")),
      // body: Center(
      //     child: Container(
      //         height: 300,
      //         width: double.infinity,
      //         decoration: BoxDecoration(color: Colors.pink),
      //        child: PageView.builder(onPageChanged: (value) {
      //          c_index=value;
      //          setState(() {
      //
      //          });
      //        },itemBuilder: (context, index) {
      //          return Container(
      //            child:Center(child: Text("${widget.l1[c_index]}",style: TextStyle(color: Colors.white,fontSize: 25),)) ,);
      //        },itemCount: widget.l1.length),
      //     )),
      body: Column(children: [
        Container(
            height: 100,
            width: double.infinity,
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return Container(
                            height: height,
                            child: GridView.builder(
                              itemCount: data.myclr.length - 1,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10),
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () {
                                      clrtemp=true;
                                      clrind=index;
                                      Navigator.pop(context);
                                      setState(() {

                                      });
                                    },
                                    child: Container(child: Text("${widget.l1[widget.index]}",style: TextStyle(color: Colors.white)),
                                      // color: data.myclr[index],
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(colors:[data.myclr[index],data.myclr[index+1]] ),),
                                    ));
                              },
                            ),
                          );
                        },
                      );
                    },
                    child: Image(image: AssetImage('images/expand.jpg'))),
                Text(
                  "${widget.index + 1}/${widget.l1.length}",
                  style: TextStyle(fontSize: 30),
                ),
                InkWell(onTap: () {
                  var r=Random().nextInt(data.myclr.length-1);
                  clrind=r;
                  clrtemp=true;
                  setState(() {

                  });

                },child: Image(image: AssetImage('images/reload.jpg')))
              ],
            ))),
        Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
              color: (clrtemp == false)?clr:null,
            gradient: (clrtemp == true)?LinearGradient(colors: [data.myclr[clrind],data.myclr[clrind+1]]) : null,
          ),
          child: PageView.builder(controller: pc,
              onPageChanged: (value) {
                widget.index = value;
                setState(() {});
              },
              itemBuilder: (context, index) {
                return Container(
                  child: Center(
                      child: Text("${data.emoji[widget.index]}"
                    "${widget.l1[widget.index]}""${data.emoji[widget.index]}",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )),
                );
              },
              itemCount: widget.l1.length),
        ),
        Expanded(child: SizedBox(height: 100, width: 100)),
        Container(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            InkWell(
                onTap: () {
                  FlutterClipboard.copy('${widget.l1[widget.index]}')
                      .then((value) => print('copied'));
                },
                child: Icon(Icons.file_copy, color: Colors.white, size: 30)),
            InkWell(
                onTap: () {
                  setState(() {
                    if (widget.index > 0) {
                      widget.index--;
                      pc?.jumpToPage(widget.index);
                    }
                  });
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 30,
                )),
            InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return edit(widget.l1, widget.index);
                    },
                  ));
                },
                child: Image(image: AssetImage('images/edit.jpg'))),
            InkWell(
                onTap: () {
                  setState(() {
                    if (widget.index < widget.l1.length - 1) {
                      widget.index++;
                      pc?.jumpToPage(widget.index);
                    }
                  });
                },
                child: Icon(Icons.arrow_forward_ios,
                    color: Colors.white, size: 30)),
            InkWell(
                onTap: () {
                  Share.share('check out my website https://example.com');
                },
                child: Icon(Icons.share, color: Colors.white, size: 30)),
          ]),
          width: double.infinity,
          height: 100,
          color: Colors.green,
        )
      ]),
    );
  }
}
