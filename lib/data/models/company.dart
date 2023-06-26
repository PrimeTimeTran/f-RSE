class Company {
  int id;
  int ec;
  String hq;
  String eh;
  String sym;
  DateTime f;
  String ceo;
  String name;
  String industry;
  String description;

  Company({
    required this.f,
    required this.eh,
    required this.id,
    required this.ec,
    required this.hq,
    required this.ceo,
    required this.sym,
    required this.name,
    required this.industry,
    required this.description,
  });

  factory Company.fromJSON(Map<String, dynamic> json) {
    return Company(
      ec: json['ec'],
      hq: json['hq'],
      id: json['id'],
      eh: json['eh'],
      ceo: json['ceo'],
      sym: json['sym'],
      name: json['name'],
      industry: json['industry'],
      f: DateTime.parse(json['f']),
      description: json['description'],
    );
  }

  factory Company.defaultCompany() {
    return Company(
      ec: 0,
      id: 0,
      hq: '',
      eh: '',
      sym: '',
      ceo: '',
      name: '',
      industry: '',
      description: '',
      f: DateTime(1900, 1, 1),
    );
  }
}
