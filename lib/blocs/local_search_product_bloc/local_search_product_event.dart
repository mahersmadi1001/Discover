part of 'local_search_product_bloc.dart';

@immutable
sealed class LocalSearchProductEvent {}

class GetAllData extends LocalSearchProductEvent {}

final class SearchEvent extends LocalSearchProductEvent {
  final String query;

  SearchEvent({required this.query});
}
