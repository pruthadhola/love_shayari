import 'package:flutter/material.dart';
import 'configpage.dart';
import '1shayri.dart';
import 'package:permission_handler/permission_handler.dart';


void main()
{
  runApp(MaterialApp(home: home(),));
}
class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  List l=[];

  void initState()
  {
    super.initState();
    getdata();
  }

  getdata()
  async{
    var status = await Permission.storage.status;

    if (status.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
      ].request();
      print(statuses[Permission.location]);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.greenAccent,title: Text("Love Shayari")),
      body: ListView.separated(itemBuilder: (context, index) {

        return InkWell(onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return shubhkamnai(index);
          },));
        },child: ListTile(leading: Image(image: AssetImage("${data.cat_image[index]}")),title: Text("${data.category[index]}"),));
      }, separatorBuilder: (context, index) {
        return Divider(thickness: 8,);
      }, itemCount:data.category.length ),
    );
  }
}