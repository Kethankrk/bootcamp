import 'dart:convert';

import 'package:bootcamp/custom_widgets/bottom_modal.dart';
import 'package:bootcamp/custom_widgets/todo_item.dart';
import 'package:bootcamp/styling/button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final SharedPreferences pref;
  final titleController = TextEditingController();
  List<dynamic> itemList = [];

  void addItemToList() {
    if (titleController.text.isEmpty) return;
    setState(() {
      itemList.add(titleController.text);
      Navigator.pop(context);
      titleController.clear();
    });
    setToLocalData();
  }

  void deleteItem(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  itemList.removeAt(index);
                });
                setToLocalData();
                Navigator.pop(context);
              },
              child: const Text(
                "Delete",
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Close"),
            )
          ],
          title: const Text("Are your sure?"),
          content: Text("Do you want to delete the todo: ${itemList[index]}"),
        );
      },
    );
  }

  void openModal(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: ctx,
        builder: (BuildContext context) {
          return BottomModal(
            titleController: titleController,
            parentBuildContext: context,
            addItemFunction: addItemToList,
          );
        });
  }

  void setToLocalData() {
    final item = jsonEncode(itemList);
    pref.setString("todo", item);
  }

  void getLocalData() async {
    pref = await SharedPreferences.getInstance();
    final serialized = pref.getString("todo");
    if (serialized != null) {
      setState(() {
        itemList = jsonDecode(serialized);
      });
    }
  }

  @override
  void initState() {
    getLocalData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.black),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                "TODO",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              for (int i = 0; i < itemList.length; i++)
                TodoItem(
                  text: itemList[i],
                  index: i,
                  deleteItemFunction: deleteItem,
                ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: StyledButton(
                              borderRadius: 99.0,
                              color: 0xff759715,
                              padding: 20.0)
                          .customStyle(),
                      onPressed: () {
                        openModal(context);
                      },
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
