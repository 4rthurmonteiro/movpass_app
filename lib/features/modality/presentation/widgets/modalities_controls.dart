import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movpass_app/features/modality/presentation/bloc/modality_bloc.dart';
import 'package:movpass_app/features/modality/presentation/bloc/modality_event.dart';

class ModalitiesControls extends StatefulWidget {
  @override
  _ModalitiesControlsState createState() => _ModalitiesControlsState();
}

class _ModalitiesControlsState extends State<ModalitiesControls> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('GO'),
      color: Theme.of(context).accentColor,
      textTheme: ButtonTextTheme.primary,
      onPressed: () {
        dispatchAll();
      },
    );
  }
  void dispatchAll() {
    BlocProvider.of<ModalityBloc>(context).dispatch(GetForAllModalities());
  }
}
