class Patient {
  final String id;
  final String username;
  final String email;
  final String password;
  final String name;
  final String phone;
  final String cpf;
  final String menuID;
  final String formID;
  final String waterGoalID;

  Patient( {
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.cpf,
    required this.menuID,
    required this.formID,
    required this.waterGoalID,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      cpf: json['cpf'] as String,
      menuID: json['menuID'] as String,
      formID: json['formID'] as String,
      waterGoalID: json['waterGoalID'] as String,
    );
  }
}
