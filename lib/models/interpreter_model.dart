class Interpreter {
  String? id;
  String? fullName;
  String? email;

  Interpreter({
    this.id,
    this.email,
    this.fullName,
  });

  Interpreter.fromJson(Map<dynamic, dynamic>? map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    fullName = map['full_name'];
    email = map['email'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
    };
  }
}
