import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

class PatientAppointmentsSection extends StatefulWidget {
  final PatientShow history;

  const PatientAppointmentsSection({
    super.key,
    required this.history,
  });

  @override
  State<PatientAppointmentsSection> createState() =>
      _PatientAppointmentsSectionState();
}

class _PatientAppointmentsSectionState extends State<PatientAppointmentsSection>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<AppointmentDetail> _allAppointments() {
    if (widget.history.appointments.isNotEmpty) {
      return widget.history.appointments;
    }

    final seen = <String>{};
    final result = <AppointmentDetail>[];

    for (final appointment in [
      ...widget.history.upcoming,
      ...widget.history.past,
    ]) {
      if (seen.add(appointment.id)) {
        result.add(appointment);
      }
    }

    return result;
  }

  bool _isAttended(String status) {
    final normalizedStatus = status.toUpperCase();
    return normalizedStatus == 'ATTENDED' || normalizedStatus == 'COMPLETED';
  }

  bool _isCancelled(String status) {
    final normalizedStatus = status.toUpperCase();
    return normalizedStatus == 'CANCELLED' ||
        normalizedStatus == 'NOT_ATTENDED';
  }

  List<AppointmentDetail> _appointmentsForTab(int index) {
    switch (index) {
      case 0:
        return List<AppointmentDetail>.from(widget.history.upcoming)
          ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
      case 1:
        return _allAppointments()
            .where((appointment) => _isAttended(appointment.status))
            .toList()
          ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
      case 2:
        return _allAppointments()
            .where((appointment) => _isCancelled(appointment.status))
            .toList()
          ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
      default:
        return [];
    }
  }

  String _emptyMessageForTab(int index) {
    switch (index) {
      case 0:
        return 'No hay citas próximas';
      case 1:
        return 'No hay citas atendidas';
      case 2:
        return 'No hay citas canceladas';
      default:
        return 'No hay citas';
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final appointments = _appointmentsForTab(_tabController.index);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Citas',
          style: TextStyle(
            fontSize: size.width * 0.04,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: size.height * 0.012),
        Container(
          decoration: BoxDecoration(
            color: AppColors.secondaryBackground,
            borderRadius: BorderRadius.circular(size.width * 0.02),
          ),
          child: TabBar(
            controller: _tabController,
            labelColor: AppColors.secondary,
            unselectedLabelColor: AppColors.secondary.withValues(alpha: 0.5),
            indicatorColor: AppColors.secondaryButton,
            indicatorWeight: 3,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            tabs: const [
              Tab(text: 'Próximas'),
              Tab(text: 'Atendidas'),
              Tab(text: 'Canceladas'),
            ],
          ),
        ),
        SizedBox(height: size.height * 0.012),
        if (appointments.isEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
              vertical: size.height * 0.018,
            ),
            decoration: BoxDecoration(
              color: AppColors.secondaryBackground,
              borderRadius: BorderRadius.circular(size.width * 0.02),
            ),
            child: Text(
              _emptyMessageForTab(_tabController.index),
              style: TextStyle(
                fontSize: size.width * 0.03,
                color: AppColors.textPrimary.withValues(alpha: 0.55),
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: appointments.length,
            separatorBuilder: (context, _) => SizedBox(
              height: size.height * 0.012,
            ),
            itemBuilder: (context, index) {
              return PatientAppointmentTile(
                appointment: appointments[index],
              );
            },
          ),
      ],
    );
  }
}
