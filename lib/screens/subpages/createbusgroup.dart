import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapp/models/user.dart';
import 'package:tapp/services/database.dart';
import 'package:tapp/shared/constants.dart';

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({Key? key}) : super(key: key);

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  final _formKey = GlobalKey<FormState>();
  String groupName = '';
  @override
  Widget build(BuildContext context) {
    User1 user = Provider.of<User1>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Create your Group',
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 255, 128, 0),
          elevation: 0,
          // give the app bar rounded corners
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.only(
          //     bottomLeft: Radius.circular(20.0),
          //     bottomRight: Radius.circular(20.0),
          //   ),
          // ),
          // leading: Icon(
          //   Icons.menu,
          // ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
          child: Column(
            children: <Widget>[
              // construct the profile details widget here
              TextFormField(
                    decoration: textInputDecoration.copyWith(labelText: 'Group Name'),
                    validator: (val) => val!.isEmpty ? 'Enter a group name' : null,
                    onChanged: (val) {
                      setState(() => groupName = val);
                    },
                  ),
              const SizedBox(height: 20.0),
              const Text('Add Route', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              // the tab bar with two items
              SizedBox(
                height: 50,
                child: AppBar(
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        icon: Icon(Icons.mode_rounded),
                      ),
                      Tab(
                        icon: Icon(
                          Icons.favorite_border_outlined,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // create widgets for each tab bar here
              Expanded(
                child: TabBarView(
                  children: [
                    // first tab bar view widget
                    Container(
                       color: Colors.red,
                      child: Center(
                        child: Text(
                          'Bike',
                        ),
                      ),
                    ),

                    // second tab bar viiew widget
                    Container(
                       color: Colors.pink,
                      child: Center(
                        child: Text(
                          'Car',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );



    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Create Group'),
    //     backgroundColor: const Color.fromARGB(255, 255, 128, 0),
    //   ),
    //   body: Container(
    //     padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
    //     child: Form(
    //       key: _formKey,
    //       child: Column(
    //         children: <Widget>[
              // TextFormField(
              //     decoration: textInputDecoration.copyWith(labelText: 'Group Name'),
              //     validator: (val) => val!.isEmpty ? 'Enter a group name' : null,
              //     onChanged: (val) {
              //       setState(() => groupName = val);
              //     },
              //   ),
    //           SizedBox(height: 20.0),
    //           Align(
    //             alignment: Alignment.centerLeft,
    //             child: Text(
    //               'Add Route',
    //               style: TextStyle(
    //                 fontSize: 20.0,
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //           ),
    //           SizedBox(height: 20.0),
    //           ElevatedButton(
    //             onPressed: () async {
    //             },
    //             child: const Text('Write'),
    //           ),
    //           SizedBox(height: 20.0),
    //           ElevatedButton(
    //             style:ElevatedButton.styleFrom(
    //               primary: Colors.brown[400],
    //               padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
    //             ),
    //             child: Text(
    //               'Create Group',
    //               style: TextStyle(color: Colors.white),
    //             ),
    //             onPressed: () async {
    //               if (_formKey.currentState!.validate()) {
    //                 await DatabaseService(uid: user.uid).createGroup(groupName);
    //                 Navigator.pop(context);
    //               }
    //             },
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
      
    // );
    
  }
}