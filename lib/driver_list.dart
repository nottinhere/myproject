import 'dart:convert'; // เมื่อใช้  json.decode
// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:myproject/model/staff_model.dart';
import 'package:http/http.dart' as http;
import 'package:myproject/driver_detail.dart';

class ListDriver extends StatefulWidget {
  const ListDriver({Key? key}) : super(key: key);

  @override
  State<ListDriver> createState() => _ListDriverState();
}

class _ListDriverState extends State<ListDriver> {
  StaffModel? staffModel;
  StaffModel? dataStaff;
  StaffModel? staffAllModel;
  List<StaffModel?> staffAllModels = [];
  ScrollController scrollController = ScrollController();

  int txtID = 0;
  String? driverName = '';

  @override
  void initState() {
    // auto load
    super.initState();
    // myIndex = widget.index;
    // myUserModel = widget.userModel;

    // createController(); // เมื่อ scroll to bottom

    setState(() {
      readData(); // read  ข้อมูลมาแสดง
    });
  }

  Future<void> readData() async {
    // print('txtID >> $txtID');
    String url = 'https://www.vaiwits.com/stpwcheckin/api/json_data_staff.php';
    print('url = $url');
    http.Response response = await http.get(Uri.parse(url));
    var result = json.decode(response.body);

    var itemData = result['data'];
    // print('item = $itemData');

    for (var map in itemData) {
      StaffModel staffAllModel = StaffModel.fromJson(map);
      setState(() {
        staffAllModels.add(staffAllModel);
        // filterProductAllModels = productAllModels;
      });
    }
    print('staffAllModels = $staffAllModels');
  }

  Widget formData() {
    return Center(
        child: Row(
      children: [
        // Text('INPUT HERE'),
        Container(
          width: MediaQuery.of(context).size.width * 0.79,
          child: TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.confirmation_number),
              hintText: 'Search ',
              labelText: 'คำค้นหา',
            ),
            onChanged: (val) {
              setState(() {
                txtID = int.parse(val);
              });
            },
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.19,
          child: ElevatedButton(
            // style: style,
            onPressed: () {
              readData();
            },
            child: const Text('Submit'),
          ),
        ),
      ],
    ));
  }

  Widget showData() {
    // print('driverName>> $driverName');
    return Expanded(
      child: ListView.builder(
        itemCount: staffAllModels.length,
        itemBuilder: (BuildContext buildContext, int index) {
          return GestureDetector(
            child: Container(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(staffAllModels[index]!.subject!),
                ),
              ),
            ),
            onTap: () {
              print('index >> $index');
              MaterialPageRoute materialPageRoute =
                  MaterialPageRoute(builder: (BuildContext buildContext) {
                return driverDetail(
                  staffModel: staffAllModels[index],
                );
              });
              Navigator.of(context).push(materialPageRoute);
            },
          );
        },
      ),
    );
  }

  Widget backBTN() {
    return ElevatedButton(
      // Within the SecondScreen widget
      onPressed: () {
        // Navigate back to the first screen by popping the current route
        // off the stack.
        Navigator.pop(context);
      },
      child: const Text('Go back!'),
    );
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('List Driver'),
        ),
        body: SizedBox(
          child: Column(
            children: [formData(), showData(), backBTN()],
          ),
        ),
      ),
    );
  }
}
