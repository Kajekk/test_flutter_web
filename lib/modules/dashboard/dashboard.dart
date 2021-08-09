import 'package:flutter/material.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';

class Dashboard extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideMenu(),
      body: Container(
        // constraints: BoxConstraints(maxWidth: maxWidth),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(),
              ),
            Expanded(
                flex: 5,
                child: SafeArea(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Column(
                        children: [
                          Header(scaffoldKey: _scaffoldKey, title: 'Support Management',),
                          SizedBox(
                            height: defaultPadding,
                          ),
                        ],
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
