class UserModal {
  String? username, email,photoUrl, phone;

  UserModal._({required this.username, required this.email,required this.photoUrl,required this.phone});

  factory UserModal(Map m1) {
    return UserModal._(username: m1['username'], email: m1['email'],phone: m1['phone'],photoUrl: m1['photoUrl']??'https://w7.pngwing.com/pngs/81/570/png-transparent-profile-logo-computer-icons-user-user-blue-heroes-logo-thumbnail.png');
  }

  Map<String, String> objectToMap(UserModal userModal) {
    return {
      'username': userModal.username??'Meet R Panchal',
      'email': userModal.email!,
      'photoUrl':userModal.photoUrl!,
    };
  }
}