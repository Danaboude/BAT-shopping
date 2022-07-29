import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';
import 'package:project1/screens/product_overview_screen.dart';

class AboutUs extends StatelessWidget {
  static const routeName = '/about_us';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Container(
            //   margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              color: Colors.black,
              onPressed: () => Navigator.of(context)
                  .pushReplacementNamed(ProductOverviewScreen.routeName),
            ),
          ),
            ContactUs(
                cardColor: Colors.white,
                textColor: Colors.teal.shade900,
        
                email: 'aboudedan@gmail.com',
                companyName: 'BAT',
                companyColor:Theme.of(context).primaryColor,
                dividerThickness: 2,
                phoneNumber: '+963935570304',
               // website: 'https://abhishekdoshi.godaddysites.com',
                githubUserName: 'abdalkreem2000-1',
                tagLine: 'Rami',
                taglineColor: Colors.teal.shade100,
                //twitterHandle: 'AbhishekDoshi26',
                //instagram: '_abhishek_doshi',
                facebookHandle: 'BAT198P/'),
          ],
        ),
      );
  }
}