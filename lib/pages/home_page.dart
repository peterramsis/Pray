import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutter_spinkit/flutter_spinkit.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  Map user= {};
  List errors = [];
  bool is_loading = false;
  String result = "";

  Future scan() async{
    is_loading =true;
    String cameraScanResult = await scanner.scan();
    setState(() {
      result  = cameraScanResult;
      errors.clear();
    });
   await getUser(int.parse(result));
   print(errors);
  }



  Widget cardUser(){

     
    if(is_loading == true){
      return Center(
        child: Container(
          child:  SpinKitCubeGrid(
            color: Colors.white,
            size: 50.0,
          ),
        ),
      );
    }else if (errors.length == 0 && user.isNotEmpty) {

       return Container(
           width: 400,
           height: 400,
           child: Column(
             children: <Widget>[
               CircleAvatar(
                 maxRadius: 100,
                 backgroundImage: NetworkImage("https://full-time.wsestaffhub.com/public/upload/user/${user['image']}"),
               ),
               SizedBox(
                 height: 10,
               ),
               Text(
                "${user["first_name"]} ${user['last_name']}",
                 style: TextStyle(
                   fontSize: 23,
                   color: Colors.white
                 ),
               )
             ],
           ),
       );
    }else if(errors.contains("user not found")){

       return Container(
         child: Text("User not found",style: TextStyle(
             color: Colors.white,
             fontSize: 23
         ),),
       );

     }else{
      return Container(
        child: Text("Please scan",style: TextStyle(
          color: Colors.white,
          fontSize: 23
        ),),
      );
    }
  }



  Future getUser(int id) async{
    is_loading = true;
    try {
      Response response = await Dio().get("https://full-time.wsestaffhub.com/api/getUser/${id}");

      if(response.data['error'] !="user not found"){
       setState(() {
          user.addAll(response.data);
          is_loading = false;
        });
      }else{

          if(response.data['error'] == "user not found"){
            setState(() {
            errors.add(response.data['error']);
            is_loading = false;
            });
          }

      }

    } catch (e) {
      print(e);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2f3640),
      body: Center(
        child: Container(
          child: cardUser()
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
         // getUser(900);
//          FlutterBarcodeScanner.getBarcodeStreamReceiver("#ff6666", "Cancel", false, ScanMode.DEFAULT)
//              .listen((barcode) {
//            /// barcode to be used
//            setState(() {
//              result = barcode;
//            });
//          });

//         print("click");
         scan();



        },
        icon: Icon(Icons.camera_alt),
        label: Text("Scan"),
      ),
    );
  }
}