// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_collage_fm/models/track_dto.dart';

class NostalgiaTrack {
  String? description;
  File? image;
  String? imageUrl;
  String? path;
  TrackDTO? track;
  NostalgiaTrack({
    this.description,
    this.image,
    this.imageUrl,
    this.path,
    this.track,
  });

  NostalgiaTrack copyWith({
    String? description,
    String? imageUrl,
    String? path,
    TrackDTO? track,
  }) {
    return NostalgiaTrack(
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      path: path ?? this.path,
      track: track ?? this.track,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'imageUrl': imageUrl,
      'path': path,
      'track': track?.toJson(),
    };
  }

  factory NostalgiaTrack.fromMap(Map<String, dynamic> map) {
    return NostalgiaTrack(
      description: map['description'] != null ? map['description'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      path: map['path'] != null ? map['path'] as String : null,
      track: map['track'] != null ? TrackDTO.fromJson(map['track'] as Map<String,dynamic>) : null,
    );
  }
  factory NostalgiaTrack.fromObject(DocumentSnapshot<Object?> obj){
    return NostalgiaTrack(
      description: obj['description'],
      imageUrl: obj['imageUrl'],
      path: obj['path'],
      track: TrackDTO.fromJson(obj['track'])
    );
  }

  String toJson() => json.encode(toMap());

  factory NostalgiaTrack.fromJson(String source) => NostalgiaTrack.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'NostalgiaTrack(description: $description, imageUrl: $imageUrl, track: $track)';

  @override
  bool operator ==(covariant NostalgiaTrack other) {
    if (identical(this, other)) return true;
  
    return 
      other.description == description &&
      other.imageUrl == imageUrl &&
      other.track == track;
  }

  @override
  int get hashCode => description.hashCode ^ imageUrl.hashCode ^ track.hashCode;
}
