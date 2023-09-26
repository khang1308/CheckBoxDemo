import 'package:demo2/modal/checkboxmodal.dart';
import 'package:flutter/material.dart';

class CheckBoxGroupView extends StatefulWidget {
  const CheckBoxGroupView({super.key});

  @override
  State<CheckBoxGroupView> createState() => _CheckBoxGroupViewState();
}

class _CheckBoxGroupViewState extends State<CheckBoxGroupView> {
  List<CheckboxModal> todolist = [];
  List<CheckboxModal> todolistRender = [];
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'All Task',
        ),
        centerTitle: true,
      ),
      body: Column(children: [
        TextButton(
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Create Task',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                bool isChecked = false;
                TextEditingController controller = TextEditingController();
                return AlertDialog(
                  title: const Text('Create Task'),
                  content: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller,
                          decoration: const InputDecoration(
                              hintText: 'Write task here'),
                          validator: (value) {
                            var newValue = value ?? "";
                            if (newValue.isEmpty) {
                              return 'title is Required';
                            }
                            return null;
                          },
                        ),
                      ),
                      StatefulBuilder(builder: (context, state) {
                        return Checkbox(
                          checkColor: Colors.white,
                          value: isChecked,
                          onChanged: (bool? value) {
                            state(() {
                              isChecked = value!;
                            });
                            print("${isChecked} ${value!}");
                          },
                        );
                      })
                    ],
                  ),
                  actions: [
                    TextButton(
                        child: const Text('SUBMIT'),
                        onPressed: () {
                          setState(() {
                            todolist.add(CheckboxModal(
                                name: controller.text, selected: isChecked));
                            if (selectedTab == 0) {
                              todolistRender = todolist;
                            } else if (selectedTab == 1) {
                              todolistRender = todolist
                                  .where((element) => element.selected == true)
                                  .toList();
                            } else {
                              todolistRender = todolist
                                  .where((element) => element.selected == false)
                                  .toList();
                            }

                            Navigator.of(context).pop();
                          });
                        })
                  ],
                );
              }),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: todolistRender.length,
            itemBuilder: (BuildContext context, int index) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(todolistRender[index].name),
                Checkbox(
                    value: todolistRender[index].selected,
                    onChanged: (bool? b) {
                      setState(() {
                        todolistRender[index].selected = b!;
                      });
                    })
              ],
            ),
          ),
        )
      ]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(border: Border.all()),
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  selectedTab = 1;
                  todolistRender = todolist
                      .where((element) => element.selected == true)
                      .toList();
                });
              },
              child: const Text(
                'Complete',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  selectedTab = 0;
                  todolistRender = todolist;
                });
              },
              child: const Text(
                'All',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  selectedTab = -1;
                  todolistRender = todolist
                      .where((element) => element.selected == false)
                      .toList();
                });
              },
              child: const Text(
                'Incomplete',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
