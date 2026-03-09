import 'package:admin_server/database/mysql.dart';
import 'package:admin_server/features/user/user_repository_impl.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:bcrypt/bcrypt.dart';

Future<Response> onRequest(RequestContext context) async {
  final method = context.request.method;
  switch (method) {
    case HttpMethod.post:
      return _createUser(context);
    default:
      return Response(statusCode: 405);
  }
}

Future<Response> _createUser(RequestContext context) async {
  
  try {
    final body = await context.request.formData();
    // print(body1.fields['username']);
    // final body = await context.request.params;
    final userName = body.fields['username'];
    final email = body.fields['email'];
    final password = body.fields['password'];
    final fullName = body.fields['full_name'];

    if (userName == null ||
        email == null ||
        password == null ||
        fullName == null) {
      return Response.json(
          statusCode: 400,
          body: {'success': false, 'message': 'Missing request fields'});
    }

    final repo = UserRepositoryImpl(MySqlDatabase());
    final hash = BCrypt.hashpw(password.toString(), BCrypt.gensalt());

    await repo.create(
        username: userName,
        email: email,
        password: hash,
        fullname: fullName);

    return Response.json(
      statusCode: 201,
      body: {"success": true, "message": "User created"},
    );
  } catch (e) {
      return Response.json(
      statusCode: 500,
      body: {
        "success": false,
        "message": e.toString(),
        'error':'500'
      },
    );
  }
}


