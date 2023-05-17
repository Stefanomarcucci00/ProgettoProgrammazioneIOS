
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progetto_programmazione_ios/theme/widgets.dart';

class PageProfilo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(pageName: 'Profilo', backArrow: true,),
    );
  }

}