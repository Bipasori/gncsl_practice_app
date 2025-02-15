import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnc_dao_envisagerapp/api/api.dart';
import 'package:gnc_dao_envisagerapp/common/common.dart';
import 'package:gnc_dao_envisagerapp/gen/gen.dart';
import 'package:gnc_dao_envisagerapp/home/screens/home_screen.dart';
import 'package:gnc_dao_envisagerapp/nft/nft.dart';
import 'package:gnc_dao_envisagerapp/update_check/update_check.dart';
import 'package:provider/provider.dart';

void main() {
  Bloc.observer = EnvisagerBlocObserver();

  runApp(const Envisager());
}

class Envisager extends StatelessWidget {
  const Envisager({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Client.setLogoutCallback(() => log("Logout"));
    return Provider(
      create: (context) => Client.instance,
      child: _RepositoriesProvider(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => UpdateCheckCubit()..check(), lazy: false),
          ],
          child: MaterialApp(
            title: Values.appName,
            debugShowCheckedModeBanner: false,
            theme: FlexThemeData.dark(
              scheme: FlexScheme.greys,
              fontFamily: FontFamily.urbanist,
              fontFamilyFallback: [FontFamily.gothicA1],
            ).copyWith(
              appBarTheme: const AppBarTheme(
                centerTitle: true,
                titleTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              listTileTheme: const ListTileThemeData(
                titleTextStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: FontFamily.urbanist,
                  fontSize: 20,
                ),
                subtitleTextStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: FontFamily.urbanist,
                  fontSize: 14,
                ),
              ),
            ),
            home: BlocListener<UpdateCheckCubit, UpdateCheckState>(
              listener: (context, state) => state.whenOrNull(
                old: (version, newVersion) => context.read<UpdateCheckCubit>().update(),
              ),
              child: const HomeScreen(),
            ),
          ),
        ),
      ),
    );
  }
}

class _RepositoriesProvider extends StatelessWidget {
  const _RepositoriesProvider({
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => NftRepository(context.read<Dio>())),
      ],
      child: child,
    );
  }
}
