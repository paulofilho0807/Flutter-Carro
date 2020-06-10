import 'package:car/pages/apiResponse.dart';
import 'package:car/pages/home_page.dart';
import 'package:car/pages/login_api.dart';
import 'package:car/pages/usuario.dart';
import 'package:car/utils/alert.dart';
import 'package:car/utils/nav.dart';
import 'package:car/widgets/app_button.dart';
import 'package:car/widgets/app_text.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _tLogin = TextEditingController(text: "Nome");

  final _tSenha = TextEditingController(text: "123");

  final _focusSenha = FocusNode();

  @override
  void initSate() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LifeCar"),
      ),
      body: _body(),
    );
  }

  _body() {
    var color = Color;
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            AppText(
              "Login",
              "Insirar o Login",
              contoller: _tLogin,
              validator: _validateLogin,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              nextFocus: _focusSenha,
            ),
            SizedBox(height: 10),
            AppText(
              "Senha",
              "Digite a Senha",
              password: true,
              contoller: _tSenha,
              validator: _validateSenha,
              keyboardType: TextInputType.number,
              focusNode: _focusSenha,
            ),
            SizedBox(height: 20),
            AppButton(
              "Login",
              onPressed: _onClickLogin,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onClickLogin() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    String login = _tLogin.text;
    String senha = _tSenha.text;

    print("Login: $login, senha: $senha");

    ApiResponse response = await loginApi.login(login, senha);

    if (response.ok) {
      Usuario user = response.result;
      print(">>> $user");
      push(context, HomePage());
    } else {
      
     // alert(context, response.msg);
    }
  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return "Digite o Login";
    }
    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) {
      return "Digite a Senha";
    }
    if (text.length < 3) {
      return "A senha tem que ter pelo meno 3 digitos";
    }
    return null;
  }
}
