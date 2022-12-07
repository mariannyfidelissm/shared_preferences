import 'dart:convert';

class User {
  String nome;
  String idade;
  String location;

  User({
    required this.nome,
    required this.idade,
    required this.location,
  });

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {"nome": nome, "idade": idade, "location": location};
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      nome: map['nome'] ?? '',
      idade: map['idade'] ?? '',
      location: map['location'] ?? '',
    );
  }

  @override
  String toString() {
    return nome + idade + location;
  }
}
