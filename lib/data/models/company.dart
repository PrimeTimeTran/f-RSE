import 'package:freezed_annotation/freezed_annotation.dart';

part 'company.freezed.dart';
part 'company.g.dart';

@freezed
class Company with _$Company {
  factory Company({
    required int id,
    required int ec,
    required String hq,
    required String eh,
    required String sym,
    required DateTime f,
    required String ceo,
    required String name,
    required String industry,
    required String desc,
  }) = _Company;

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  factory Company.defaultCompany() => Company(
    ec: 0,
    id: 0,
    hq: '',
    eh: '',
    sym: '',
    ceo: '',
    name: '',
    desc: '',
    industry: '',
    f: DateTime(1900, 1, 1),
  );
}

