import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnc_dao_envisagerapp/common/common.dart';
import 'package:gnc_dao_envisagerapp/nft/nft.dart';

class PictureDetailScreen extends StatelessWidget {
  const PictureDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PictureCubit()..getPicture()),
        BlocProvider(create: (context) => PictureCaptionGetCubit(context.read<NftRepository>())),
      ],
      child: const _PictureDetailView(),
    );
  }
}

class _PictureDetailView extends StatelessWidget {
  const _PictureDetailView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PictureCubit, PictureState>(
      listener: (context, state) => state.whenOrNull(
        cancel: Navigator.of(context).pop,
        error: (message) {
          ShowTools.of(context).snackBar(message);
          return Navigator.of(context).pop();
        },
        loaded: context.read<PictureCaptionGetCubit>().getPictureCaption,
      ),
      builder: (context, pictureState) => pictureState.maybeWhen(
        orElse: Loading.new,
        loaded: (imageFile) => Scaffold(
          appBar: AppBar(
            title: const Text(Values.appName),
            forceMaterialTransparency: true,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () => ShowTools.of(context).showFullScreen(
                  title: "Picture",
                  body: Image.file(
                    imageFile,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                child: Image.file(imageFile),
              ),
              Expanded(
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(Values.scaffoldPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(Values.scaffoldPadding),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(Values.radius),
                          ),
                          child: BlocBuilder<PictureCaptionGetCubit, PictureCaptionGetState>(
                            builder: (context, state) => state.maybeWhen(
                              orElse: () => const Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Text(
                                      "Analyzing the artwork using AI",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Loading(color: Colors.black),
                                  ],
                                ),
                              ),
                              error: (message) => Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  message,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              loaded: (caption) => Text(
                                caption,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
