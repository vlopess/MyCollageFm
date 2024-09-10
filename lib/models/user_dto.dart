// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:my_collage_fm/models/nostalgia_track.dart';

class UserDTO {
  String? name;
  String? email;
  List<NostalgiaTrack?> nostalgiaTracks;
  UserDTO({
    this.name,
    this.email,
    required this.nostalgiaTracks,
  });

  

  UserDTO copyWith({
    String? name,
    String? email,
    List<NostalgiaTrack?>? nostalgiaTracks,
  }) {
    return UserDTO(
      name: name ?? this.name,
      email: email ?? this.email,
      nostalgiaTracks: nostalgiaTracks ?? this.nostalgiaTracks,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name?.toLowerCase(),
      'email': email,
      'nostalgiaTracks': nostalgiaTracks.map((x) => x?.toMap()).toList(),
    };
  }

  factory UserDTO.fromMap(Map<String, dynamic> map) {
    return UserDTO(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      nostalgiaTracks: map['nostalgiaTracks'] != null ? List<NostalgiaTrack?>.from((map['nostalgiaTracks'] as List<int>).map<NostalgiaTrack?>((x) => NostalgiaTrack?.fromMap(x as Map<String,dynamic>),),) : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDTO.fromJson(String source) => UserDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  factory UserDTO.fromObject(QueryDocumentSnapshot<Object?>  obj){
    return UserDTO(
      name: obj['name'] != null ? obj['name'] as String : null,
      email: obj['email'] != null ? obj['email'] as String : null,
      nostalgiaTracks: obj['nostalgiaTracks'] != null ? List<NostalgiaTrack?>.from((obj['nostalgiaTracks'] as List<dynamic>).map<NostalgiaTrack?>((x) => NostalgiaTrack?.fromMap(x as Map<String,dynamic>),),) : [],
    );
  }

  @override
  String toString() => 'UserDTO(name: $name, email: $email, nostalgiaTracks: $nostalgiaTracks)';

  @override
  bool operator ==(covariant UserDTO other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.email == email &&
      listEquals(other.nostalgiaTracks, nostalgiaTracks);
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ nostalgiaTracks.hashCode;
}
