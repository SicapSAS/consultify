import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DoctorsView extends ConsumerWidget {
  const DoctorsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(doctorsProvider);

    if (state.isLoading && state.doctors.isEmpty) {
      return const CustomLoadingWidget(
        message: 'Cargando doctores...',
      );
    }

    if (state.errorMessage.isNotEmpty && state.doctors.isEmpty) {
      return CustomErrorStateWidget(
        message: state.errorMessage,
        onRetry: () => ref.read(doctorsProvider.notifier).getDoctors(),
      );
    }

    if (state.doctors.isEmpty) {
      return CustomRefreshableContent(
        onRefresh: () => ref.read(doctorsProvider.notifier).getDoctors(),
        isRefreshing: state.isLoading,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            CustomEmptyStateWidget(
              message: 'No hay doctores registrados',
              icon: FontAwesomeIcons.userDoctor.data,
              iconColor: AppColors.secondary.withValues(alpha: 0.5),
            ),
          ],
        ),
      );
    }

    return CustomRefreshableContent(
      onRefresh: () => ref.read(doctorsProvider.notifier).getDoctors(),
      isRefreshing: state.isLoading,
      child: DoctorList(
        doctors: state.doctors,
      ),
    );
  }
}
