import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

var titleRunesMessage = Runes('\u6211' + '\u7684' +'\u6700' + '\u611B');

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(String.fromCharCodes(titleRunesMessage)),
      ),
      body: Center(
        child: Text('Create your favorite bus'),
      ),
    );
    
  }
}