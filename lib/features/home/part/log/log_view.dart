import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loader.dart';
import '../../../../injection_container.dart';
import 'bloc/log_view_bloc.dart';

class LogView extends StatelessWidget {
  const LogView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LogViewBloc>(
      create: (BuildContext context) =>
          getIt<LogViewBloc>()..add(LoadLogViewDataEvent()),
      child: BlocConsumer<LogViewBloc, LogViewState>(
        listener: (BuildContext context, LogViewState state) {},
        builder: (BuildContext context, LogViewState state) {
          if (state is DataLoadedState) {
            return const Center(child: Text('Data Loaded'));
          } else {
            return const Loader();
          }
        },
      ),
    );
  }
}
