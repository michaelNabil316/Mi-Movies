abstract class SigningStates {}

class AppInitialState extends SigningStates {}

class CreateDBLoadingState extends SigningStates {}

class CreateUserLoadingState extends SigningStates {}

class CreateUserSuccessgState extends SigningStates {}

class CreateUserErrorState extends SigningStates {}

class LoginLoadingState extends SigningStates {}

class LoginSuccessgState extends SigningStates {}

class LoginErrorState extends SigningStates {
  final String error;
  LoginErrorState({required this.error});
}
