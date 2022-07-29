// ignore_for_file: deprecated_member_use

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:project1/providers/fatchdata.dart';
import 'package:project1/providers/auth.dart';
import 'package:project1/screens/product_overview_screen.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deciceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              decoration:
                  BoxDecoration(boxShadow: [BoxShadow(color: Colors.white12)]),
              height: deciceSize.height,
              width: deciceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                      child: SizedBox(
                    height: deciceSize.height * 0.0,
                  )),
                  Flexible(
                      child: Image.asset(
                    'images/logo.png',
                    height: deciceSize.height * 0.65,
                    width: deciceSize.width * 0.9,
                  )),
                  Flexible(
                    child: AuthCard(),
                    flex: deciceSize.width > 600 ? 2 : 4,
                  )
                ],
              ),
            ),
          ),
         
               Container(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    color: Colors.black,
                    onPressed: () => Navigator.of(context)
                        .pushNamed(ProductOverviewScreen.routeName),
                  ),
                )
             
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  @override
  State<AuthCard> createState() => _AuthCardState();
}

enum AuthMode { Login, SignUp }

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();

  final _phoneController = TextEditingController();

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAimaton;
  @override
  void initState() {
    super.initState();
    _emailController.text = 'esmaeelshali1999210@gmail.com';
    _passwordController.text = '123456789';
    // getDeviceName();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -0.15),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
    _opacityAimaton = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));
  }

  /*
  void getDeviceName() async {
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        _deviceName = androidInfo.model;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        _deviceName = iosInfo.utsname.machine;
      }
    } catch (e) {
      print(e);
    }
  }
 */

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<void> submit() async {
    Map creds = {
      'email': _emailController.text,
      'password': _passwordController.text,
    };
    try {
      if (_formKey.currentState!.validate()) {
        await Provider.of<Auth>(context, listen: false).login(creds);
        
         Provider.of<Fatchdata>(context, listen: false).fetchAndSetProducts();


        Navigator.of(context).pop();
      }
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  Future<void> register() async {
    var dataregister = {
      'email': _emailController.text,
      'name': _nameController.text,
      'password': _passwordController.text,
      'password_confirmation': _passwordController.text,
      'address': _addressController.text,
      //'device_name': _deviceName ?? 'unknown',
      'phone': _phoneController.text
    };
    try {
      if (_formKey.currentState!.validate()) {
        await Provider.of<Auth>(context, listen: false).register(dataregister);
         
         Provider.of<Fatchdata>(context, listen: false).fetchAndSetProducts();
        Navigator.of(context).pop();
      }
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.SignUp;
      });
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deciceSize = MediaQuery.of(context).size;
    // String token=Provider.of<Auth>(context).token;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        height: _authMode == AuthMode.SignUp
            ? deciceSize.height * 0.7
            : deciceSize.height * 0.37,
        constraints: BoxConstraints(
          minHeight: _authMode == AuthMode.SignUp
              ? deciceSize.height * 0.7
              : deciceSize.height * 0.37,
        ),
        width: deciceSize.width * 0.75,
        padding: EdgeInsets.all(16),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
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
                    minHeight: _authMode == AuthMode.SignUp ? 60 : 0,
                    maxHeight: _authMode == AuthMode.SignUp ? 120 : 0,
                  ),
                  child: FadeTransition(
                    opacity: _opacityAimaton,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: TextFormField(
                        enabled: _authMode == AuthMode.SignUp,
                        decoration: const InputDecoration(labelText: 'name'),
                        controller: _nameController,
                        // obscureText: true,
                        validator: _authMode == AuthMode.SignUp
                            ? (val) {
                                if (val == '') return 'set You\'r name';
                                return null;
                              }
                            : null,
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
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
                    minHeight: _authMode == AuthMode.SignUp ? 60 : 0,
                    maxHeight: _authMode == AuthMode.SignUp ? 120 : 0,
                  ),
                  child: FadeTransition(
                    opacity: _opacityAimaton,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: TextFormField(
                        enabled: _authMode == AuthMode.SignUp,
                        decoration: const InputDecoration(
                            labelText: 'Confirm Password'),
                        obscureText: true,
                        validator: _authMode == AuthMode.SignUp
                            ? (val) {
                                if (val != _passwordController.text)
                                  return 'Password do not match!';
                                return null;
                              }
                            : null,
                      ),
                    ),
                  ),
                ),
                AnimatedContainer(
                  curve: Curves.easeIn,
                  duration: Duration(milliseconds: 300),
                  constraints: BoxConstraints(
                    minHeight: _authMode == AuthMode.SignUp ? 60 : 0,
                    maxHeight: _authMode == AuthMode.SignUp ? 120 : 0,
                  ),
                  child: FadeTransition(
                    opacity: _opacityAimaton,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _phoneController,
                        enabled: _authMode == AuthMode.SignUp,
                        decoration: InputDecoration(labelText: 'Phone'),
                        //obscureText: true,
                        validator: _authMode == AuthMode.SignUp
                            ? (val) {
                                if (val == '')
                                  return 'Enter you\'r Namber ';
                                else if (val!.length < 10)
                                  return 'phone Number should be 10 number ';
                                return null;
                              }
                            : null,
                      ),
                    ),
                  ),
                ),
                AnimatedContainer(
                  curve: Curves.easeIn,
                  duration: Duration(milliseconds: 300),
                  constraints: BoxConstraints(
                    minHeight: _authMode == AuthMode.SignUp ? 60 : 0,
                    maxHeight: _authMode == AuthMode.SignUp ? 120 : 0,
                  ),
                  child: FadeTransition(
                    opacity: _opacityAimaton,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: TextFormField(
                        keyboardType: TextInputType.streetAddress,
                        controller: _addressController,
                        enabled: _authMode == AuthMode.SignUp,
                        decoration: InputDecoration(labelText: 'Address'),
                        //obscureText: true,
                        validator: _authMode == AuthMode.SignUp
                            ? (val) {
                                if (val == '') return 'Enter you\'r Address ';
                                return null;
                              }
                            : null,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading) CircularProgressIndicator(),
                RaisedButton(
                  child: Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGNUP'),
                  onPressed: _authMode == AuthMode.Login ? submit : register,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ),
                FlatButton(
                  onPressed: _switchAuthMode,
                  child: Text(
                    _authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN',
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 4),
                  //color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
          key: _formKey,
        ),
      ),
    );
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('An Error Occurred'),
              content: Text(errorMessage.toString()),
              actions: [
                FlatButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('OK'),
                )
              ],
            ));
  }
}
