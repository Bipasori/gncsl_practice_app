// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// abstract class RepoCubit<C extends RepoCubit<C, T, R>, T, R> extends Cubit<T> {
//   RepoCubit(super.initialState);

//   late final R repository;

//   C create(BuildContext context) {
//     repository = context.read<R>();
//     return this as C;
//   }
// }
