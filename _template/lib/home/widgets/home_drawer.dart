import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnc_dao_envisagerapp/update_check/update_check.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  TextStyle get _contentTextStyle => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            BlocBuilder<UpdateCheckCubit, UpdateCheckState>(
              builder: (context, state) => _Tile(
                title: "Version",
                content: Text(
                  state.maybeWhen(
                    orElse: () => "",
                    old: (version, newVersion) => "$version | lasteast: $newVersion",
                    lastest: (version) => version,
                  ),
                  style: _contentTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.title,
    required this.content,
  });
  final String title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          content,
        ],
      ),
    );
  }
}
