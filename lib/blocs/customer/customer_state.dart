import 'package:equatable/equatable.dart';
import 'package:laravel_rest_blog/models/customer_model.dart';

abstract class CustomerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CustomerInitial extends CustomerState {}

class CustomerLoading extends CustomerState {}

class CustomerLoaded extends CustomerState {
  final List<Customer> customers;

  CustomerLoaded(this.customers);

  @override
  List<Object?> get props => [customers];
}

class CustomerError extends CustomerState {
  final String error;

  CustomerError(this.error);

  @override
  List<Object?> get props => [error];
}
