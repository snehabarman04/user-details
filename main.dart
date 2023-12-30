import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

//my understanding of the basic functioning of this app
//When the app starts, the HomePage is on the stack

//When we press the ‘Show Details’ button, the DetailsPage
//is pushed onto the stack. Now the stack looks like this: [HomePage, DetailsPage]

//The DetailsPage is at the top of the stack and is the screen currently being displayed

//When we press the back button, the DetailsPage is popped from the stack
//and the HomePage becomes the top of the stack and is displayed.

//When the AlertDialog is shown, we are like pushing it onto the stack: [HomePage, AlertDialog]

//The AlertDialog is at the top of the stack and is the popup currently being displayed

//When you press ‘OK’ in the AlertDialog, the AlertDialog is popped from the stack
//and the HomePage becomes the top of the stack and is displayed again

class HomePage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController rollNoController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name')),
            TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email')),
            TextField(
                controller: rollNoController,
                decoration: InputDecoration(labelText: 'Roll No')),
            TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone Number')),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              child: Text('Show Details'),
              onPressed: () {
                Navigator.push(
                  context,
                  //context is a reference to the location of a widget within
                  //the widget tree
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(
                      //this is telling that the context here, that is, the
                      //destination route is the DetailsPage
                      name: nameController.text,
                      email: emailController.text,
                      rollNo: rollNoController.text,
                      phone: phoneController.text,
                    ),
                  ),
                ).then((_) {
                  //the .then() comes into action only when the Future returned
                  //by the Navigator.push() is fulfilled, thatis when the page is popped
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Confirm Log Out'),
                        content: Text('User ${nameController.text} Logged out'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Log Out'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              //This is a method that takes a BuildContext and returns
                              //the NavigatorState most closely associated with that context.

                              //it is like saying ki find the Navigator for the current context
                              //and remove the top-most route from its stack

                              //This pop is used to close the AlertDialog
                            },
                          ),
                        ],
                      );
                    },
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final String name;
  final String email;
  final String rollNo;
  final String phone;

  DetailsPage(
      {required this.name,
      required this.email,
      required this.rollNo,
      required this.phone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Text('Name: $name'),
            Text('Email: $email'),
            Text('Roll No: $rollNo'),
            Text('Phone: $phone'),
          ],
        ),
      ),
    );
  }
}
