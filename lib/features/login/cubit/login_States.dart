abstract class LoginStates {}
class IntialState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSuccessSate extends LoginStates{}
class LoginErrorState extends LoginStates{
  final String errorMessage;
  LoginErrorState({required this.errorMessage});
}