import 'dart:convert'; // เมื่อใช้  json.decode
import 'package:flutter/material.dart';
import 'package:myproject/model/staff_model.dart';
import 'package:myproject/model/checkin_model.dart';
import 'package:http/http.dart' as http;

class driverDetail extends StatefulWidget {
  final StaffModel? staffModel;

  const driverDetail({Key? key, this.staffModel}) : super(key: key);

  @override
  State<driverDetail> createState() => _driverDetailState();
}

class _driverDetailState extends State<driverDetail> {
  StaffModel? currentstaffModel;
  StaffModel? staffModel;

  CheckinModel? checkinModel;
  List<CheckinModel> checkinAllModels = [];
  String? memID;

  int txtID = 0;
  String? driverName = '';
  StaffModel? dataStaff;

  @override
  void initState() {
    super.initState();
    currentstaffModel = widget.staffModel;
    setState(() {
      readCheckin();
      findDriver();
    });
  }

  Future<void> readCheckin() async {
    // print('txtID >> $txtID');
    memID = currentstaffModel?.id.toString();
    String url =
        'https://www.vaiwits.com/stpwcheckin/api/json_data_checkin_history.php?memberID=$memID';
    // print('url = $url');
    http.Response response = await http.get(Uri.parse(url));
    var result = json.decode(response.body);

    var itemData = result['data'];
    // print('item = $itemData');

    for (var map in itemData) {
      CheckinModel checkinAllModel = CheckinModel.fromJson(map);
      setState(() {
        checkinAllModels.add(checkinAllModel);
        // filterProductAllModels = productAllModels;
      });
    }
    // print('checkinAllModels = $checkinAllModels');
  }

  Future<void> findDriver() async {
    memID = currentstaffModel?.id.toString();
    String url =
        'https://www.vaiwits.com/stpwcheckin/api/json_data_select_staff.php?memberID=$memID';
    print('url = $url');
    http.Response response = await http.get(Uri.parse(url));
    var result = json.decode(response.body);

    var item = result['data'];
    print('item = $item');

    setState(() {
      dataStaff = StaffModel.fromJson(item);
      driverName = dataStaff?.subject.toString();
    });
  }

  Widget checkinList() {
    return Expanded(
      child: ListView.builder(
        itemCount: checkinAllModels.length,
        itemBuilder: (BuildContext buildContext, int index) {
          return GestureDetector(
            child: Container(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('(${checkinAllModels[index].sqindate!}) '),
                          Text(
                              'Time : ${checkinAllModels[index].timecheck!} | '),
                          Text(
                              'Dis : ${checkinAllModels[index].dpmformpoint!} '),
                        ],
                      ),
                      Row(
                        children: [
                          Text(checkinAllModels[index].sod! + ' | '),
                          Text(checkinAllModels[index].siv!),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(driverName!),
      ),
      body: SizedBox(
        child: checkinList(),
      ),
    );
  }
}
