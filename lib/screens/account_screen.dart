
import 'package:flutter/material.dart';
import 'package:project1/providers/auth.dart';
import 'package:project1/providers/user.dart';
import 'package:project1/screens/auth_screen.dart';
import 'package:project1/screens/edit_profile_screen.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = '/account';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    User user=Provider.of<Auth>(context).user;
    return  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Center(
                       child: CircleAvatar(
                          child: Icon(
                            Icons.account_circle,
                            size: 90,
                            color: Theme.of(context).primaryColor,
                          ),
                          radius:30,
                          backgroundColor: Colors.white,
                        ),
                     ),
                     SizedBox(width: deviceSize.width*0.07,)
                   ],
                 ),
                
                
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: deviceSize.height * 0.05,
                      ),
                      Text(
                        user.email,
                        style:
                            TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: deviceSize.height * 0.002,
                      ),
                      Text(
                        user.name,
                        style:
                            TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: deviceSize.height * 0.08,
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    
                    height: deviceSize.height * 0.08,
                    width: deviceSize.width * 0.12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xffa2dbd3),
                    ),
                    child: Icon(
                      Icons.edit,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: deviceSize.width * 0.01
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: deviceSize.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                         const Text(
                            'Edit Profile',
                            style: TextStyle(fontSize: 20),
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
          ,SizedBox(
              height: deviceSize.height * 0.02,
            ),
            GestureDetector(
              onTap: () {
                Provider.of<Auth>(context, listen: false).logout();
                Navigator.of(context).pushNamed(AuthScreen.routeName);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: deviceSize.height * 0.08,
                    width: deviceSize.width * 0.12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xffa2dbd3),
                    ),
                    child: Icon(
                      Icons.logout,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: deviceSize.width * 0.1,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: deviceSize.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                         const Text(
                            'Logout',
                            style: TextStyle(fontSize: 20),
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
          ]);
    
  }
}
