import 'dart:convert'; // เมื่อใช้  json.decode

import 'package:flutter/material.dart';
import 'package:myproject/model/staff_model.dart';
import 'package:http/http.dart' as http;

class FindDriver extends StatefulWidget {
  const FindDriver({Key? key}) : super(key: key);

  @override
  State<FindDriver> createState() => _FindDriverState();
}

class _FindDriverState extends State<FindDriver> {
  StaffModel? staffModel;
  StaffModel? dataStaff;
  int txtID = 0;
  String? driverName = '';

  @override
  Future<void> findDriver() async {
    print('txtID >> $txtID');
    String url =
        'https://www.vaiwits.com/stpwcheckin/api/json_data_select_staff.php?userID=$txtID';
    // print('url = $url');
    http.Response response = await http.get(Uri.parse(url));
    var result = json.decode(response.body);
    var item = result['data'];

    StaffModel dataStaff = StaffModel.fromJson(item);
    String? personName = dataStaff.data?.personName;

    print('item = $dataStaff');

    setState(() {
      print('item = $personName');
      driverName = personName;
    });
  }

  Widget formData() {
    return Center(
        child: Column(
      children: [
        Text('INPUT HERE'),
        TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.confirmation_number),
            hintText: 'data 1 ',
            labelText: 'Data one *',
          ),
          onChanged: (val) {
            setState(() {
              txtID = int.parse(val);
            });
          },
        ),
        ElevatedButton(
          // style: style,
          onPressed: () {
            findDriver();
          },
          child: const Text('Submit'),
        ),
      ],
    ));
  }

  Widget resultData() {
    return Container(
      child: Card(
        child: Text('driverName >> $driverName'),
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
          title: const Text('Search Driver'),
        ),
        body: SizedBox(
          child: Column(
            children: [formData(), resultData(), backBTN()],
          ),
        ),
      ),
    );
  }
}
