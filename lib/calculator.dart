import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  int data1 = 0;
  int data2 = 0;
  int resultPlus = 0;

  Future<void> plusData() async {
    setState(() {
      resultPlus = data1 + data2;
    });
    print('$data1 + $data2 = $resultPlus');
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
              data1 = int.parse(val);
            });
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.confirmation_number),
            hintText: 'data 2 ',
            labelText: 'Data two *',
          ),
          onChanged: (val) {
            data2 = int.parse(val);
          },
        ),
        ElevatedButton(
          // style: style,
          onPressed: () {
            plusData();
          },
          child: const Text('Submit'),
        ),
      ],
    ));
  }

  Widget resultadd() {
    return Container(
      child: Card(
        child: Text('result : $resultPlus'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('STPW checkin'),
        ),
        body: SizedBox(
          child: Column(
            children: [
              formData(),
              resultadd(),
            ],
          ),
        ),
      ),
    );
  }
}
