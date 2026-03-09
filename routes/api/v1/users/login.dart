import 'package:admin_server/database/mysql.dart';
import 'package:admin_server/features/user/user_repository_impl.dart';
import 'package:admin_server/utils/jwt_util.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:bcrypt/bcrypt.dart';
Future<Response> onRequest(RequestContext context) async {
  final method = context.request.method;
  switch (method) {
    case HttpMethod.post:
      return _login(context);
    default:
      return Response(statusCode: 405);
  }
}

Future<Response> _login(RequestContext context) async{
  final userRepo = UserRepositoryImpl(MySqlDatabase());
  final body = await context.request.json() ;
  final userName = body['username'];
  final password = body['password'];
  final user = await userRepo.findByUsername(userName.toString());

  if(user==null){
    return Response.json(
      body: {
        'success': false,
        'message': 'User not found'
      } 
    );
  }

  final valid = BCrypt.checkpw(password.toString(), user.password.toString());
  if(!valid){
    return Response.json(
      body: {
        'success': false,
        'message': 'Invalid password'
      } 
    );
  }

  final token = generateToken(user.id);
  return Response.json(
    body: {
      'success':true,
      'message': 'Login success',
      'data':{
        'token': token,
        'user': {
          'id': user.id,
          'username':user.userName
        }
      }
    }
  );

}