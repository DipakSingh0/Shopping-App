
import 'package:shop/views/shared/export.dart';

class NewShoes extends StatelessWidget {
  const NewShoes({
    super.key,
    required this.screenSize,
    required this.imageUrl,
  });

  final Size screenSize;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 1,
              blurRadius: 0.8,
              offset: Offset(0, 1),
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(16))),
      height: screenSize.height * 0.12,
      width: screenSize.width * 0.28,
      child:
          // Image(image: AssetImage('lib/assets/images/shoe1.png'))
          // Image.network('https://picsum.photos/200/300', fit: BoxFit.fill),
          ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
