import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:laravel_rest_blog/blocs/auth/auth_bloc.dart';
import 'package:laravel_rest_blog/blocs/customer/customer_bloc.dart';

import 'package:laravel_rest_blog/repositories/auth_repository.dart';
import 'package:laravel_rest_blog/repositories/customer_repository.dart';

import 'package:laravel_rest_blog/screens/auth/login_screen.dart';
import 'package:laravel_rest_blog/screens/home/home_screen.dart';
import 'package:laravel_rest_blog/screens/customers/customer_list_screen.dart';
import 'package:laravel_rest_blog/screens/invoices/invoice_list_screen.dart'; // ✅ NEW

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(AuthRepository())),
        BlocProvider(create: (_) => CustomerBloc(CustomerRepository())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (_) => LoginScreen(),
          '/home': (_) => HomeScreen(),
          '/customers': (_) => CustomerListScreen(),
          '/invoices': (_) => InvoiceListScreen(),
        },
      ),
    );
  }
}
