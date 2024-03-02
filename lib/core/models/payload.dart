class Payload {
  Payload({
    this.ref,
    this.refType,
    this.masterBranch,
    this.description,
    this.pusherType,
  });

  Payload.fromJson(Map<String, dynamic> json)
      : ref = json['ref'] as String?,
        refType = json['ref_type'] as String?,
        masterBranch = json['master_branch'] as String?,
        description = json['description'] as String?,
        pusherType = json['pusher_type'] as String?;
  final String? ref;
  final String? refType;
  final String? masterBranch;
  final String? description;
  final String? pusherType;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'ref': ref,
        'ref_type': refType,
        'master_branch': masterBranch,
        'description': description,
        'pusher_type': pusherType
      };
}
