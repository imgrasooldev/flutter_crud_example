import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laravel_rest_blog/blocs/customer/customer_event.dart';
import 'package:laravel_rest_blog/blocs/customer/customer_state.dart';
import 'package:laravel_rest_blog/repositories/customer_repository.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final CustomerRepository customerRepository;

  CustomerBloc(this.customerRepository) : super(CustomerInitial()) {
    on<LoadCustomersEvent>((event, emit) async {
      emit(CustomerLoading());
      try {
        final customers = await customerRepository.fetchCustomers();
        emit(CustomerLoaded(customers));
      } catch (e) {
        emit(CustomerError(e.toString()));
      }
    });
  }
}
