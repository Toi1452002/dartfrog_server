import 'package:admin_server/database/mysql.dart';
import 'package:admin_server/features/user/user_repository_impl.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async{
  final method = context.request.method;
  if(method == HttpMethod.get){
    final userRepo = UserRepositoryImpl(MySqlDatabase());
    final result = await userRepo.getList();
    print(context.read<int>());
    return Response.json(
        body: {
          'success': true,
          'message':'users fetched',
          'data': result.map((e)=>e.toJson()).toList()
        }
    );
  }else{
    return Response(statusCode: 405);

  }
  // return Response(body: 'Welcome to Dart Frog!');
}
