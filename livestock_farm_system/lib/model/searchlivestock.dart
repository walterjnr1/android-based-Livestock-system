class Livestock_search {
  final String name;
  final String sex;
  final String livestock_no;
  final String weight;
  final String status;
  final String date_register;

  Livestock_search({
    required this.name,
    required this.sex,
    required this.livestock_no,
    required this.weight,
    required this.status,
    required this.date_register
  });

  factory Livestock_search.fromJson(Map<String, dynamic> json) {
    return Livestock_search(
      name: json['name'],
      sex: json['sex'],
      livestock_no: json['livestock_no'],
      weight: json['weight'],
      status: json['status'],
      date_register: json['date_register'],

    );
  }
  Map<String, dynamic> toJson() => {
    'name': name,
    'sex': sex,
    'livestock_no': livestock_no,
    'weight': weight,
    'status': status,
    'date_register': date_register,
  };
}
class Env_search {
  //static String URL_PREFIX = "http://localhost/livestock_API";
  static String URL_PREFIX = "https://livestock.leastpayproject.com.ng";

}