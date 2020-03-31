import 'package:flutter/material.dart';

import '../../widget/my_app_bar_view.dart';

class DiscoverPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new DiscoverPageState();
  }
}

class DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: MyAppBarView(
        title: '发现',
        leftVisible: false,
      ),
      body: Text('发现'),
    );
  }
}
