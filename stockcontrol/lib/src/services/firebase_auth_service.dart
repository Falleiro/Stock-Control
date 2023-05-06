import 'package:firebase_auth/firebase_auth.dart';
import 'package:stock_control/src/feature/home/view/page/login/singuppage.dart';
import 'package:stock_control/src/main.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  static final FirebaseAuthService _instance = FirebaseAuthService._();
  late final FirebaseAuth _firebaseAuth;

  factory FirebaseAuthService() {
    return _instance;
  }

  FirebaseAuthService._() {
    _firebaseAuth = FirebaseAuth.instance;
  }

  Future<UserCredential> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    // Validando email e senha
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email e senha são obrigatórios.');
    }
    if (!email.contains('@')) {
      throw Exception('Email inválido.');
    }
    if (password.length < 6) {
      throw Exception('A senha deve ter pelo menos 6 caracteres.');
    }

    // Tentando criar o usuário
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Tratando erros específicos do FirebaseAuth
      if (e.code == 'weak-password') {
        throw Exception('A senha é muito fraca.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('Este email já está em uso.');
      }
      // Caso contrário, lançamos uma exceção genérica
      throw Exception('Ocorreu um erro ao criar a conta: ${e.message}');
    } catch (e) {
      // Tratando outros tipos de erros
      throw Exception('Ocorreu um erro ao criar a conta: $e');
    }
  }

  Future<UserCredential> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('Usuário não encontrado.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Senha incorreta.');
      }
      throw Exception('Ocorreu um erro ao fazer login: ${e.message}');
    } catch (e) {
      throw Exception('Ocorreu um erro ao fazer login: $e');
    }
  }
}
