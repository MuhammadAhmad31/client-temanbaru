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
  bool _isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        BlocProvider.of<AdoptBloc>(context).add(const GetAdoptEvent());
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isFirstLoad) {
      BlocProvider.of<AdoptBloc>(context).add(const GetAdoptEvent());
    }
    _isFirstLoad = false;
  }

  Future<void> _onRefresh() async {
    BlocProvider.of<AdoptBloc>(context).add(const GetAdoptEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdoptBloc, AdoptState>(
      builder: (context, state) {
        if (state is AdoptInitial || state is AdoptLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AdoptLoaded) {
          if (state.adoptRequests.isEmpty) {
            return AdoptEmptyState(onRefresh: _onRefresh);
          }
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text('Loading... (${state.runtimeType})'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _onRefresh,
                child: const Text('Refresh Manual'),
              ),
            ],
          ),
        );
      },
    );
  }
}
