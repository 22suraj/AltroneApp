import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mydrive/AddFeature/AddScreen.dart';
import 'package:mydrive/FilesFeature/FIlesDashboard.dart';
import 'package:mydrive/Helper/CustomColors.dart';
import 'package:mydrive/LibraryFeature/LibraryDashboard.dart';
import 'package:mydrive/ProfileFeature/ProfileScreen.dart';
import 'package:mydrive/RecentFeature/RecentScreen.dart';
import 'package:mydrive/SearchFeature/SearchScreen.dart';
import 'package:mydrive/SharedFeature/SharedDashboard.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _bottomnavigatorbarindex = 2;

  Widget getBodyContent(int index) {
    if (index == 0) {
      return AddScreen();
    } else if (index == 1) {
      return LibraryDashboard();
    } else if (index == 2) {
      return RecentScreen();
    } else if (index == 3) {
      return SharedDashboard();
    } else if (index == 4) {
      return FileDashboard();
    } else if (index == 5) {
      return ProfileScreen();
    } else {
      return SearchScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.09),
        child: AppBar(
            elevation: 10,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.account_circle_rounded,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                setState(() {
                  _bottomnavigatorbarindex = 5;
                });
              },
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  setState(() {
                    _bottomnavigatorbarindex = 6;
                  });
                },
              ),
            ],
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    )
                  ],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(width * 0.05),
                    bottomRight: Radius.circular(width * 0.05),
                  ),
                  gradient: CustomColors().greencolorlineargradient),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(width * 0.06),
              ),
            ),
            title: Image.asset(
              "assets/llogo.png",
              height: height * 0.15,
            )),
      ),
      body: getBodyContent(_bottomnavigatorbarindex),
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: Theme.of(context).primaryColor,
          selectedItemBorderColor: Colors.blue.shade100,
          selectedItemBackgroundColor: Colors.blue.shade600,
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Theme.of(context).accentColor,
        ),
        selectedIndex: _bottomnavigatorbarindex,
        onSelectTab: (index) {
          setState(() {
            _bottomnavigatorbarindex = index;
          });
        },
        items: [
          FFNavigationBarItem(
            iconData: Icons.add,
            label: 'Add',
          ),
          FFNavigationBarItem(
            iconData: Icons.library_books,
            label: 'Library',
          ),
          FFNavigationBarItem(
            iconData: Icons.timelapse_rounded,
            label: 'Recent',
          ),
          FFNavigationBarItem(
            iconData: Icons.people,
            label: 'Shared',
          ),
          FFNavigationBarItem(
            iconData: Icons.file_present,
            label: 'Files',
          ),
        ],
      ),
    );
  }
}
