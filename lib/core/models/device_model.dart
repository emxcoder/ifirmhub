// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DeviceModel {
  final String name;
  final String identifier;
  final String boardconfig;
  final String platform;
  final int cpid;
  final int bdid;
  String url = '';
  DeviceModel({
    required this.name,
    required this.identifier,
    required this.boardconfig,
    required this.platform,
    required this.cpid,
    required this.bdid,
  }) {
    url = 'https://ipsw.me/assets/devices/$identifier';
  }

  DeviceModel copyWith({
    String? name,
    String? identifier,
    String? boardconfig,
    String? platform,
    int? cpid,
    int? bdid,
  }) {
    return DeviceModel(
      name: name ?? this.name,
      identifier: identifier ?? this.identifier,
      boardconfig: boardconfig ?? this.boardconfig,
      platform: platform ?? this.platform,
      cpid: cpid ?? this.cpid,
      bdid: bdid ?? this.bdid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'identifier': identifier,
      'boardconfig': boardconfig,
      'platform': platform,
      'cpid': cpid,
      'bdid': bdid,
    };
  }

  factory DeviceModel.fromMap(Map<String, dynamic> map) {
    return DeviceModel(
      name: map['name'] as String,
      identifier: map['identifier'] as String,
      boardconfig: map['boardconfig'] as String,
      platform: map['platform'] as String,
      cpid: map['cpid'] as int,
      bdid: map['bdid'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeviceModel.fromJson(String source) =>
      DeviceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DeviceModel(name: $name, identifier: $identifier, boardconfig: $boardconfig, platform: $platform, cpid: $cpid, bdid: $bdid)';
  }

  @override
  bool operator ==(covariant DeviceModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.identifier == identifier &&
        other.boardconfig == boardconfig &&
        other.platform == platform &&
        other.cpid == cpid &&
        other.bdid == bdid;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        identifier.hashCode ^
        boardconfig.hashCode ^
        platform.hashCode ^
        cpid.hashCode ^
        bdid.hashCode;
  }
}
