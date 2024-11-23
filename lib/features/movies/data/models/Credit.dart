import 'package:movies_app/core/constants.dart';

class Credit {
  final String id;
  final String name;
  final String profile;
  final String rol;

  Credit({
    required this.id,
    required this.name,
    required this.rol,
    required this.profile,
  });

  factory Credit.fromJson(Map<String, dynamic> json) {
    return Credit(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      profile: json['profile_path'] == null || json['profile_path'] == '' ? 'https://avatar.iran.liara.run/public' : '${Constants.ImageAPIUrl}${json['profile_path']}',
      rol: json['known_for_department'] ?? '',
    );
  }
}