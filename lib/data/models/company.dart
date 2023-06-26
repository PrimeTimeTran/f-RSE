import 'dart:convert';

import 'package:rse/data/models/all.dart';

class Company {
  int id;
  int ec;
  DateTime f;
  String hq;
  String ceo;
  String eh;
  String sym;
  String name;
  String industry;
  String description;

  Company({
    required this.ec,
    required this.f,
    required this.hq,
    required this.ceo,
    required this.eh,
    required this.sym,
    required this.name,
    required this.id,
    required this.industry,
    required this.description,
  });

  factory Company.fromJSON(Map<String, dynamic> json) {
    return Company(
      ec: json['ec'],
      f: DateTime.parse(json['f']),
      hq: json['hq'],
      ceo: json['ceo'],
      eh: json['eh'],
      sym: json['sym'],
      name: json['name'],
      id: json['id'],
      industry: json['industry'],
      description: json['description'],
    );
  }

  factory Company.defaultCompany() {
    return Company(
      ec: 0,
      f: DateTime(1900, 1, 1),
      hq: '',
      ceo: '',
      eh: '',
      sym: '',
      name: '',
      id: 0,
      industry: '',
      description: '',
    );
  }
}
