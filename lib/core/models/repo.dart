class Repo {
  Repo({
    this.id,
    this.name,
    this.url,
  });

  Repo.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        url = json['url'] as String?;
  final int? id;
  final String? name;
  final String? url;

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'id': id, 'name': name, 'url': url};
}
