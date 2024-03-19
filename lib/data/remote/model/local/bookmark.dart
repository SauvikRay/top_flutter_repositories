import 'package:floor/floor.dart';

@entity
class BookmarkEntity {
  @primaryKey
  String? id;
  String? image;
  String? title;
  String? slug;
  String? created;
  String? type;
  // New field to store category ID

  BookmarkEntity({
    this.id,
    this.image,
    this.title,
    this.slug,
    this.created,
    this.type,
  });
}
