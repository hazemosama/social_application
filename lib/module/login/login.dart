
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/module/login/cubit/login_cubit.dart';
import 'package:social_app/module/login/cubit/login_states.dart';
import 'package:social_app/module/register/register.dart';
import 'package:social_app/shared/components/component.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if(state is SocialLoginErrorState){
            showToast(text: state.error, state: ToastStates.ERROR);
          }else if(state is SocialLoginSuccessState){
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value){
              navegateAndReplacement(context, SocialLayout());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Image(
                          image: AssetImage('assets/images/login.jpg'),
                          height: 280,
                          width: 280,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Login now to communicate with friends',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      defaultFormField(
                        controller: emailController,
                        label: 'Email Address',
                        prefix: Icons.email_outlined,
                        type: TextInputType.emailAddress,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter your email address';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        label: 'password',
                        prefix: Icons.lock_outline,
                        type: TextInputType.visiblePassword,
                        suffix: LoginCubit.get(context).suffix,
                        isPassword:
                        LoginCubit.get(context).isPassword,
                        suffixPressed: () {
                          LoginCubit.get(context)
                              .changePasswordVisibility();
                        },
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter your Password';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Center(
                          child: defaultButton(
                              function: () {
                                LoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);
                              }, text: "Login", width: 300)),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account?',
                          ),
                          defaultTextButton(
                            function: () {
                              navegateTo(
                                context,
                                RegisterScreen(),
                              );
                            },
                            text: 'register',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
