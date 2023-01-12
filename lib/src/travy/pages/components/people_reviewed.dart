import 'package:concept_designs/src/common.dart';

class PeopleReviewed extends StatelessWidget {
  const PeopleReviewed({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(
          3,
          (index) => _StackItem(
            offset: index * 20,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          'People Reviewed',
          style: TextStyle(color: Colors.grey[500]),
        )
      ],
    );
  }
}

class _StackItem extends StatelessWidget {
  const _StackItem({this.offset = 0});

  final double offset;

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 22,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: 20,
        backgroundImage: AssetImage(
          'assets/travy/women.jpg',
        ),
      ),
    );
  }
}
