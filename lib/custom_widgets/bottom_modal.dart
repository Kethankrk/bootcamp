import 'package:bootcamp/styling/button.dart';
import 'package:flutter/material.dart';

class BottomModal extends StatelessWidget {
  const BottomModal({
    super.key,
    required this.titleController,
    required this.parentBuildContext,
    required this.addItemFunction,
  });

  final TextEditingController titleController;
  final BuildContext parentBuildContext;
  final void Function() addItemFunction;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(parentBuildContext);

    return Container(
      decoration: const BoxDecoration(color: Color(0xff282828)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Padding(
        padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "ADD TODO",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: titleController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                label: Text("Title"),
                hintText: "Enter your todo title here...",
                hintStyle: TextStyle(
                  color: Color(0xff808080),
                ),
                labelStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: StyledButton(
                          borderRadius: 10.0, color: 0xff759715, padding: 5.0)
                      .customStyle(),
                  onPressed: addItemFunction,
                  child: const Text("ADD"),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  style: StyledButton(
                          borderRadius: 10.0, color: 0xffBD3636, padding: 5.0)
                      .customStyle(),
                  onPressed: () {
                    Navigator.pop(context);
                    titleController.clear();
                  },
                  child: const Text("Cancel"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
