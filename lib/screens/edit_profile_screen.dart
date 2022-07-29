// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:project1/providers/user.dart';
import 'package:project1/screens/product_overview_screen.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/EditProduct';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen>
    with SingleTickerProviderStateMixin {
  bool showPassword = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();

  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
        User user=Provider.of<Auth>(context).user;
       

    var deciceSize = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
            //   margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              color: Colors.black,
              onPressed: () => Navigator.of(context)
                  .pushNamed(ProductOverviewScreen.routeName),
            ),
          ), 
            SizedBox(
              height: deciceSize.height * 0.001,
            ),
            CircleAvatar(
              radius:40,
              backgroundColor: Colors.black,
            ),
            Form(
              key: _formKey,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                    height: deciceSize.height * 0.6,
                    constraints: BoxConstraints(
                      minHeight: deciceSize.height * 0.6,
                    ),
                    width: deciceSize.width * 0.75,
                    padding: EdgeInsets.all(16),
                    child: Form(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController..text=user.email,
                              decoration: InputDecoration(

                                labelText: 'E-mail',
                                fillColor: Theme.of(context).primaryColor,
                                filled: false,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (val) {
                                if (val!.isEmpty || !val.contains('@'))
                                  return 'Invalid Email';
                                return null;
                              },
                              onSaved: (val) {
                                _authData['email'] = val!;
                              },
                            ),
                            AnimatedContainer(
                              curve: Curves.easeIn,
                              duration: Duration(milliseconds: 300),
                              constraints: BoxConstraints(
                                minHeight: 60,
                                maxHeight: 120,
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(labelText: 'name'),
                                controller: _nameController..text=user.name,
                                // obscureText: true,
                                validator: (val) {
                                  if (val == '') return 'set You\'r name';
                                  return null;
                                },
                              ),
                            ),
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Password'),
                              obscureText: true,
                              controller: _passwordController,
                              validator: (val) {
                                if (val!.isEmpty || val.length < 5)
                                  return 'Password is too short!';
                                return null;
                              },
                              onSaved: (val) {
                                _authData['password'] = val!;
                              },
                            ),
                            AnimatedContainer(
                              curve: Curves.easeIn,
                              duration: Duration(milliseconds: 300),
                              constraints: BoxConstraints(
                                minHeight: 60,
                                maxHeight: 120,
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Confirm Password'),
                                obscureText: true,
                                validator: (val) {
                                  if (val != _passwordController.text)
                                    return 'Password do not match!';
                                  return null;
                                },
                              ),
                            ),
                            AnimatedContainer(
                              curve: Curves.easeIn,
                              duration: Duration(milliseconds: 300),
                              constraints: BoxConstraints(
                                minHeight: 60,
                                maxHeight: 120,
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: _phoneController..text=user.phone,

                                decoration: InputDecoration(labelText: 'Phone'),
                                //obscureText: true,
                                validator: (val) {
                                  if (val == '')
                                    return 'Enter you\'r Namber ';
                                  else if (val!.length < 10)
                                    return 'phone Number should be 10 number ';
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            if (_isLoading) CircularProgressIndicator(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RaisedButton(
                                  child: Text('Send'),
                                  onPressed: () => {},
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 8),
                                  color: Theme.of(context).primaryColor,
                                  textColor: Colors.white,
                                ),
                                RaisedButton(
                                  child: Text('Cancel'),
                                  onPressed: () => Navigator.of(context).pop(),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 8),
                                  color: Theme.of(context).primaryColor,
                                  textColor: Colors.white,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
