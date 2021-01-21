import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movpass_app/features/modality/domain/entities/modality.dart';
import 'package:movpass_app/features/modality/presentation/bloc/modality_bloc.dart';
import 'package:movpass_app/features/modality/presentation/bloc/modality_event.dart';
import 'package:movpass_app/features/modality/presentation/bloc/modality_state.dart';
import '../widgets/widgets.dart';

import '../../../../injection_container.dart';

class ModalityPage extends StatefulWidget {
  @override
  _ModalityPageState createState() => _ModalityPageState();
}

class _ModalityPageState extends State<ModalityPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Modalidades'),
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<ModalityBloc> buildBody(BuildContext context) {
    return BlocProvider(

      builder: (_) => sl<ModalityBloc>()..dispatch(GetForAllModalities()),
      child: BlocBuilder<ModalityBloc, ModalityState>(
          builder: (context, state) {
            if (state is Empty) {
              return const MessageDisplay(message: 'Empty');
            } else if (state is Loading) {
              return const LoadingWidget();
            } else if (state is Error) {
              return MessageDisplay(message: state.message);
            } else if (state is LoadedAll) {
              return ModalitiesDisplay(modalities: state.modalities);
            }

            return Container(
              color: Colors.blue,
            );
          }),
    );
  }


}


