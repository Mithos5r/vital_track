import 'package:meta/meta.dart';

@immutable
class UserEntity {
  final String uid;
  final String email;

  const UserEntity({
    required this.uid,
    required this.email,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntity &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          email == other.email;

  @override
  int get hashCode => uid.hashCode ^ email.hashCode;
}
