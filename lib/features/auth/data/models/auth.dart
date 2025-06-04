class RegisterModel {
  static const String collectionName = 'users';
  String id;
  String name;
  String email;
  String password;
  String rePassword;
  String phone;
  String image;

  RegisterModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.rePassword,
    required this.image
});

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone' :phone,
      'password' :password,
      'rePassword' :rePassword,
      'image' :image,

    };
  }

  RegisterModel.fromFireStore(Map<String, dynamic> json)
      : this(
    id: json['id'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    phone: json['phone'] as String,
    password: json['password'] as String,
    rePassword: json['rePassword'] as String,
    image: json['image'] as String,
  );

}