import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoItem extends StatelessWidget {
  List itemList;
  Function changeTodoState;

  TodoItem(this.itemList, this.changeTodoState);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                    backgroundColor: const Color.fromARGB(255, 255, 53, 53),
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
                onChanged: (value) => changeTodoState(value, index),
              ),
            ),
          ),
        );
      },
    );
  }
}
