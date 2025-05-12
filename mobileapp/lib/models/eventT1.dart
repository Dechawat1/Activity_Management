class Event {
  final String title;
  final String? description;
  final DateTime from;
  final DateTime to;
  final bool isAllDay;
  final String id;
  Event({
    required this.title,
    this.description,
    required this.from,
    required this.to,
    required this.id,
    this.isAllDay = false,
  });
}
