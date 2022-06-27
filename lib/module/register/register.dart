
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/module/register/cubit/register_cubit.dart';
import 'package:social_app/module/register/cubit/register_states.dart';
import 'package:social_app/shared/components/component.dart';

class RegisterScreen extends StatelessWidget {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if(state is CreateUserSuccessState){
            navegateAndReplacement(context, SocialLayout());
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.black),
              elevation: 0.0,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Register now to communicate with friends',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: firstNameController,
                          label: 'First Name ',
                          prefix: Icons.person,
                          type: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your first name';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          controller: lastNameController,
                          label: 'Last Name',
                          prefix: Icons.person,
                          type: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your Last Name ';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          controller: userNameController,
                          label: 'User Name',
                          prefix: Icons.person,
                          type: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your User Name ';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          controller: emailController,
                          label: 'Email',
                          prefix: Icons.email_outlined,
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your Email Address';
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
                          suffix: RegisterCubit.get(context).suffix,
                          isPassword:
                          RegisterCubit.get(context).isPassword,
                          suffixPressed: () {
                            RegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your Password';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          controller: phoneNumberController,
                          label: 'Phone Number',
                          prefix: Icons.email_outlined,
                          type: TextInputType.phone,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your Phone Number';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Center(
                            child: ConditionalBuilder(
                              condition: state is! SocialRegisterLoadingState,
                              builder:(context)=>defaultButton(
                                  function: () {
                                    RegisterCubit.get(context).userRegister(
                                        firstName: firstNameController.text,
                                        lastName: lastNameController.text,
                                        userName: userNameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneNumberController.text);
                                  }, text: "Register", width: 300),
                              fallback: (context)=>const Center(child: CircularProgressIndicator()),

                            )),
                      ],
                    ),
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
