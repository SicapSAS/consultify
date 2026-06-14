import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DoctorDetailView extends ConsumerStatefulWidget {
  final String doctorId;

  const DoctorDetailView({
    super.key,
    required this.doctorId,
  });

  @override
  ConsumerState<DoctorDetailView> createState() => _DoctorDetailViewState();
}

class _DoctorDetailViewState extends ConsumerState<DoctorDetailView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(doctorsProvider.notifier).getDoctorById(widget.doctorId);
    });
  }

  bool _isCurrentDoctor(DcotorShow? doctorShow) {
    return doctorShow?.doctor.id == widget.doctorId;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(doctorsProvider);
    final doctorShow = state.selectedDoctor;
    final hasCurrentDoctor = _isCurrentDoctor(doctorShow);

    if (state.isLoading && !hasCurrentDoctor) {
      return const CustomLoadingWidget(
        message: 'Cargando doctor...',
      );
    }

    if (state.errorMessage.isNotEmpty && !hasCurrentDoctor) {
      return CustomErrorStateWidget(
        message: state.errorMessage,
        onRetry: () => ref
            .read(doctorsProvider.notifier)
            .getDoctorById(widget.doctorId),
      );
    }

    if (!hasCurrentDoctor || doctorShow == null) {
      return CustomEmptyStateWidget(
        message: 'No se encontró información del doctor',
        icon: FontAwesomeIcons.userDoctor.data,
        iconColor: AppColors.secondary.withValues(alpha: 0.5),
      );
    }

    return CustomRefreshableContent(
      onRefresh: () => ref
          .read(doctorsProvider.notifier)
          .getDoctorById(widget.doctorId),
      isRefreshing: state.isLoading,
      child: DoctorDetailBody(doctorShow: doctorShow),
    );
  }
}
