import 'package:bootcamp_task/features/login/cubit/login_States.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit(this.dio):super(IntialState());
 final Dio dio;

 Future<void> login({required String username, required String password}) async{
  emit(LoginLoadingState());
  try{
  final response = await dio.post(
    'https://dummyjson.com/auth/login',
    data: {
      'username': username,
      'password': password,
    },
    options: Options(
      headers: { 'Content-Type': 'application/json' },
    ),
  );
  if (response.statusCode == 200) {
        final accessToken = response.data['accessToken']; 
        if (accessToken != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('accessToken', accessToken);
          emit(LoginSuccessSate());
        } else {
          emit(LoginErrorState(errorMessage: 'Access token not found in response'));
        }
      } else {
        String errorMessage = 'Unexpected status code: ${response.statusCode}';
        if (response.data is Map && response.data['message'] != null) {
          errorMessage = response.data['message'];
        }
        emit(LoginErrorState(errorMessage: errorMessage));
      }
  }
  catch(e,stack){
    print('stack Trace : $stack');
    emit(LoginErrorState(errorMessage: e.toString()));
  }
 }
}



