import 'actor.dart';
import 'payload.dart';
import 'repo.dart';

class LogModel {
  LogModel({
    this.id,
    this.type,
    this.actor,
    this.repo,
    this.payload,
    this.public,
    this.createdAt,
  });

  LogModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        type = json['type'] as String?,
        actor = (json['actor'] as Map<String, dynamic>?) != null
            ? Actor.fromJson(json['actor'] as Map<String, dynamic>)
            : null,
        repo = (json['repo'] as Map<String, dynamic>?) != null
            ? Repo.fromJson(json['repo'] as Map<String, dynamic>)
            : null,
        payload = (json['payload'] as Map<String, dynamic>?) != null
            ? Payload.fromJson(json['payload'] as Map<String, dynamic>)
            : null,
        public = json['public'] as bool?,
        createdAt = json['created_at'] as String?;
  final String? id;
  final String? type;
  final Actor? actor;
  final Repo? repo;
  final Payload? payload;
  final bool? public;
  final String? createdAt;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'type': type,
        'actor': actor?.toJson(),
        'repo': repo?.toJson(),
        'payload': payload?.toJson(),
        'public': public,
        'created_at': createdAt
      };
}
