import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:werecycle/utils/dialogs.dart';
import 'package:werecycle/views/home.screen.dart';
import 'package:werecycle/views/pickup.screen.dart';
import 'package:werecycle/views/profile.screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController;
  int _page = 1;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Dialogs().showExitDialog(context),
      child: Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: <Widget>[
            PickupScreen(),
            // NotificationsScreen(),
            HomeScreen(),
            ProfileScreen(),
          ],
        ),

        // MultiProvider(
        //   providers: [
        //     ChangeNotifierProvider(create: (context) => Categories()),
        //     ChangeNotifierProvider(create: (context) => OrderProvider()),
        //     ChangeNotifierProvider(create: (context) => UserProvider()),
        //   ],
        //   child: PageView(
        //     physics: NeverScrollableScrollPhysics(),
        //     controller: _pageController,
        //     onPageChanged: onPageChanged,
        //     children: <Widget>[
        //       HomeScreen(region: widget.region),
        //       OrdersScreen(),
        //       ProfileScreen(),
        //     ],
        //   ),
        // ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.grey[350],
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Feather.message_circle),
              title: Text('Alert'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Feather.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Feather.user),
              title: Text('Profile'),
            ),
          ],
          onTap: navigationTapped,
          currentIndex: _page,
        ),
      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _page);
    _getPermission();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  Future<void> _getPermission() async {
    final location = Location();
    final hasPermissions = await location.hasPermission();
    if (hasPermissions != PermissionStatus.granted) {
      await location.requestPermission();
    }
  }
}
