import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/loader.dart';
import '../../../../injection_container.dart';
import 'bloc/log_view_bloc.dart';

class LogView extends StatefulWidget {
  const LogView({super.key});

  @override
  State<LogView> createState() => _LogViewState();
}

class _LogViewState extends State<LogView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LogViewBloc>(
      create: (BuildContext context) =>
          getIt<LogViewBloc>()..add(LoadLogViewDataEvent()),
      child: BlocBuilder<LogViewBloc, LogViewState>(
        builder: (BuildContext context, LogViewState state) {
          if (state is DataLoadedState) {
            return ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: state.logModel.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Column(
                      children: <Widget>[
                        Text(
                          '${state.logModel[index].id}',
                          style: TextStyle(color: Colors.grey[900]),
                        ),
                        Text(
                          '${state.logModel[index].createdAt}',
                          style: TextStyle(color: Colors.grey[800]),
                        ),
                        Text(
                          state.logModel[index].payload?.description ?? '',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        Text(
                          state.logModel[index].type ?? '',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const Divider(),
                      ],
                    ),
                  );
                });
          } else {
            return const Loader();
          }
        },
      ),
    );
  }
}
