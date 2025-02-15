import 'package:flutter/material.dart';
import 'package:gnc_dao_envisagerapp/common/common.dart';
import 'package:gnc_dao_envisagerapp/nft/nft.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NftDetailScreen extends StatelessWidget {
  const NftDetailScreen(
    this.nftSummary, {
    super.key,
  });
  final NftSummaryModel nftSummary;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ImageCaptionGetCubit(context.read<NftRepository>())..getImageCaption(nftSummary.imageUrl)),
      ],
      child: _NftDetailView(nftSummary),
    );
  }
}

class _NftDetailView extends StatelessWidget {
  const _NftDetailView(this.nftSummary);
  final NftSummaryModel nftSummary;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Values.appName),
        forceMaterialTransparency: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Hero(
            tag: "nft_image_${nftSummary.id}",
            child: GestureDetector(
              onTap: () => ShowTools.of(context).showFullScreen(
                title: nftSummary.tokenName,
                body: Image.network(
                  nftSummary.imageUrl,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              child: Image.network(nftSummary.imageUrl),
            ),
          ),
          Expanded(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(Values.scaffoldPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: const EdgeInsets.all(Values.scaffoldPadding),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(Values.radius),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    nftSummary.tokenName,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Artist : ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          nftSummary.artistName,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => ShowTools.of(context).showFullScreen(
                                title: nftSummary.tokenName,
                                body: Image.network(
                                  nftSummary.qrcodeUrl,
                                  width: double.infinity,
                                ),
                              ),
                              child: Container(
                                height: double.infinity,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(Values.radius),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(Values.radius),
                                  child: Image.network(
                                    nftSummary.qrcodeUrl,
                                    errorBuilder: (context, error, stackTrace) => const Text(
                                      "No QRCode",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(Values.scaffoldPadding),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(Values.radius),
                      ),
                      child: BlocBuilder<ImageCaptionGetCubit, ImageCaptionGetState>(
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
    );
  }
}
