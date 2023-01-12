import 'package:concept_designs/src/common.dart';
import 'package:concept_designs/src/travy/models/destination.dart';
import 'package:concept_designs/src/travy/pages/destination_details_page.dart';
import 'package:ionicons/ionicons.dart';

class PopularDestinationItem extends StatelessWidget {
  const PopularDestinationItem({
    super.key,
    required this.destination,
    this.width = 250,
    this.height = 300,
  });

  final Destination destination;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _FavoriteButton(isFavorit: destination.isFavorit),
        ClipPath(
          clipper: _ItemPathClipper(),
          child: _ItemContent(
            destination: destination,
            width: width,
            height: height,
          ),
        ),
      ],
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton({required this.isFavorit});

  final bool isFavorit;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      top: 0,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: Colors.white,
        ),
        child: Icon(
          isFavorit ? Icons.favorite : Icons.favorite_border,
          color: isFavorit ? Colors.red : Colors.grey.shade300,
        ),
      ),
    );
  }
}

class _ItemContent extends StatelessWidget {
  const _ItemContent({
    required this.destination,
    required this.width,
    required this.height,
  });

  final Destination destination;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(
        page: DestinationDetailsPage(destination: destination),
      ),
      child: Container(
        color: Colors.white,
        height: height,
        width: width,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Image.asset(
                destination.imagePath,
                fit: BoxFit.cover,
                width: double.maxFinite,
              ),
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      destination.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Icon(
                          Ionicons.location_outline,
                          color: Colors.blue,
                          size: 20,
                        ),
                        Text(
                          destination.localization,
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ItemPathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final h = size.height;
    final w = size.width;
    const radius = 24.0;
    const gap = 60.0;

    final path = Path()
      ..moveTo(0, radius)
      ..quadraticBezierTo(0, 0, radius, 0)
      ..lineTo(w - gap - radius, 0)
      ..quadraticBezierTo(w - gap, 0, w - gap, gap / 2)
      ..quadraticBezierTo(
        w - gap + radius / 6,
        gap - radius / 6,
        w - gap / 2,
        gap,
      )
      ..quadraticBezierTo(w, gap, w, gap + radius)
      ..lineTo(w, h - radius)
      ..quadraticBezierTo(w, h, w - radius, h)
      ..lineTo(radius, h)
      ..quadraticBezierTo(0, h, 0, h - radius)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
