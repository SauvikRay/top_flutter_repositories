
class DatabaseItem {
  int? id;
  String? repoName;
  String? ownerName;
  int? ownerId;
  String? avarterId;
  int? starCount;
  String? description;
  String? pushedAt;
  DatabaseItem({this.id, this.repoName, this.ownerName, this.ownerId, this.avarterId, this.starCount, this.description, this.pushedAt});

  factory DatabaseItem.fromJson(Map<String, dynamic> json) => DatabaseItem(
        id: json["id"],
        repoName: json["repoName"],
        ownerName:json["ownerName"],
        ownerId:json["ownerId"],
        avarterId: json["avatar_url"],
        starCount: json["stargazers_count"],
        description: json["description"],
        pushedAt: json["pushed_at"],
    );

  Map<String, dynamic> toJson() => {
    "id":id,
    "repoName":repoName,
    "ownerName":ownerName,
    "ownerId":ownerId,
    "avatar_url":avarterId,
    "stargazers_count":starCount,
    "description":description,
    "pushed_at":pushedAt,

  };
}
