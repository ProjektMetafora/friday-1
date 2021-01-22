import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:friday/models/common/cards_list.response.dart';
import 'package:friday/models/common/user.response.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast/utils/value_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'http.client.dart';
import 'firebase_service.dart';

class AppRepository {
  /// Setup Sembast db
  String dbName = 'firday.db';
  DatabaseFactory dbFactory = databaseFactoryIo;
  Database _db;
  SharedPreferences prefs;
  FirebaseService firebaseService = FirebaseService();

  Future<Database> getDb() async {
    if (_db == null) {
      var path = (await getApplicationSupportDirectory()).path + "/" + dbName;
      _db = await dbFactory.openDatabase(path);
    }
    return _db;
  }

  final commonStore = stringMapStoreFactory.store("common_store");
  final keyValue = StoreRef<String, dynamic>.main();

  /// keys
  static const USERKEY = 'loggedInUser';
  static const CARDSKEY = 'cardsList';
  static const BASE_URL = "https://projekt-friday-backend.herokuapp.com";
  static const BASE_URL2 = "https://fridaycard.herokuapp.com";

  static DateTime lastRequestSent = DateTime.now();

  /// Fetches the profile information of the currently loggedIn user from the localStorage
  Future<LoginUserResponse> getLoggedInUser() async {
    final json = await commonStore.record(USERKEY).get(await getDb());
    if (json == null) return null;
    return LoginUserResponse.fromJson(json);
  }

  Future<CardsList> getCardsList() async {
    try {
      var res = await sendGet("/user/get-card", BASE_URL);

      if (res.statusCode == 200) {
        print(res.data);

        CardsList cardsList = CardsList.fromJson(res.data);

        await commonStore.record(CARDSKEY).put(await getDb(), res.data);

        return cardsList;
      } else {
        print("ERROR");
        print(res);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }

    return null;
  }

  Future<void> logoutUser() async {
    await commonStore.record(USERKEY).delete(await getDb());
  }

  /// Header information for Authorization on server
  Future<Map<String, dynamic>> _getHeader() async {
    final user = await getLoggedInUser();
    if (user == null) return {};
    return {'auth': '${user.authToken}'};
  }

  /// Sends a POST request to the given Api path and Body
  Future<dynamic> sendPost(String path, dynamic body, String baseUrl,
      {ProgressCallback sendProgress, int sendTimeout}) async {
    return (await HttpClient.instance.post(
        path, body, await _getHeader(), baseUrl,
        sendProgress: sendProgress, sendTimeout: sendTimeout)); //.data
  }

  /// Sends a PUT request to the given Api path and Body
  Future<dynamic> sendPut(String path, dynamic body, String baseUrl,
      {ProgressCallback sendProgress, int sendTimeout}) async {
    return (await HttpClient.instance.put(
        path, body, await _getHeader(), baseUrl,
        sendProgress: sendProgress, sendTimeout: sendTimeout)); //.data
  }

  /// Sends a GET request to the given Api path
  Future<dynamic> sendGet(String path, String baseUrl,
      {Map<String, dynamic> header}) async {
    return (await HttpClient.instance
        .getRequest(path, header ?? await _getHeader(), baseUrl)); //.data
  }

  /// Helper method to get caught exceptions
  String getErrorMsg(dynamic e) {
    if (e is DioError) {
      final resdData = e.response?.data;
      final errorMessage =
          resdData is Map<String, dynamic> ? resdData['error'] : null;
      if (e.error is SocketException) return "No Internet";
      return errorMessage != null && errorMessage.isNotEmpty
          ? errorMessage
          : (e.message.isNotEmpty ? e.message : "Something went wrong");
    }
    return "Something went wrong";
  }

  Future<bool> isOnBoarded() async {
    if (prefs == null) prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboard') ?? false;
  }

  Future<bool> onBoard() async {
    if (prefs == null) prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboard', true);
    return prefs.getBool('onboard') ?? false;
  }

  Future<bool> setCardLimit(int newLimit) async {

    print('Time DIff: ${lastRequestSent.difference(DateTime.now()).inSeconds.abs()}');

    if (lastRequestSent.difference(DateTime.now()).inSeconds.abs() <= 4) {
      print('debouncing request');
      return false;
    }

    lastRequestSent = DateTime.now();

    try {
      print('sending request');
      final res = await sendPut("/user/limit/$newLimit", "", BASE_URL);

      if (res.statusCode == 200) {

        print(res.data);

        var dbUser =
            cloneMap(await commonStore.record(USERKEY).get(await getDb()));
        dbUser['user_details']['limit'] = res.data['limit'];

        await commonStore.record(USERKEY).put(await getDb(), dbUser);

        return true;
      }

      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addKYC(Map<String, dynamic> form) async {
    try {
      final body = form;
      final res = await sendPost("/user/kyc", body, BASE_URL);

      if (res.statusCode == 200) {
        print(res.data);

        return true;
      }

      return false;
    } catch (e) {
      print(e);

      return false;
    }
  }

  Future<bool> setVCardStatus(bool status) async {
    final user = await getLoggedInUser();
    print(user.authToken);
    try {
      String queryString =
          Uri(queryParameters: {"activate": status.toString()}).query;

      print(queryString);

      final res =
          await sendPut("/user/vcard/change-status?$queryString", "", BASE_URL);

      if (res.statusCode == 200) {
        print(res.data);

        var dbUser = cloneMap(await commonStore.record(USERKEY).get(await getDb()));
        dbUser['user_details']['vcard_status'] = res.data['vcard_status'];

        await commonStore.record(USERKEY).put(await getDb(), dbUser);
        return true;
      }

      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> signUp(Map<String, dynamic> form) async {
    try {
      var str = "${form['email']}:${form['password']}|0000";
      var bytes = utf8.encode(str);
      var base64Str = base64.encode(bytes);
      print(base64Str);

      final Map<String, dynamic> body = {
        "firstname": form['name'],
        "image": "",
        "lastname": "",
        "email": form['email'],
        "country_code": "+91",
        "mob": form['phone'],
        "kyc_status": false,
        "active": true
      };

      final res = await sendPost('/register/$base64Str', body, BASE_URL);
      if (res.statusCode == 200) return true;
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addCard(Map<String, dynamic> form) async {
    try {
      final Map<String, dynamic> body = {
        "card_number": form["card_number"],
        "name_on_card": form["name_on_card"],
        "card_type": form["card_type"],
        "expiration_month": form["expiration_month"],
        "expiration_year": "20"+form["expiration_year"],
        "security_code": form["security_code"]
      };

      print(body);

      final res = await sendPost("/add-card", body, BASE_URL2);

      if (res.statusCode == 200) {
        print(res.data);
        return true;
      }

      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> setDefaultCard(int index) async {
    try {
      final res = await sendPut("/change-default?index=$index", "", BASE_URL2);

      if (res.statusCode == 200) {
        print(res.data);

        return true;
      };

      return false;

    } catch (e) {
      print(e);

      return false;
    }
  }

  Future<LoginUserResponse> login(Map<String, dynamic> form) async {
    try {
      print(form['email']);
      print(form['password']);

      var str = "${form['email']}:${form['password']}";
      var bytes = utf8.encode(str);
      final String token = base64.encode(bytes);
      // final String token = 'c2F1cmF2QGdtYWlsLmNvbTpwYXNz';
      print(token);

      Map<String, dynamic> header = {
        'auth': token.toString(),
        'Content-Type': 'application/json'
      };

      final res = await sendGet('/login', BASE_URL, header: header);
      print(res);
      if (res.statusCode == 200) {
        print(res.data['vcard']);
        await commonStore.record(USERKEY).put(await getDb(), res.data);
        final userLogin = LoginUserResponse.fromJson(res.data);
        return userLogin;
      } else {
        return null;
      }

      // return false;
    } catch (e) {
      print(e);
      return null;
      // return false;
    }
  }

  Future<User> signInWIthGoogle() async =>
      await firebaseService.signInWithGoogle();
}
