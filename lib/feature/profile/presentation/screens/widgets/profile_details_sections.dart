import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileDetailsSections extends StatelessWidget {
  final MyProfileEntity profile;

  const ProfileDetailsSections({
    super.key,
    required this.profile,
  });

  static String roleLabel(MyProfileEntity profile) {
    if (profile.roleLabel.trim().isNotEmpty) {
      return profile.roleLabel.trim();
    }
    return Roles.toDisplayString(profile.role);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ProfileSectionTitle(
          title: 'CONTACTO',
          icon: Icons.mail_outline_rounded,
        ),
        ProfileInfoTile(
          icon: FontAwesomeIcons.envelope.data,
          label: 'Correo electrónico',
          value: profile.email,
          copyable: true,
        ),
        if (profile.clinic.phone.trim().isNotEmpty) ...[
          const SizedBox(height: 10),
          ProfileInfoTile(
            icon: FontAwesomeIcons.phone.data,
            label: 'Teléfono de la clínica',
            value: profile.clinic.phone,
            copyable: true,
          ),
        ],
        if (_documentLabel(profile).isNotEmpty) ...[
          const SizedBox(height: 10),
          ProfileInfoTile(
            icon: FontAwesomeIcons.addressCard.data,
            label: 'Documento',
            value: _documentLabel(profile),
          ),
        ],
        const SizedBox(height: 20),
        const ProfileSectionTitle(
          title: 'PROFESIONAL',
          icon: Icons.work_outline_rounded,
        ),
        ProfileInfoTile(
          icon: FontAwesomeIcons.idBadge.data,
          label: 'Rol',
          value: roleLabel(profile),
        ),
        if (profile.specialty.trim().isNotEmpty) ...[
          const SizedBox(height: 10),
          ProfileInfoTile(
            icon: FontAwesomeIcons.stethoscope.data,
            label: 'Especialidad',
            value: profile.specialty,
          ),
        ],
        if (profile.professionalCardNumber.trim().isNotEmpty) ...[
          const SizedBox(height: 10),
          ProfileInfoTile(
            icon: FontAwesomeIcons.idCard.data,
            label: 'Tarjeta profesional',
            value: profile.professionalCardNumber,
          ),
        ],
        const SizedBox(height: 20),
        const ProfileSectionTitle(
          title: 'CLÍNICA',
          icon: Icons.local_hospital_outlined,
        ),
        ProfileInfoTile(
          icon: FontAwesomeIcons.hospital.data,
          label: 'Clínica asignada',
          value: profile.clinic.name,
        ),
        const SizedBox(height: 20),
        const ProfileSectionTitle(
          title: 'CUENTA',
          icon: Icons.person_outline_rounded,
        ),
        ProfileInfoTile(
          icon: FontAwesomeIcons.calendarDays.data,
          label: 'Miembro desde',
          value: profile.createdAtFormatted.trim().isNotEmpty
              ? profile.createdAtFormatted
              : _formatDate(profile.createdDate),
        ),
      ],
    );
  }

  String _documentLabel(MyProfileEntity profile) {
    final type = profile.documentType.trim();
    final id = profile.documentId.trim();
    if (type.isEmpty && id.isEmpty) return '';
    if (type.isEmpty) return id;
    if (id.isEmpty) return type;
    return '$type · $id';
  }

  String _formatDate(DateTime date) {
    const months = [
      'ene', 'feb', 'mar', 'abr', 'may', 'jun',
      'jul', 'ago', 'sep', 'oct', 'nov', 'dic',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
