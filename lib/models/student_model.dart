class Student {
  String? id;
  String? fullName;
  String? email;
  String? university;

  Student({
    this.id,
    this.email,
    this.fullName,
    this.university,
  });

  Student.fromJson(Map<dynamic, dynamic>? map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    fullName = map['full_name'];
    email = map['email'];
    university = map['university'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'university': university,
    };
  }
}
