class UserEntity{
  final int id;
  final String userName;
  final String email;
  final String? fullName;
  final String? password;


  UserEntity({required this.id, required this.userName, required this.email, this.fullName, this.password});

  Map<String, dynamic> toJson(){
    return {
        'id': id,
        'username': userName,
        'email': email,
        'full_name': fullName
    };
  }
  }