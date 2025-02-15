import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gnc_dao_envisagerapp/common/common.dart';
import 'package:gnc_dao_envisagerapp/nft/nft.dart';

class NftMeseumListScreen extends StatefulWidget {
  const NftMeseumListScreen({super.key});

  @override
  State<NftMeseumListScreen> createState() => _NftMeseumListScreenState();
}

class _NftMeseumListScreenState extends State<NftMeseumListScreen> {
  final ScrollController _controller = ScrollController();
  bool _showCameraBar = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (!_showCameraBar && _controller.offset > 200) {
        setState(() => _showCameraBar = true);
      } else if (_showCameraBar && _controller.offset <= 200) {
        setState(() => _showCameraBar = false);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NftMuseumGetCubit, NftMuseumGetState>(
      listener: (context, state) => state.whenOrNull(
        error: (message) => SnackBar(content: SnackBar(content: Text(message))),
      ),
      builder: (context, state) => state.maybeWhen(
        orElse: SizedBox.shrink,
        loaded: (nfts) => Stack(
          children: [
            SingleChildScrollView(
              controller: _controller,
              padding: const EdgeInsets.all(Values.scaffoldPadding).copyWith(bottom: 64),
              child: StaggeredGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Material(
                      child: InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const PictureDetailScreen(),
                          ),
                        ),
                        borderRadius: BorderRadius.circular(Values.radius),
                        child: Ink(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(Values.radius),
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.black,
                            size: 64,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ...nfts.map(NftImageTile.new)
                ],
              ),
            ),
            Visibility(
              visible: _showCameraBar,
              child: Align(
                alignment: Alignment.topCenter,
                child: FilledButton.tonalIcon(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PictureDetailScreen(),
                    ),
                  ),
                  icon: const Icon(Icons.camera_alt_rounded),
                  label: const Text(
                    "Camera",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
