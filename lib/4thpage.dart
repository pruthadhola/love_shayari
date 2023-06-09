import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'configpage.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:external_path/external_path.dart';
import 'package:share_plus/share_plus.dart';

class edit extends StatefulWidget {
  List l;
  int index;

  edit(
    this.l,
    this.index,
  );

  @override
  State<edit> createState() => _editState();
}

class _editState extends State<edit> {
  @override
  Color clr = Colors.red;
  Color textclr = Colors.white;
  int clrind = 0;
  bool clrtemp = false;
  int textclrind = 0;
  bool textclrtemp = false;
  double x = 20;
  double fontsize = 20;
  int emojiind = 0;
  bool emojitemp = false;
  String ff = "f1";
  WidgetsToImageController controller = WidgetsToImageController();
  Uint8List? bytes;




  Widget build(BuildContext context) {
    double statusbarheight = MediaQuery.of(context).viewPadding.top;
    double appbarheight = kToolbarHeight;
    double total = statusbarheight + appbarheight;
    double height = MediaQuery.of(context).size.height - total;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          title: Text("फोटो पे शायरी लिखे")),
      body: Center(
        child: Column(
          children: [
            WidgetsToImage(controller: controller,
              child: Container(
                height: 300,
                width: double.infinity,
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                decoration: BoxDecoration(
                  color: (clrtemp == false) ? clr : null,
                  gradient: (clrtemp == true)
                      ? LinearGradient(
                          colors: [data.myclr[clrind], data.myclr[clrind + 1]])
                      : null,
                ),
                child: Center(
                    child: Text(
                  (emojitemp == false)
                      ? "${data.emoji[widget.index]}"
                          "\n${widget.l[widget.index]}\n${data.emoji[widget.index]}"
                      : "${data.emoji[emojiind]}"
                          "\n${widget.l[widget.index]}\n${data.emoji[emojiind]}",
                  style: TextStyle(
                      fontSize: fontsize,fontFamily: ff,
                      color: (textclrtemp == false) ? textclr : null),
                )),
              ),
            ),
            Expanded(
                child: SizedBox(
              height: 100,
              width: 100,
            )),
            Container(
              width: 400,
              height: 150,
              color: Colors.brown,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                    onTap: () {
                                      var r = Random()
                                          .nextInt(data.myclr.length - 1);
                                      clrind = r;
                                      clrtemp = true;
                                      setState(() {});
                                    },
                                    child: Image(
                                        image:
                                            AssetImage('images/reload.jpg'))),
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
                                                      mainAxisSpacing: 10,
                                                      crossAxisSpacing: 10),
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    clrtemp = true;
                                                    clrind = index;
                                                    Navigator.pop(context);
                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    child: Text(
                                                        "${widget.l[widget.index]}",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                    decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                                colors: [
                                                          data.myclr[index],
                                                          data.myclr[index + 1]
                                                        ])),
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Image(
                                        image: AssetImage('images/expand.jpg')))
                              ]),
                          height: 35,
                          width: 130,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: 150,
                                  child: GridView.builder(itemCount: data.color.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 8,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                          onTap: () {
                                            clrtemp = false;
                                            clr = data.color[index];
                                            Navigator.pop(context);
                                            setState(() {});
                                          },
                                          child: Container(
                                            color: data.color[index],
                                          ));
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                              width: 100,
                              height: 30,
                              color: Colors.red,
                              child: Center(
                                  child: Text(
                                "Background",
                                style: TextStyle(color: Colors.white),
                              ))),
                        ),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: 150,
                                  child: GridView.builder(itemCount: data.textclr.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 8,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                          onTap: () {
                                            textclrtemp = false;
                                            textclr = data.textclr[index];
                                            Navigator.pop(context);
                                            setState(() {});
                                          },
                                          child: Container(
                                            color: data.textclr[index],
                                          ));
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                              width: 100,
                              height: 30,
                              color: Colors.red,
                              child: Center(
                                  child: Text("Text Color",
                                      style: TextStyle(color: Colors.white)))),
                        ),
                        InkWell(onTap: () async {
                          bytes = await controller.capture();
                          var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
                          Directory dir=Directory(path);

                          if(!await dir.exists())
                            {
                              dir.create();
                            }

                          int r=Random().nextInt(1000);
                          String img_name="img{r}.jpg";

                          File f=File('$path/$img_name');
                          await f.writeAsBytes(bytes!);
                          print(f.path);
                          Share.shareFiles(['${f.path}'], text: 'Great picture');

                          print(bytes);
                          setState(() {

                          });
                        },
                          child: Container(
                              width: 100,
                              height: 30,
                              color: Colors.red,
                              child: Center(
                                  child: Text("Share",
                                      style: TextStyle(color: Colors.white)))),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: 60, 
                                  color: Colors.white,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: data.font.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(onTap: () {
                                        ff=data.font[index];
                                        setState(() {

                                        });
                                      },
                                        child: Container(
                                          height: 50,
                                          width: 100,
                                          color: Colors.pink,
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.all(10),
                                          child: Text("शायरी",
                                            style: TextStyle(fontFamily: data.font[index])),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                              width: 100,
                              height: 30,
                              color: Colors.red,
                              alignment: Alignment.center,
                              child: Center(
                                  child: Text("Font",
                                      style: TextStyle(color: Colors.white)))),
                        ),
                        Container(
                            width: 100,
                            height: 30,
                            color: Colors.red,
                            child: Center(
                                child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return ListView.separated(
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                              onTap: () {
                                                emojitemp = true;
                                                emojiind = index;
                                                Navigator.pop(context);
                                                setState(() {});
                                              },
                                              child: ListTile(
                                                title: Text(
                                                    "${data.emoji[index]}"),
                                              ));
                                        },
                                        separatorBuilder: (context, index) {
                                          return Divider(
                                            thickness: 5,
                                          );
                                        },
                                        itemCount: data.emoji.length - 1);
                                  },
                                );
                              },
                              child: Text("Emoji",
                                  style: TextStyle(color: Colors.white)),
                            ))),
                        Container(
                            width: 100,
                            height: 30,
                            color: Colors.red,
                            child: Center(
                                child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(
                                      builder: (context, setState1) {
                                        return Container(
                                          height: 100,
                                          color: Colors.brown,
                                          child: Slider(
                                            value: x,
                                            max: 40,
                                            min: 10,
                                            onChanged: (value) {
                                              x = value;
                                              fontsize = value;
                                              setState1(() {
                                                setState(() {});
                                              });
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              child: Text("Text Size",
                                  style: TextStyle(color: Colors.white)),
                            ))),
                      ],
                    ),
                //bytes!=null?Image.memory(width: 100,bytes!) : Text("no images"),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
