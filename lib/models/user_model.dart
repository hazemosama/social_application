class UserModel{
late final String firstName;
late final String lastName;
late final String userName;
late final String email;
late final String phone;
late final String uId;
late final bool isEmailVerified;
//
UserModel({
  required this.firstName,
  required this.lastName,
  required this.userName,
  required this.email,
  required this.phone,
  required this.uId,
  required this.isEmailVerified,


});
UserModel.fromJson(Map<String,dynamic>json){
  firstName=json['firstName'];
  lastName=json['lastName'];
  userName=json['userName'];
  email=json['email'];
  phone=json['phone'];
  uId=json['uId'];
  isEmailVerified=json['isEmailVerified'];


}
Map<String,dynamic> toMap(){
 return{
   'firstName':firstName,
   'lastName':lastName,
   'userName':userName,
   'email':email,
   'phone':phone,
   'uId':uId,
   'isEmailVerified':isEmailVerified,

 };

}

}