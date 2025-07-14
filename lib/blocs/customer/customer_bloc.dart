import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laravel_rest_blog/blocs/customer/customer_event.dart';
import 'package:laravel_rest_blog/blocs/customer/customer_state.dart';
import 'package:laravel_rest_blog/repositories/customer_repository.dart';
import 'package:laravel_rest_blog/models/customer_model.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final CustomerRepository customerRepository;

  int currentPage = 1;
  bool isLoadingMore = false;
  List<Customer> allCustomers = [];

  CustomerBloc(this.customerRepository) : super(CustomerInitial()) {
    on<LoadCustomersEvent>((event, emit) async {
      if (event.page == 1) {
        emit(CustomerLoading());
      } else {
        isLoadingMore = true;
      }

      try {
        final customers = await customerRepository.fetchCustomers(
          page: event.page,
        );

        if (event.page == 1) {
          allCustomers = customers;
        } else {
          allCustomers += customers;
        }

        currentPage = event.page;
        emit(CustomerLoaded(List.from(allCustomers)));
      } catch (e) {
        emit(CustomerError(e.toString()));
      } finally {
        isLoadingMore = false;
      }
    });
  }
}
