import 'package:flutter/material.dart';

class CheckboxView extends StatefulWidget {
  const CheckboxView({super.key});

  @override
  State<CheckboxView> createState() => _CheckboxViewState();
}

class _CheckboxViewState extends State<CheckboxView> {
  // var item = 'a';
  // var items = ['a', 'b', 'c', 'd'];
  var listMock = [
    MockLitString(name: 'aa', value: true),
    MockLitString(name: 'b', value: true),
    MockLitString(name: 'c', value: false),
    MockLitString(name: 'd', value: false)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: listMock.length,
          itemBuilder: (BuildContext context, int index) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(listMock[index].name),
              ),
              const SizedBox(
                width: 20,
              ),
              // Text(items[index])
              Checkbox(
                  value: listMock[index].value,
                  onChanged: (bool? d) {
                    setState(() {
                      listMock[index].value = d!;
                    });
                  })
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
              onPressed: () {
                setState(() {
                  listMock = listMock.where((i) => i.value == true).toList();
                });
              },
              child: const Text('Complete')),
          TextButton(
              onPressed: () {
                setState(() {
                  listMock = listMock
                      .where((element) => element.value == false)
                      .toList();
                });
              },
              child: const Text('InComplete')),
        ],
      )),
    );
  }
}

class MockLitString {
  String name;
  bool value;

  MockLitString({required this.name, required this.value});
}
