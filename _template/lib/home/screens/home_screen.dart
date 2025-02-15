import 'package:flutter/material.dart';
import 'package:gnc_dao_envisagerapp/common/common.dart';
import 'package:gnc_dao_envisagerapp/home/home.dart';
import 'package:gnc_dao_envisagerapp/nft/nft.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NftMuseumGetCubit(context.read<NftRepository>())..getNftMeseum()),
      ],
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Values.appName),
        forceMaterialTransparency: true,
      ),
      endDrawer: const HomeDrawer(),
      body: BlocConsumer<NftMuseumGetCubit, NftMuseumGetState>(
        listener: (context, state) => state.whenOrNull(
          error: print,
        ),
        builder: (context, getMuseumState) => getMuseumState.maybeWhen(
          loading: Loading.new,
          orElse: () => RefreshIndicator(
            onRefresh: () => refresh(context),
            child: const NftMeseumListScreen(),
          ),
        ),
      ),
    );
  }

  Future<void> refresh(BuildContext context) async {
    await context.read<NftMuseumGetCubit>().getNftMeseum();
  }
}
