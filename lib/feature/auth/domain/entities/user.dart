

class User {
  final String id;
  final String email;
  final String name;  
  //final String lastName;
  final String roles;
  final String accessToken;

  User({
    required this.id,
    required this.email,
    required this.name,
    //required this.lastName,
    required this.accessToken,
    required this.roles,
  });

  /*bool isAdmin() {
    return roles.contains('admin');
  }*/
}