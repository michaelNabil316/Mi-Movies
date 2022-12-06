import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/sqlLite_helper/sqflite_helper.dart';
import 'states.dart';

class SingingCubit extends Cubit<SigningStates> {
  SingingCubit() : super(AppInitialState());
  static SingingCubit get(context) => BlocProvider.of(context);

  SqlLiteHelper dbHelper = SqlLiteHelper();
  bool isLoading = false;

  void createDB() async {
    emit(CreateDBLoadingState());
    await dbHelper.createDataBase();
  }

  void createNewUser({required String userEmail, required String password}) {
    emit(CreateUserLoadingState());
    dbHelper.insertNewUser(userEmail, password).then((value) {
      if (value == 'error') {
        emit(CreateUserErrorState());
      } else {
        emit(CreateUserSuccessgState());
      }
    }).catchError((error) {
      emit(CreateUserErrorState());
    });
  }

  void login({required String name, required String password}) {
    isLoading = true;
    emit(LoginLoadingState());
    dbHelper.sqlLiteLogin(name.trim(), password).then((value) {
      log("value: $value");
      isLoading = false;
      if (value.isEmpty) {
        emit(LoginErrorState(error: "This account Not Exist"));
        return;
      }
      if (value[0]['userId'] != null) {
        if (value[0]['password'] != password) {
          emit(LoginErrorState(error: "User Name or password is incorrect "));
        } else {
          emit(LoginSuccessgState());
        }
      }
    }).catchError((error) {
      isLoading = false;
      emit(LoginLoadingState());
    });
  }
}
