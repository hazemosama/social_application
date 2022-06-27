abstract class RegisterStates{}
class RegisterInitialStates extends RegisterStates{}
class SocialRegisterLoadingState extends RegisterStates{}
class SocialRegisterSuccessState extends RegisterStates{}
class SocialRegisterErrorState extends RegisterStates{
  final error;

  SocialRegisterErrorState(this.error);
}
class CreateUserSuccessState extends RegisterStates{}
class CreateUserErrorState extends RegisterStates{
  final  String error;

  CreateUserErrorState(this.error);
}
class SocialRegisterChangePasswordVisibilityState extends RegisterStates{}

