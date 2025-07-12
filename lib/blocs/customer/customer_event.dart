import 'package:equatable/equatable.dart';

abstract class CustomerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCustomersEvent extends CustomerEvent {
  final int page;
  LoadCustomersEvent({this.page = 1}); // ✅ Add this constructor

  @override
  List<Object?> get props => [page];
}
