class GetListClinic {
  final int total;
  final List<ListClinic> clinics;

  GetListClinic({
    required this.total,
    required this.clinics,
  });
}



class ListClinic {
    final String id;
    final String name;
    final String? nit;
    final String? streetAddress;
    final String? city;
    final String phone;
    final String? email;
    final bool isActive;
    final DateTime createdAt;
    final int v;
    final String? address;

    ListClinic({
        required this.id,
        required this.name,
        this.nit,
        this.streetAddress,
        this.city,
        required this.phone,
        this.email,
        required this.isActive,
        required this.createdAt,
        required this.v,
        this.address,
    });

}
