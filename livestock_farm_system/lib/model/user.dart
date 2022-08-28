class User {

  final String photo;
  final String poultry_name;
  final String fullname;
  final String email;
  //final String username_value;

  User({
     required this.photo,
    required this.poultry_name,
    required this.fullname,
    required this.email,
   // required this.username_value

  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      photo: json['photo'],
     poultry_name: json['poultry_name'],
      fullname: json['fullname'],
      email: json['email'],
     // username_value: json['username'],

    );
  }
  Map<String, dynamic> toJson() => {
        'photo': photo,
  'poultry_name': poultry_name,
    'fullname': fullname,
    'email': email,
    //'username': username_value,

  };
}
class Env {
  //static String URL_PREFIX = "http://localhost/livestock_API";
  static String URL_PREFIX = "https://livestock.leastpayproject.com.ng";

}