class FavoriteModel {
  final String english;
  final String marshallese;
  final String category;

  FavoriteModel({
    required this.english,
    required this.marshallese,
    required this.category,
  });

  Map<String, String> toMap() {
    return {
      'english': english,
      'marshallese': marshallese,
      'category': category,
    };
  }

  factory FavoriteModel.fromMap(Map<String, String> map) {
    return FavoriteModel(
      english: map['english'] ?? '',
      marshallese: map['marshallese'] ?? '',
      category: map['category'] ?? 'General',
    );
  }
}
