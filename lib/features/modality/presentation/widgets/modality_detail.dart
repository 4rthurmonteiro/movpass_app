import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movpass_app/features/modality/presentation/bloc/bloc.dart';
import 'package:movpass_app/features/modality/presentation/bloc/modality_bloc.dart';

import '../../../../injection_container.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/message_display.dart';
import 'modalities_display.dart';
import 'modality_display.dart';

class ModalityDetail extends StatefulWidget {
  final String idString;

  const ModalityDetail({Key key, @required this.idString}) : super(key: key);
  @override
  _ModalityDetailState createState() => _ModalityDetailState();
}

class _ModalityDetailState extends State<ModalityDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Modalidade'),
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<ModalityBloc> buildBody(BuildContext context) {
    return BlocProvider(

      builder: (_) => sl<ModalityBloc>()..dispatch(GetModalityForId(widget.idString)),
      child: BlocBuilder<ModalityBloc, ModalityState>(
          builder: (context, state) {
            if (state is Empty) {
              return const MessageDisplay(message:'Empty');
            } else if (state is Loading) {
              return const LoadingWidget();
            } else if (state is Error) {
              return MessageDisplay(message: state.message);
            } else if (state is Loaded) {
              return ModalityDisplay(modality: state.modality);
            }


            return Container(
              color: Colors.blue,
            );
          }),
    );
  }


}