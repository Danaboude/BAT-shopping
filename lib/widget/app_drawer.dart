import 'package:flutter/material.dart';
import 'package:project1/providers/auth.dart';
import 'package:project1/screens/about_us.dart';
import 'package:project1/screens/auth_screen.dart';
import 'package:project1/screens/fivorte_screen.dart';
import 'package:project1/screens/settings.dart';
import 'package:provider/provider.dart';

import '../providers/fatchdata.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        final deviceSize = MediaQuery.of(context).size;

    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.only(topRight: Radius.circular(30),bottomRight: Radius.circular(30)),
        child: Drawer(child: Consumer<Auth>(builder: (context, auth, child) {
          if (!auth.authevtivated) {
            return ListView(
              children: [
                ListTile(
                  title: Text('Login'),
                  leading: Icon(Icons.login),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(AuthScreen.routeName);
                  },
                ),
                Divider(),
                ListTile(
                  title: Text('About Us'),
                  leading: Icon(Icons.home),
                  onTap: () => Navigator.of(context).pushNamed(AboutUs.routeName),
                ),
                
                Divider(),
                ListTile(
                  title: Text('Setting'),
                  leading: Icon(Icons.settings),
                  onTap: () => Navigator.of(context).pushNamed(Settings.routeName),
                ),
              ],
            );
          }
          return ListView(
            children: [
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      child: Icon(
                        Icons.account_circle,
                        size: 50,
                        color: Theme.of(context).primaryColor,
                      ),
                      radius: 30,
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(height:deviceSize.height*0.02 ,),
                    Text(auth.user.name),
                    Text(auth.user.email)
                  ],
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Divider(),
              ListTile(
                title: Text('Logout'),
                leading: Icon(Icons.exit_to_app),
                onTap: () {
             
                   Provider.of<Fatchdata>(context, listen: false).fetchAndSetProducts();
                  Navigator.of(context).pop();
                  
                  Provider.of<Auth>(context, listen: false).logout();
                },
              ),
              Divider(),
              ListTile(
                title: Text('About Us'),
                leading: Icon(Icons.home),
                onTap: () {
                  Navigator.of(context).pushNamed(AboutUs.routeName);
                },
              ),
              Divider(),
              ListTile(
                title: Text('Favorite'),
                leading: Icon(Icons.favorite),
                onTap: () => Navigator.of(context).pushNamed(FavoriteScreen.routeName),
              ),
              Divider(),
              ListTile(
                title: Text('Setting'),
                leading: Icon(Icons.settings),
                onTap: () => Navigator.of(context).pushNamed(Settings.routeName),
              ),
            ],
          );
        })),
      ),
    );
  }
}
