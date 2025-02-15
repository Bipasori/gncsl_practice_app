import 'package:flutter/material.dart';
import 'package:gnc_dao_envisagerapp/common/common.dart';
import 'package:gnc_dao_envisagerapp/nft/nft.dart';

class NftImageTile extends StatelessWidget {
  const NftImageTile(
    this.nft, {
    super.key,
  });
  final NftSummaryModel nft;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NftDetailScreen(nft),
          ),
        ),
        borderRadius: BorderRadius.circular(Values.radius),
        child: Ink(
          padding: const EdgeInsets.all(4).copyWith(bottom: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Values.radius),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Values.radius),
                child: Container(
                  color: Colors.black,
                  child: Hero(
                    tag: "nft_image_${nft.id}",
                    child: Image.network(
                      nft.imageUrl,
                      loadingBuilder: (context, child, loadingProgress) => loadingProgress == null
                          ? child
                          : const AspectRatio(
                              aspectRatio: 1,
                              child: Loading(),
                            ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                nft.tokenName,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                nft.artistName,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
