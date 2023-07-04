import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/all.dart';

class ArrowBackButton extends StatelessWidget {
  final String screenCode;
  final String root;
  const ArrowBackButton({super.key, required this.screenCode, required this.root});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            BlocProvider.of<NavBloc>(context).add(NavChanged(screenCode));
            context.go(root);
          },
        );
      },
    );
  }
}
