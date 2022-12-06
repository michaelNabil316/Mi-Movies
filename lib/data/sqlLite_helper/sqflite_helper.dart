import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import '../../shared/cashHelper/chash_helper.dart';

class SqlLiteHelper {
  late Database database;

  //create database
  Future createDataBase() async {
    //create the branches table
    database = await openDatabase('authenticationSystem.db', version: 1,
        onCreate: (database, version) {
      database
          .execute('CREATE TABLE branches (id INTEGER PRIMARY KEY, name TEXT)')
          .then((value) => log('table created'))
          .catchError((onError) =>
              {print('error in create table: ${onError.toString()}')});
    }, onOpen: (database) {});
    //create table for users
    await database.execute(
        'CREATE TABLE IF NOT EXISTS users ( userId INTEGER PRIMARY KEY, userName TEXT , password TEXT)');

    // insert in database for the first time only
    if (CashHelper.getData(key: 'isInsertBefore') == null) {
      //insert branches
      CashHelper.saveData(key: 'isInsertBefore', value: true);
    }
  }

//insert new user into the database
  Future insertNewUser(String userName, String password) async {
    userName = userName.trim();
    var guest = await database
        .rawQuery("SELECT * FROM users WHERE userName = '$userName'");

    if (guest.isEmpty) {
      await database.transaction((txn) async {
        txn.rawInsert(
            'INSERT INTO users (userName, password) VALUES ("$userName" , "$password")');
      });
    } else {
      return 'error';
    }
  }

//get user data
  Future<List<Map<String, dynamic>>> sqlLiteLogin(
          String userName, String password) async =>
      await database
          .rawQuery(
              "SELECT userId, password FROM users WHERE userName = '${userName.trim()}'")
          .then((value) {
        return value;
      }).catchError((error) {
        return error;
      });
}
