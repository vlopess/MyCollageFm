class TrackDTO {
  String? artist;
  String? name;
  String? image;

  TrackDTO(
      {this.artist='',
      this.name='',
      this.image=''});

  TrackDTO.fromJson(Map<String, dynamic> json) {
    artist = json['artist'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['artist'] = artist!;    
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}