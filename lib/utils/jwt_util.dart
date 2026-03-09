import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

const secretKey = 'super_secret_key';
String generateToken(int userID){
  final jwt  = JWT({'user_id': userID});

  return jwt.sign(SecretKey(secretKey),expiresIn: const Duration(minutes: 30));
  
}

JWT verifyToken(String token) {
  return JWT.verify(token, SecretKey(secretKey));
}