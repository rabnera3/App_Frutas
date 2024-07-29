import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  late String username;

  @HiveField(1)
  late String fullName;

  @HiveField(2)
  late String address;

  @HiveField(3)
  late String phoneNumber;

  @HiveField(4)
  late DateTime birthDate;

  @HiveField(5)
  late String gender;

  @HiveField(6)
  late String email;

  @HiveField(7)
  late String password;

  @HiveField(8)
  late DateTime createdAt;

  @HiveField(9)
  late DateTime updatedAt;
}
