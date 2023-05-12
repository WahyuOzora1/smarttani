class Plant {
  String id;
  final String nama;
  final String namaLatin;
  final String kingdom;
  final String family;
  final String deskripsi;
  String? imageUrl;
  String? penyemaian;
  String? penanaman;
  String? perawatan;
  String? pemanenan;
  String? penangananHama;
  String? rekomendasiPupuk;

  Plant({
    this.id = '',
    required this.nama,
    required this.namaLatin,
    required this.kingdom,
    required this.family,
    required this.deskripsi,
    this.imageUrl,
    this.penyemaian,
    this.penanaman,
    this.perawatan,
    this.pemanenan,
    this.penangananHama,
    this.rekomendasiPupuk,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'namaLatin': namaLatin,
        'kingdom': kingdom,
        'family': family,
        'deskripsi': deskripsi,
        'imageUrl': imageUrl,
        'penyemaian': penyemaian,
        'penanaman': penanaman,
        'perawatan': perawatan,
        'pemanenan': pemanenan,
        'penangananHama': penangananHama,
        'rekomendasiPupuk': rekomendasiPupuk
      };

  static Plant fromJson(Map<String, dynamic> json) => Plant(
        id: json['id'],
        nama: json['nama'],
        namaLatin: json['namaLatin'],
        kingdom: json['kingdom'],
        family: json['family'],
        deskripsi: json['deskripsi'],
        imageUrl: json['imageUrl'],
        penyemaian: json['penyemaian'],
        penanaman: json['penanaman'],
        perawatan: json['perawatan'],
        pemanenan: json['pemanenan'],
        penangananHama: json['penangananHama'],
        rekomendasiPupuk: json['rekomendasiPupuk'],
      );
}
