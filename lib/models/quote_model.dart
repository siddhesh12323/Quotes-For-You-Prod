class QuoteModel {
  String? _q;
  String? _a;
  String? _h;

  QuoteModel({String? q, String? a, String? h}) {
    if (q != null) {
      this._q = q;
    }
    if (a != null) {
      this._a = a;
    }
    if (h != null) {
      this._h = h;
    }
  }

  String? get q => _q;
  set q(String? q) => _q = q;
  String? get a => _a;
  set a(String? a) => _a = a;
  String? get h => _h;
  set h(String? h) => _h = h;

  QuoteModel.fromJson(Map<String, dynamic> json) {
    _q = json['q'];
    _a = json['a'];
    _h = json['h'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['q'] = this._q;
    data['a'] = this._a;
    data['h'] = this._h;
    return data;
  }
}
