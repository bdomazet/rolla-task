class Actor {
  Actor({
    this.id,
    this.login,
    this.gravatarId,
    this.url,
    this.avatarUrl,
  });

  Actor.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        login = json['login'] as String?,
        gravatarId = json['gravatar_id'] as String?,
        url = json['url'] as String?,
        avatarUrl = json['avatar_url'] as String?;
  final int? id;
  final String? login;
  final String? gravatarId;
  final String? url;
  final String? avatarUrl;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'login': login,
        'gravatar_id': gravatarId,
        'url': url,
        'avatar_url': avatarUrl
      };
}
