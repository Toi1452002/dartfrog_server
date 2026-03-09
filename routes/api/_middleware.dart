import 'package:dart_frog/dart_frog.dart';
import 'package:admin_server/utils/jwt_util.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

Handler middleware(Handler handler) {
  return (context) async{
    final request = context.request;
    final authHeader = request.headers['authorization'];
      if (authHeader == null || !authHeader.startsWith('Bearer ')) {
      return Response.json(
        statusCode: 401,
        body: {
          "success": false,
          "message": "Token missing"
        },
      );
    }
    final token = authHeader.replaceFirst('Bearer ', '');
    try {

      final jwt = verifyToken(token);

      final userId = jwt.payload['user_id'];

      final newContext = context.provide<int>(() => int.parse(userId.toString()));

      return handler(newContext);

    } on JWTExpiredException {

      return Response.json(
        statusCode: 401,
        body: {
          "success": false,
          "message": "Token expired"
        },
      );

    } catch (_) {

      return Response.json(
        statusCode: 401,
        body: {
          "success": false,
          "message": "Invalid token"
        },
      );

    }
  };
}
