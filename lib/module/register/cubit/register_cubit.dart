import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/module/register/cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialStates());
static RegisterCubit get(context)=>BlocProvider.of(context);

  void userRegister({
    required String firstName,
    required String lastName,
    required String userName,
    required String email,
    required String password,
    required String phone,

  }) {
    print('hello');

    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      userCreate(
          firstName: firstName,
          lastName: lastName,
          userName: userName,
          email: email,
          phone: phone,
          uId: value.user!.uid, isEmailVerified: false,
      );

emit(SocialRegisterSuccessState());
    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });

  }
  void userCreate({
    required String firstName,
    required String lastName,
    required String userName,
    required String email,
    required String phone,
    required String uId,
    required bool isEmailVerified,

  }){
    UserModel model=UserModel(
        firstName: firstName,
        lastName: lastName,
        userName: userName,
        email: email,
        phone: phone,
        uId: uId,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap()).then((value){
      emit(CreateUserSuccessState());
    }).catchError((error){
      emit(CreateUserErrorState(error));
    });
  }
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(SocialRegisterChangePasswordVisibilityState());
  }

}