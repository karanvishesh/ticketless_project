class Monument {
  final String name;
  final String id;
  final int price;
  final String location;
  final String desc;
  final String timeSlot;
  final int stars;
  final List imageUrl;

  Monument(
      {required this.name,
      required this.id,
      required this.imageUrl,
      required this.price,
      required this.location,
      required this.stars,
      required this.desc,
      required this.timeSlot});
}
