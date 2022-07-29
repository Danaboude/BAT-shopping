
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:project1/http_exception.dart';
import 'package:project1/providers/dio.dart';
import 'package:project1/providers/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  // final String _url = "http://10.0.2.2:8000/api/";
  late UserWithtoken _userWithtoken;
  bool _isloggedIn = false;
  late User _user;
  late String _token = '';
  String get token => _token;
  bool get authevtivated => _isloggedIn;
  User get user => _user;
  void readuserwithtoken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _user = User(
        name: prefs.getString('name') ?? '',
        email: prefs.getString('email') ?? '',
        address: prefs.getString('address')??'',
        phone: prefs.getString('phone') ?? '',
        id: prefs.getInt('id') ?? 0);

    _userWithtoken =
        UserWithtoken(user: _user, token: prefs.getString('token') ?? '');

   // print(_userWithtoken);
    if (_userWithtoken.token != '') {
      _token = _userWithtoken.token;
      _isloggedIn = true;
    } else
      _isloggedIn = false;
  }

  Future<void> register(Map cards) async {
    Dio.Response response = await dio().post(
      '/register',
      data: cards,
      options: Dio.Options(validateStatus: (status) => true),
    );

    try {
      if (response.data['message'] != null) {
        print(response.data['message'].toString());
        throw HttpException(response.data['message']);
      } else {
        this._userWithtoken = UserWithtoken.fromJson(response.data);
        this.store(_userWithtoken);
        this._user = _userWithtoken.user;
        this._token = _userWithtoken.token;

        _isloggedIn = true;
        
      }
      notifyListeners();
    } catch (e) {
      throw HttpException(e.toString());
    }
  }

  Future<void> login(Map cards) async {
   

    try {
       Dio.Response response = await dio().post(
      '/login',
      data: cards,
      options: Dio.Options(validateStatus: (status) => true),
    );

    if (response.data['message'] != null) {
      print(response.data['message'].toString());
      throw HttpException(response.data['message']);
    } else {
      //  throw HttpException(response.data['message']);
      this._userWithtoken = UserWithtoken.fromJson(response.data);
      this.store(_userWithtoken);
      this._user = _userWithtoken.user;
      this._token = _userWithtoken.token;

      _isloggedIn = true;
      print(_token);

      notifyListeners();
    }
    } catch (e) {
      throw HttpException(e.toString());
    }
  }

  void logout() async {
   //print(_token);
    Dio.Response response = await dio().post('/logout',
          options: Dio.Options(headers: {'Authorization': 'Bearer $_token'}));
     print(response.data.toString());
      cleanUp();
      
      notifyListeners();
    try {
     
    } catch (e) {
      print(e);
    }
  }

  void cleanUp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('itemscart');
    this._user = User(name: '', email: '', address: '', id: null, phone: '');
    this._isloggedIn = false;
    this._token = '';
    await prefs.clear() ;
  }

  void store(UserWithtoken userWithtoken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', userWithtoken.token);
    prefs.setString('name', userWithtoken.user.name);
    prefs.setString('email', userWithtoken.user.email);
    prefs.setString('phone', userWithtoken.user.phone);
    prefs.setString('address', userWithtoken.user.address);
    prefs.setInt('id', userWithtoken.user.id!);
  }
}
