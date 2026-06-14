import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeDashboard extends ConsumerStatefulWidget {
  const HomeDashboard({super.key});

  @override
  ConsumerState<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends ConsumerState<HomeDashboard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadDashboardData());
  }

  void _loadDashboardData() {
    final role = ref.read(authProvider).user?.role ?? '';

    if (role == Roles.superAdmin) {
      ref.read(clinicProvider.notifier).getClinics();
      return;
    }

    if (role == Roles.adminClinic || role == Roles.professional) {
      ref.read(appointmentProvider.notifier).getAppointments(
            filter: AppointmentFilter.initial(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final role = ref.watch(authProvider).user?.role ?? '';

    return switch (role) {
      Roles.superAdmin => _SuperAdminDashboard(onRefresh: _loadDashboardData),
      Roles.adminClinic => _ReceptionDashboard(onRefresh: _loadDashboardData),
      Roles.professional => _ProfessionalDashboard(onRefresh: _loadDashboardData),
      _ => _DefaultDashboard(onRefresh: _loadDashboardData),
    };
  }
}

class _DefaultDashboard extends ConsumerWidget {
  final VoidCallback onRefresh;

  const _DefaultDashboard({required this.onRefresh});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(
          bottom: CustomBottomNavigationBar.scrollBottomPadding(context),
        ),
        children: const [],
      ),
    );
  }
}

class _SuperAdminDashboard extends ConsumerWidget {
  final VoidCallback onRefresh;

  const _SuperAdminDashboard({required this.onRefresh});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clinicState = ref.watch(clinicProvider);
    final clinics = clinicState.clinics;
    final activeClinics = clinics.where((clinic) => clinic.isActive).length;

    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(
          bottom: CustomBottomNavigationBar.scrollBottomPadding(context),
        ),
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: DashboardStatCard(
                    icon: FontAwesomeIcons.hospital.data,
                    label: 'Clínicas registradas',
                    value: '${clinics.length}',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DashboardStatCard(
                    icon: FontAwesomeIcons.circleCheck.data,
                    label: 'Clínicas activas',
                    value: '$activeClinics',
                    accentColor: AppColors.successBackground,
                  ),
                ),
              ],
            ),
          ),
          _DashboardSectionTitle(title: 'Clínicas'),
          if (clinicState.isLoading && clinics.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: CustomLoadingWidget(
                message: 'Cargando clínicas...',
                spinnerSize: 56,
              ),
            )
          else if (clinics.isEmpty)
            _DashboardEmptyState(
              message: 'Aún no hay clínicas registradas',
              icon: FontAwesomeIcons.hospital.data,
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  for (final clinic in clinics.take(5))
                    _ClinicOverviewTile(
                      clinic: clinic,
                      onTap: () => context.push('/clinic-screen'),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _ReceptionDashboard extends ConsumerWidget {
  final VoidCallback onRefresh;

  const _ReceptionDashboard({required this.onRefresh});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientState = ref.watch(patientProvider);
    final doctorsState = ref.watch(doctorsProvider);
    final appointmentState = ref.watch(appointmentProvider);

    final todayAppointments = appointmentState.appointments;
    final activePatients =
        patientState.patients.where((patient) => patient.isActive).length;
    final activeDoctors =
        doctorsState.doctors.where((doctor) => doctor.isActive).length;
    final pendingAppointments = todayAppointments
        .where((appointment) => appointment.status.toUpperCase() == 'PENDING')
        .length;

    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(
          bottom: CustomBottomNavigationBar.scrollBottomPadding(context),
        ),
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: DashboardStatCard(
                    icon: FontAwesomeIcons.calendarCheck.data,
                    label: 'Citas hoy',
                    value: '${todayAppointments.length}',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DashboardStatCard(
                    icon: FontAwesomeIcons.users.data,
                    label: 'Pacientes activos',
                    value: '$activePatients',
                    accentColor: AppColors.infoBackground,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: DashboardStatCard(
                    icon: FontAwesomeIcons.userDoctor.data,
                    label: 'Doctores activos',
                    value: '$activeDoctors',
                    accentColor: AppColors.secondaryButton,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DashboardStatCard(
                    icon: FontAwesomeIcons.clock.data,
                    label: 'Pendientes hoy',
                    value: '$pendingAppointments',
                    accentColor: AppColors.warningBackground,
                  ),
                ),
              ],
            ),
          ),
          _DashboardSectionTitle(title: 'Citas de hoy'),
          if (appointmentState.isLoading && todayAppointments.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: CustomLoadingWidget(
                message: 'Cargando citas de hoy...',
                spinnerSize: 56,
              ),
            )
          else if (todayAppointments.isEmpty)
            _DashboardEmptyState(
              message: 'No hay citas programadas para hoy',
              icon: FontAwesomeIcons.calendarDays.data,
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  for (final appointment in todayAppointments.take(5))
                    DashboardAppointmentTile(
                      appointment: appointment,
                      onTap: () => context.push(
                        '/appointment-screen/${appointment.id}',
                      ),
                    ),
                  if (todayAppointments.length > 5)
                    TextButton(
                      onPressed: () => context.push('/appointment-screen'),
                      child: const Text('Ver todas las citas'),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _ProfessionalDashboard extends ConsumerWidget {
  final VoidCallback onRefresh;

  const _ProfessionalDashboard({required this.onRefresh});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(authProvider).user?.id ?? '';
    final appointmentState = ref.watch(appointmentProvider);

    final myAppointments = appointmentState.appointments
        .where((appointment) => appointment.professionalId.id == userId)
        .toList();
    final pendingAppointments = myAppointments
        .where((appointment) => appointment.status.toUpperCase() == 'PENDING')
        .length;
    final confirmedAppointments = myAppointments
        .where((appointment) {
          final status = appointment.status.toUpperCase();
          return status == 'CONFIRMED' ||
              status == 'ATTENDED' ||
              status == 'COMPLETED';
        })
        .length;

    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(
          bottom: CustomBottomNavigationBar.scrollBottomPadding(context),
        ),
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: DashboardStatCard(
                    icon: FontAwesomeIcons.calendarCheck.data,
                    label: 'Mis citas hoy',
                    value: '${myAppointments.length}',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DashboardStatCard(
                    icon: FontAwesomeIcons.clock.data,
                    label: 'Pendientes',
                    value: '$pendingAppointments',
                    accentColor: AppColors.warningBackground,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DashboardStatCard(
              icon: FontAwesomeIcons.circleCheck.data,
              label: 'Confirmadas o atendidas',
              value: '$confirmedAppointments',
              accentColor: AppColors.successBackground,
            ),
          ),
          _DashboardSectionTitle(title: 'Mi agenda de hoy'),
          if (appointmentState.isLoading && myAppointments.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: CustomLoadingWidget(
                message: 'Cargando tu agenda...',
                spinnerSize: 56,
              ),
            )
          else if (myAppointments.isEmpty)
            _DashboardEmptyState(
              message: 'No tienes citas programadas para hoy',
              icon: FontAwesomeIcons.calendarDays.data,
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  for (final appointment in myAppointments.take(5))
                    DashboardAppointmentTile(
                      appointment: appointment,
                      showProfessional: false,
                      onTap: () => context.push(
                        '/appointment-screen/${appointment.id}',
                      ),
                    ),
                  if (myAppointments.length > 5)
                    TextButton(
                      onPressed: () => context.push('/appointment-screen'),
                      child: const Text('Ver todas mis citas'),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _DashboardSectionTitle extends StatelessWidget {
  final String title;

  const _DashboardSectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _DashboardEmptyState extends StatelessWidget {
  final String message;
  final IconData icon;

  const _DashboardEmptyState({
    required this.message,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.secondaryBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: AppColors.secondary.withValues(alpha: 0.45),
              size: 28,
            ),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textPrimary.withValues(alpha: 0.65),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ClinicOverviewTile extends StatelessWidget {
  final ListClinic clinic;
  final VoidCallback? onTap;

  const _ClinicOverviewTile({
    required this.clinic,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.secondaryBackground,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.secondary.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.secondaryButton.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                FontAwesomeIcons.hospital.data,
                color: AppColors.secondary,
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    clinic.name,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    clinic.city?.trim().isNotEmpty == true
                        ? clinic.city!.trim()
                        : 'Sin ciudad registrada',
                    style: TextStyle(
                      color: AppColors.textPrimary.withValues(alpha: 0.65),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            StatusBadge(
              label: clinic.isActive ? 'Activa' : 'Inactiva',
              accentColor: clinic.isActive
                  ? AppColors.successBackground
                  : AppColors.disabledBackground,
            ),
          ],
        ),
      ),
    );
  }
}
