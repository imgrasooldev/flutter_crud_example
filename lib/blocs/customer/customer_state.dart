import 'package:equatable/equatable.dart';
import 'package:laravel_rest_blog/models/customer_model.dart';

abstract class CustomerState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial empty state
class CustomerInitial extends CustomerState {}

// When loading data
class CustomerLoading extends CustomerState {}

// When data is loaded successfully
class CustomerLoaded extends CustomerState {
  final List<Customer> customers;

  CustomerLoaded(this.customers);

  @override
  List<Object?> get props => [customers];
}

// When an error occurs
class CustomerError extends CustomerState {
  final String message;

  CustomerError(this.message);

  @override
  List<Object?> get props => [message];
}
