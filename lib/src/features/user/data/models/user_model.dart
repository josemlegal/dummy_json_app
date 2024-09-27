import 'package:dummy_json_app/src/features/user/domain/entities/user_entity.dart';
import 'package:intl/intl.dart';

class UserModel {
  const UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.birthDate,
    required this.email,
    required this.gender,
    required this.phone,
    required this.image,
  });

  final int id;
  final String firstName;
  final String lastName;
  final int age;
  final String gender;
  final String email;
  final String phone;
  final String birthDate;
  final String image;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int? ?? 0,
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      age: json['age'] as int? ?? 0,
      birthDate: json['birthDate'] as String? ?? '',
      email: json['email'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      image: json['image'] as String? ?? '',
    );
  }

  UserEntity toEntity() {
    return UserEntity(
        id: id,
        firstName: firstName,
        lastName: lastName,
        age: age,
        gender: gender,
        phone: phone,
        birthDate: DateFormat('yyyy-MM-dd').parse(birthDate),
        image: image,
        email: email);
  }

  @override
  String toString() {
    return '''UserModel(
        id: $id,
        firstName: $firstName,
        lastName: $lastName,
        age: $age,
        birthDate: $birthDate,
        email: $email,
        gender: $gender,
        phone: $phone,
        image: $image)''';
  }
}
