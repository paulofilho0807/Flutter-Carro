class Usuario {
  String login;
  String nome;
  String email;
  String token;

  List<String> roles;

  Usuario.formJson(Map<String, dynamic> map)
      : login = map["login"],
        nome = map["nome"],
        email = map["email"],
        token = map["token"],
        roles = map["roles"] != null
            ? map["roles"].map<String>((role) => role.toString()).toList()
            : null;

  @override
  String toString() {
    // TODO: implement toString
    return 'Usuario{login: $login,Nome: $nome, Email: $email, Token: $token, Roles: $roles';
  }
}
