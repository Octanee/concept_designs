import 'package:concept_designs/src/common.dart';
import 'package:concept_designs/src/nike_store/nike_store_page.dart';

class NikeStore extends StatelessWidget {
  const NikeStore({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: NikeStorePage(),
    );
  }
}
