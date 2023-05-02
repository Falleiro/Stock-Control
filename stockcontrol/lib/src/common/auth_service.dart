import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:jwt_io/jwt_io.dart';
import 'package:stock_control/src/feature/home/view/page/login/loginpage.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();

  factory AuthService() => _instance;

  AuthService._internal();

  String _token;

  Future<String> signIn(String email, String password) async {
    // Aqui você deve realizar a validação do login, por exemplo, fazendo uma requisição para uma API que verifica se o usuário existe e as credenciais estão corretas
    bool loginIsValid = await apiService.login(email, password);

    if (loginIsValid) {
      // Se o login for válido, gere o token JWT
      _token = generateToken(email, password);

      // Salve o token no armazenamento local
      await _saveToken();
    }

    return loginIsValid;
  }

  Future<void> _saveToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', _token);
  }

  Future<String> getToken() async {
    if (_token != null) {
      return _token;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');

    return _token;
  }

  String generateToken(String email, String password) {
    // Aqui você deve gerar o token JWT utilizando alguma biblioteca de geração de tokens, como por exemplo a "jwt_decoder".
    // Por exemplo:
    final Map<String, dynamic> payload = {
      'email': email,
      'password': password,
      'exp':
          DateTime.now().add(Duration(hours: 1)).millisecondsSinceEpoch ~/ 1000
    };
    final String secret = 'sua_chave_secreta';
    final token = JwtEncoder().convert(JwtClaim(set: payload).getToken(secret));
    return token;
  }
}
