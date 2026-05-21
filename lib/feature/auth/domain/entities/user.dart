

class User {
  final String id;
  final String email;
  final String name;  
  //final String lastName;
  final String role;
  final String accessToken;

  User({
    required this.id,
    required this.email,
    required this.name,
    //required this.lastName,
    required this.accessToken,
    required this.role,
  });

  /*bool isAdmin() {
    return roles.contains('admin');
  }*/
}