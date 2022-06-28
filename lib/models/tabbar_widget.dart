import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class TabBarWidget extends StatelessWidget {

  final String searchtext;
  final List<Tab> tabs;
  final List<Widget> children;
  // final searchText =  utf8.decode([516C, 8ECA]);


  TabBarWidget({
    Key? key,
    required this.searchtext,
    required this.tabs,
    required this.children,
  });
  

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)
              ),
              child: Center(
                child: TextField(
                  decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            /* Clear the search field */
                          },
                        ),
                        hintText: searchtext,
                        border: InputBorder.none
                      ),
                ),
              ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: Color.fromARGB(255, 255, 0, 0),
              ),
              onPressed: (){
                print('klikniete');
              },
            ),
          ],

            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.blue],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
              ),
            ),
            // bottom: TabBar(
            //   isScrollable: true,
            //   indicatorColor: Colors.white,
            //   indicatorWeight: 5,
            //   tabs: tabs,
            // ),

          ),
          body: TabBarView(children: children),
        ),
      );
}