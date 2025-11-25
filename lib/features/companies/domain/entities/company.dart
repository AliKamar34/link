import 'package:equatable/equatable.dart';

class Company extends Equatable {
  final int id;
  final String name;
  final String type;
  final String img;
  final String desc;
  final String avgRates;
  final bool fav;
  final String location;

  const Company({
    required this.id,
    required this.name,
    required this.type,
    required this.img,
    required this.desc,
    required this.avgRates,
    required this.fav,
    required this.location,
  });

  Company copyWith({bool? fav}) {
    return Company(
      id: id,
      name: name,
      type: type,
      img: img,
      desc: desc,
      avgRates: avgRates,
      fav: fav ?? this.fav,
      location: location,
    );
  }

  @override
  List<Object> get props => [
    id,
    name,
    type,
    img,
    desc,
    avgRates,
    fav,
    location,
  ];
}
