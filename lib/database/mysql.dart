import 'package:mysql1/mysql1.dart';


class MySqlDatabase{
  // static MySqlConnection? _connection;
   Future<MySqlConnection> getConnection() async{
      // if(_connection != null) return _connection!;
        final settings = ConnectionSettings(
            host: 'localhost',
            port: 3306,
            user: 'root',
            // password: '',
            db: "adminweb"
        );
    
        return await MySqlConnection.connect(settings);
  }
}