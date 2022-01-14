class UserInfo {
  final String? name;
  UserInfo({this.name});

  static UserInfo fromJson(Map<String, dynamic> json) => UserInfo(
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
