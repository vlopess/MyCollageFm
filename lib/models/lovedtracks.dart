// ignore_for_file: unnecessary_this

import 'package:my_collage_fm/models/track.dart';

class Lovedtracks {
  List<Track>? track;

  Lovedtracks({this.track});

  Lovedtracks.fromJson(Map<String, dynamic> json) {
    if (json['track'] != null) {
      track = <Track>[];
      json['track'].forEach((v) {
        track!.add(Track.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.track != null) {
      data['track'] = this.track!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}