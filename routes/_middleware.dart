import 'package:dart_frog/dart_frog.dart';


const _corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
  'Access-Control-Allow-Headers': 'Origin, Content-Type, Authorization',
};

Handler middleware(Handler handler) {
return (context) async{
  final request = context.request;
  if(request.method == HttpMethod.options){
    return Response(
      statusCode: 200,
      headers: _corsHeaders
    );
  }

  final response = await handler(context);
  return response.copyWith(
    headers: {
        ...response.headers,
        ..._corsHeaders,
    }
  );
};

  // return (context) async {
  //   final request = context.request;
  //   // =========================
  //   // CORS preflight
  //   // =========================
  //   // Handle preflight request
  //   if (request.method == HttpMethod.options) {
  //     return Response(
  //       statusCode: 200,
  //       headers: {
  //         'Access-Control-Allow-Origin': '*',
  //         'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
  //         'Access-Control-Allow-Headers': 'Origin, Content-Type, Authorization',
  //       },
  //     );
  //   }
  //   // =========================
  //   // Bỏ qua login API
  //   // =========================
  //   final path = request.uri.path;

  //   if (path.contains('/login')) {
  //     final response = await handler(context);

  //     return response.copyWith(
  //       headers: {
  //         ...response.headers,
  //         'Access-Control-Allow-Origin': '*',
  //         'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
  //         'Access-Control-Allow-Headers': 'Origin, Content-Type, Authorization',
  //       },
  //     );
  //   }

  //   // =========================
  //   // Lấy Authorization header
  //   // =========================

  //   final authHeader = request.headers['authorization'];

  //   if (authHeader == null || !authHeader.startsWith('Bearer ')) {
  //     return Response.json(
  //         headers: {
  //     'Access-Control-Allow-Origin': '*',
  //     'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
  //     'Access-Control-Allow-Headers': 'Origin, Content-Type, Authorization',
  //   },
  //       statusCode: 401,
  //       body: {"success": false, "message": "Token missing"},
  //     );
  //   }

  //   final token = authHeader.replaceFirst('Bearer ', '');
  //   print(token);
  //   try {
  //     final jwt = verifyToken(token);

  //     final userId = jwt.payload['user_id'];

  //     // attach userId vào context
  //     // ignore: lines_longer_than_80_chars
  //     final newContext = context.provide<int>(() => int.parse(userId.toString()));

  //     final response = await handler(newContext);

  //     return response.copyWith(
  //       headers: {
  //         ...response.headers,
  //         'Access-Control-Allow-Origin': '*',
  //         'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
  //         'Access-Control-Allow-Headers': 'Origin, Content-Type, Authorization',
  //       },
  //     );
  //   } catch (e) {
  //     return Response.json(
  //       statusCode: 401,
  //         headers: {
  //     'Access-Control-Allow-Origin': '*',
  //     'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
  //     'Access-Control-Allow-Headers': 'Origin, Content-Type, Authorization',
  //   },
  //       body: {"success": false, "message": "Invalid token"},
  //     );
  //   }
  // };
}
