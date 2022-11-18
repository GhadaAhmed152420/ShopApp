import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/Register/states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import '../../../models/login_model.dart';
import '../../network/end_points.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({ required String name, required String email, required String password, required String phone}) {
    emit(RegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data: {'name': name, 'email': email, 'password': password, 'phone': phone}).then((value) {
      LoginModel loginModel = LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(loginModel));
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }
}
