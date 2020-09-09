class CharacterRelatedData {
  int available;
  String collectionURI;

  CharacterRelatedData({this.available, this.collectionURI});

  CharacterRelatedData.fromJson(Map<String, dynamic> json) {
    available = json['available'];
    collectionURI = json['collectionURI'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['available'] = this.available;
    data['collectionURI'] = this.collectionURI;
    return data;
  }
}
