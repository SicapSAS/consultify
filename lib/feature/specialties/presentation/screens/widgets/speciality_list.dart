import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

class SpecialtiesList extends StatelessWidget {
  final List<Specialty> specialties;

  const SpecialtiesList({
    super.key,
    required this.specialties,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        CustomBottomNavigationBar.scrollBottomPadding(
          context,
          withFloatingActionButton: true,
        ),
      ),
      itemCount: specialties.length,
      separatorBuilder: (context, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return SpecialityCard(specialty: specialties[index]);
      },
    );
  }
}
