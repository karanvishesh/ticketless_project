class Monument {
  final String name;
  final String id;
  final String imageUrl;
  final int price;
  final String location;
  final String desc;
  final String timeSlot;

  Monument(
      {required this.name,
      required this.id,
      required this.imageUrl,
      required this.price,
      required this.location,
      required this.desc,
      required this.timeSlot});
}
