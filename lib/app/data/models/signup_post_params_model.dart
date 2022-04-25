class SignupPostParams {
  String? regional;
  String? witel;
  String? unit;
  String? cProfile;
  String? nama;
  String? userId;
  String? pass;
  String? passRepeat;

  SignupPostParams(
      {this.regional,
      this.witel,
      this.unit,
      this.cProfile,
      this.nama,
      this.userId,
      this.pass,
      this.passRepeat});

  SignupPostParams.fromJson(Map<String, dynamic> json) {
    regional = json['regional'];
    witel = json['witel'];
    unit = json['unit'];
    cProfile = json['c_profile'];
    nama = json['nama'];
    userId = json['user_id'];
    pass = json['pass'];
    passRepeat = json['pass_repeat'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['regional'] = regional;
    data['witel'] = witel;
    data['unit'] = unit;
    data['c_profile'] = cProfile;
    data['nama'] = nama;
    data['user_id'] = userId;
    data['pass'] = pass;
    data['pass_repeat'] = passRepeat;
    return data;
  }
}
