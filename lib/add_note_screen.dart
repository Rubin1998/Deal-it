import 'package:flutter/material.dart';

class AddNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(title: Text("Add Note"),),
      body: Padding(
        padding: const EdgeInsets.all(25.25),
        child: ListView(
          children: [
            TextField(
              //controller: nameController,

              decoration: InputDecoration(
                  // hintStyle: TextStyle(fontSize: 40),
                  labelText: 'Title'),
            ),TextField(
              //controller: nameController,
              maxLines: 10,
              decoration: InputDecoration(
                  labelText: 'Description'),
            ),
            Padding(
              padding: const EdgeInsets.all(100.300),
              child: RaisedButton(onPressed: (){},
              child: Text("Save"),),
            )
          ],

        ),
      ),
    );
  }
}
