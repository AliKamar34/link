import 'package:equatable/equatable.dart';

class Pagination extends Equatable {
  final int currentPage;
  final int lastPage;
  final int total;
  final bool hasNextPage;

  const Pagination({
    required this.currentPage,
    required this.lastPage,
    required this.total,
    required this.hasNextPage,
  });

  @override
  List<Object> get props => [currentPage, lastPage, total, hasNextPage];
}
