import 'package:concept_designs/src/common.dart';
import 'package:concept_designs/src/fika_coffee/bloc/coffee_bloc.dart';
import 'package:concept_designs/src/fika_coffee/data/coffee_repository.dart';
import 'package:concept_designs/src/fika_coffee/pages/coffee_home.dart';

class FikaCoffeePage extends StatelessWidget {
  const FikaCoffeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CoffeeBloc(coffeeRepository: CoffeeRepository())
        ..add(const CoffeeLoading()),
      child: const _CoffePageView(),
    );
  }
}

class _CoffePageView extends StatelessWidget {
  const _CoffePageView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoffeeBloc, CoffeeState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        switch (state.status) {
          case CoffeeStatus.initial:
          case CoffeeStatus.loading:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case CoffeeStatus.failure:
            return const Scaffold(
              body: Center(child: Text('Something gone wrong..')),
            );
          case CoffeeStatus.loaded:
            return const CoffeeHome();
        }
      },
    );
  }
}
