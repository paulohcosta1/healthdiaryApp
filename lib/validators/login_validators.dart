import 'dart:async';

class LoginValidators {
  final validateUser =
      StreamTransformer<String, String>.fromHandlers(handleData: (user, sink) {
    if (user.length > 3) {
      sink.add(user);
    } else {
      sink.addError("Insira um usuário válido.");
    }
  });
  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 4) {
      sink.add(password);
    } else {
      sink.addError("Senha inválida, deve conter no mínimo 4 caracteres");
    }
  });
}
