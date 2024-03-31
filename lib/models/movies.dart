class Movies {
  final String id;
  final String imageUrl;
  final String name;
  final String releaseDate;
  final String runtime;
  final String apiDetailUrl;

  Movies({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.releaseDate,
    required this.runtime,
    required this.apiDetailUrl,
  });

  factory Movies.fromJson(Map<String, dynamic> json) {
    String defaultImageUrl = 'https://www.placecage.com/200/300';
    String id = json['id']?.toString() ?? '0000';
    String name = json['name']?.toString() ?? 'Unknown';
    String imageUrl = json['image'] != null ? json['image']['original_url'] ?? defaultImageUrl : defaultImageUrl;
    String releaseDate = json['release_date']?.toString() ?? 'Unknown';
    String runtime = json['runtime']?.toString() ?? 'Unknown';
    String apiDetailUrl = json['api_detail_url']?.toString() ?? 'Unknown';

    return Movies(
      id: id,
      imageUrl: imageUrl,
      name: name,
      releaseDate: releaseDate,
      runtime: runtime,
      apiDetailUrl: apiDetailUrl,
      );
  }
}
