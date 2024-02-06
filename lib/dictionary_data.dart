class Dictionary {
  String? ilokano;
  String? pronunciation;
  String? partOfSpeech;
  String? english;
  String? affix;
  String? example;
  String? imageUrl;
  String? soundsUrl;

  Dictionary(
      {this.ilokano,
      this.pronunciation,
      this.partOfSpeech,
      this.english,
      this.affix,
      this.example,
      this.imageUrl,
      this.soundsUrl});

  Dictionary.fromJson(Map<String, dynamic> json) {
    ilokano = json['ilokano'];
    pronunciation = json['pronunciation'];
    partOfSpeech = json['part_of_speech'];
    english = json['english'];
    affix = json['affix'];
    example = json['example'];
    imageUrl = json['imageUrl'];
    soundsUrl = json['soundsUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ilokano'] = ilokano;
    data['pronunciation'] = pronunciation;
    data['part_of_speech'] = partOfSpeech;
    data['english'] = english;
    data['affix'] = affix;
    data['example'] = example;
    data['imageUrl'] = imageUrl;
    data['soundsUrl'] = soundsUrl;
    return data;
  }
}
