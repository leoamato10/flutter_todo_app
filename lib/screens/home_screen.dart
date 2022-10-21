import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final myController = TextEditingController();
  List itemList = [
    {"id": "1", "title": "Todo 1", "isDone": false},
    {"id": "2", "title": "Todo 2", "isDone": true},
    {"id": "3", "title": "Todo 3", "isDone": false}
  ];

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      itemList[index]["isDone"] = !itemList[index]["isDone"];
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Todo App"),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: myController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Type here your new task here...',
                      ),
                    )),
                    TextButton(
                        onPressed: () {
                          Map newTodo = {
                            "id": "4",
                            "title": myController.text,
                            "isDone": false
                          };
                          setState(() {
                            itemList.insert(0, newTodo);
                          });
                        },
                        child: const Text("Add Todo"))
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView.builder(
                  itemCount: itemList.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 25,
                        right: 25,
                      ),
                      child: Slidable(
                        endActionPane: ActionPane(
                          motion: const StretchMotion(),
                          children: [
                            SlidableAction(
                              onPressed: null,
                              icon: Icons.delete,
                              backgroundColor: Colors.red.shade300,
                            )
                          ],
                        ),
                        child: Slidable(
                          endActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: null,
                                icon: Icons.delete,
                                backgroundColor:
                                    Color.fromARGB(255, 255, 53, 53),
                                borderRadius: BorderRadius.circular(12),
                              )
                            ],
                          ),
                          child: CheckboxListTile(
                            secondary: Text("${index + 1}"),
                            title: Text(
                              itemList[index]["title"],
                              style: TextStyle(
                                  decoration: itemList[index]["isDone"]
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none),
                            ),
                            value: itemList[index]["isDone"],
                            onChanged: (value) => checkBoxChanged(value, index),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
