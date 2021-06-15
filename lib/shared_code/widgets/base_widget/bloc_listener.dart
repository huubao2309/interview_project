import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:interview_project/base/base_bloc.dart';
import 'package:interview_project/base/base_event.dart';

class BlocListener<T extends BaseBloc> extends StatefulWidget {
  const BlocListener({
    required this.child,
    required this.listener,
  });

  final Widget child;
  final Function(BaseEvent event) listener;

  @override
  _BlocListenerState createState() => _BlocListenerState<T>();
}

class _BlocListenerState<T> extends State<BlocListener> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final bloc = Provider.of<T>(context) as BaseBloc;
    bloc.processEventStream.listen(
      (event) {
        widget.listener(event);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<BaseEvent?>.value(
      value: (Provider.of<T>(context) as BaseBloc).processEventStream,
      initialData: null,
      updateShouldNotify: (prev, current) {
        return false;
      },
      child: Consumer<BaseEvent?>(
        builder: (context, event, child) {
          return Container(
            child: widget.child,
          );
        },
      ),
    );
  }
}
