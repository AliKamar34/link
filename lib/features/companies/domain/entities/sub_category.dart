import 'package:equatable/equatable.dart';

class Subcategory extends Equatable {
  final int id;
  final String name;
  final String img;

  const Subcategory({required this.id, required this.name, required this.img});

  @override
  List<Object> get props => [id, name, img];
}
