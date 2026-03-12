// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FirmwareModel {
  final String identifier;
  final String version;
  final String buildid;
  final String sha1sum;
  final String md5sum;
  final String sha256sum;
  final int filesize;
  final String url;
  final DateTime? releasedate;
  final DateTime? uploaddate;
  final bool signed;
  FirmwareModel({
    required this.identifier,
    required this.version,
    required this.buildid,
    required this.sha1sum,
    required this.md5sum,
    required this.sha256sum,
    required this.filesize,
    required this.url,
    this.releasedate,
    this.uploaddate,
    required this.signed,
  });

  FirmwareModel copyWith({
    String? identifier,
    String? version,
    String? buildid,
    String? sha1sum,
    String? md5sum,
    String? sha256sum,
    int? filesize,
    String? url,
    DateTime? releasedate,
    DateTime? uploaddate,
    bool? signed,
  }) {
    return FirmwareModel(
      identifier: identifier ?? this.identifier,
      version: version ?? this.version,
      buildid: buildid ?? this.buildid,
      sha1sum: sha1sum ?? this.sha1sum,
      md5sum: md5sum ?? this.md5sum,
      sha256sum: sha256sum ?? this.sha256sum,
      filesize: filesize ?? this.filesize,
      url: url ?? this.url,
      releasedate: releasedate ?? this.releasedate,
      uploaddate: uploaddate ?? this.uploaddate,
      signed: signed ?? this.signed,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'identifier': identifier,
      'version': version,
      'buildid': buildid,
      'sha1sum': sha1sum,
      'md5sum': md5sum,
      'sha256sum': sha256sum,
      'filesize': filesize,
      'url': url,
      'releasedate': releasedate?.millisecondsSinceEpoch,
      'uploaddate': uploaddate?.millisecondsSinceEpoch,
      'signed': signed,
    };
  }

  factory FirmwareModel.fromMap(Map<String, dynamic> map) {
    return FirmwareModel(
      identifier: map['identifier'] as String,
      version: map['version'] as String,
      buildid: map['buildid'] as String,
      sha1sum: map['sha1sum'] as String,
      md5sum: map['md5sum'] as String,
      sha256sum: map['sha256sum'] as String,
      filesize: map['filesize'] as int,
      url: map['url'] as String,
      releasedate: map['releasedate'] != null
          ? DateTime.parse(map['releasedate'])
          : null,
      uploaddate: DateTime.parse(map['uploaddate']),
      signed: map['signed'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory FirmwareModel.fromJson(String source) =>
      FirmwareModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FirmwareModel(identifier: $identifier, version: $version, buildid: $buildid, sha1sum: $sha1sum, md5sum: $md5sum, sha256sum: $sha256sum, filesize: $filesize, url: $url, releasedate: $releasedate, uploaddate: $uploaddate, signed: $signed)';
  }
}
