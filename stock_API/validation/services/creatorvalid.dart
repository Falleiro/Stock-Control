import '../../../stockcontrol/lib/src/feature/home/view/page/login/singuppage.dart';
import '../../../stockcontrol/lib/src/feature/home/view/page/login/loginpage.dart';
import '../../../stockcontrol/lib/src/feature/home/view/page/homepage.dart';

// void validatePasswordAndEmail(BuildContext context, String _email,
//     String _password, String _confirmPassword) {
//   final String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
//   final RegExp emailValidation = RegExp(emailRegex);

//   final String passwordRegex = r'^(?=.*[!@#\$&*~]).{6,12}$';
//   final RegExp passwordValidation = RegExp(passwordRegex);

//   if (!_email.contains('@gmail.com') || !emailValidation.hasMatch(_email)) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           backgroundColor: Colors.red,
//           elevation: 10.0,
//           child: Container(
//             height: 100,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Erro",
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   "Por favor, insira um email válido do Gmail.",
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 ElevatedButton(
//                   child: Text("OK"),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   } else if (_password == null || !_password.isNotEmpty) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           backgroundColor: Colors.red,
//           elevation: 10.0,
//           child: Container(
//             height: 100,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Erro",
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   "Por favor, insira uma senha.",
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 ElevatedButton(
//                   child: Text("OK"),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   } else if (!_password.isNotEmpty ||
//       _password.length < 6 ||
//       _password.length > 12 ||
// !passwordValidation.hasMatch(_password)) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           backgroundColor: Colors.red,
//           elevation: 10.0,
//           child: Container(
//             height: 100,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Erro",
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   "Por favor, insira uma senha com pelo menos 6 caracteres, no máximo 12 caracteres e que contenha um caractere especial (!@#\$&*~).",
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 ElevatedButton(
//                   child: Text("OK"),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   } else if (_password != _confirmPassword) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           backgroundColor: Colors.red,
//           elevation: 10.0,
//           child: Container(
//             height: 100,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Erro",
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   "As senhas são diferentes.",
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 ElevatedButton(
//                   child: Text("OK"),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   } else {
//     // Nenhum erro encontrado, redireciona para a página de login
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => LoginPage(),
//       ),
//     );
//   }
// }


