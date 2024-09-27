import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final int age;
  final String gender;
  final String email;
  final String phone;
  final DateTime birthDate;
  final String image;

  const UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
    required this.phone,
    required this.birthDate,
    required this.image,
    required this.email,
  });

  UserEntity copyWith({
    int? id,
    String? firstName,
    String? lastName,
    int? age,
    String? gender,
    String? email,
    String? phone,
    DateTime? birthDate,
    String? image,
  }) {
    return UserEntity(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      birthDate: birthDate ?? this.birthDate,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props =>
      [id, email, firstName, lastName, age, gender, phone, birthDate, image];
}
