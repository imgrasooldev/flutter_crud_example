import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:laravel_rest_blog/blocs/customer/customer_bloc.dart';
import 'package:laravel_rest_blog/blocs/customer/customer_event.dart';
import 'package:laravel_rest_blog/blocs/customer/customer_state.dart';
import 'package:laravel_rest_blog/models/customer_model.dart';   // ←  یہ امپورٹ بھی رکھیں

/// 🔹 StatefulWidget کی تعریف غائب تھی—یہ شامل کریں
class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  final ScrollController _scrollController = ScrollController();

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      final bloc = context.read<CustomerBloc>();
      if (!bloc.isLoadingMore) {
        bloc.add(LoadCustomersEvent(page: bloc.currentPage + 1));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<CustomerBloc>().add(LoadCustomersEvent());
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Customers')),
      body: BlocBuilder<CustomerBloc, CustomerState>(
        builder: (context, state) {
          if (state is CustomerLoading && state is! CustomerLoaded) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CustomerLoaded) {
            final List<Customer> customers = state.customers;
            return ListView.separated(
              controller: _scrollController,
              itemCount: customers.length + 1,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                // infinite‑scroll footer
                if (index == customers.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final c = customers[index];
                return ListTile(
                  leading: CircleAvatar(child: Text(c.name[0])),
                  title: Text(c.name),
                  subtitle: Text('${c.email}\n${c.city}, ${c.state}'),
                  isThreeLine: true,
                  trailing: Text(c.type == 'I' ? 'Individual' : 'Business'),
                  onTap: () =>
                      Navigator.pushNamed(context, '/invoices', arguments: c.id),
                );
              },
            );
          } else if (state is CustomerError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox(); // initial empty
        },
      ),
    );
  }
}
