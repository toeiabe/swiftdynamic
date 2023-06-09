import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String nickName;
  final String phoneNumber;
  final String email;

  final String houseNumber;
  final String soi;
  final String road;
  final String province;
  final String amphure;
  final String tambon;
  final String zipcode;

  User(
      this.name,
      this.nickName,
      this.phoneNumber,
      this.email,
      this.houseNumber,
      this.soi,
      this.road,
      this.province,
      this.amphure,
      this.tambon,
      this.zipcode);

  @override
  // TODO: implement props
  List<Object?> get props => [
        name,
        nickName,
        phoneNumber,
        email,
        houseNumber,
        soi,
        road,
        province,
        amphure,
        zipcode
      ];
}
