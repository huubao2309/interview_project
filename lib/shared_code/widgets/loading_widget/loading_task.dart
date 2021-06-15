import 'package:flutter/material.dart';
import 'package:interview_project/base/base_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

import 'loading_item.dart';

class LoadingTask extends StatelessWidget {
  const LoadingTask({
    required this.child,
    required this.bloc,
  });

  final Widget child;
  final BaseBloc bloc;

  @override
  Widget build(BuildContext context) {
    return StreamProvider<bool>.value(
      value: bloc.loadingStream,
      initialData: false,
      child: Stack(
        children: <Widget>[
          child,
          Consumer<bool>(
            builder: (context, isLoading, child) => Center(
              child: isLoading ? LoadingItemWidget() : Container(),
            ),
          ),
        ],
      ),
    );
  }
}
