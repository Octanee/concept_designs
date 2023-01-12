import 'package:concept_designs/src/common.dart';
import 'package:concept_designs/src/travy/bloc/destination_bloc.dart';
import 'package:concept_designs/src/travy/models/category.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({super.key, required this.category});

  final DestinationCategory category;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DestinationBloc, DestinationState>(
      buildWhen: (previous, current) => previous.category != current.category,
      builder: (context, state) {
        final isSelected = state.category == category;
        return GestureDetector(
          onTap: () {
            context
                .read<DestinationBloc>()
                .add(DestinationCategoryChange(category: category));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: isSelected ? Colors.blue : Colors.grey.shade200,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  category.path,
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  category.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white70 : Colors.grey.shade700,
                    fontSize: 12,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
