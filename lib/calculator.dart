import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  double data1 = 0;
  double data2 = 0;
  double resultPlus = 0;
  String dropdownValue = '+';

  Future<void> plusData() async {
    print('dropdownValue >> $dropdownValue');
    setState(() {
      if (dropdownValue == '+')
        resultPlus = data1 + data2;
      else if (dropdownValue == '-')
        resultPlus = data1 - data2;
      else if (dropdownValue == '*')
        resultPlus = data1 * data2;
      else if (dropdownValue == '/') resultPlus = data1 / data2;
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
              data1 = double.parse(val);
            });
          },
        ),
        DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <String>['+', '-', '*', '/']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.confirmation_number),
            hintText: 'data 2 ',
            labelText: 'Data two *',
          ),
          onChanged: (val) {
            data2 = double.parse(val);
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Calculator'),
        ),
        body: SizedBox(
          child: Column(
            children: [formData(), resultadd(), backBTN()],
          ),
        ),
      ),
    );
  }
}
