import 'package:client/features/adopt/presentation/bloc/adopt_bloc.dart';
import 'package:client/features/adopt/presentation/bloc/adopt_event.dart';
import 'package:client/features/adopt/presentation/bloc/adopt_state.dart';
import 'package:client/features/adopt/presentation/widgets/adopt_empty.dart';
import 'package:client/features/adopt/presentation/widgets/adopt_error.dart';
import 'package:client/features/adopt/presentation/widgets/adopt_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdoptPage extends StatefulWidget {
  const AdoptPage({super.key});

  @override
  State<AdoptPage> createState() => _AdoptPageState();
}

class _AdoptPageState extends State<AdoptPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AdoptBloc>(context).add(const GetAdoptEvent());
  }

  Future<void> _onRefresh() async {
    BlocProvider.of<AdoptBloc>(context).add(const GetAdoptEvent());
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdoptBloc, AdoptState>(
      builder: (context, state) {
        if (state is AdoptLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AdoptLoaded) {
          if (state.adoptRequests.isEmpty) {
            return AdoptEmptyState(onRefresh: _onRefresh);
          }
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.separated(
              itemCount: state.adoptRequests.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final adopt = state.adoptRequests[index];
                return AdoptCard(adopt: adopt);
              },
            ),
          );
        } else if (state is AdoptError) {
          return AdoptErrorState(message: state.message, onRefresh: _onRefresh);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
