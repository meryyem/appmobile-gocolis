class Chat {
  final String name;
  final String? icon;
  final bool isGroup;
  final String? time;
  final String? status;
  final String? currentMessage;
  bool select;
  int id;

  Chat({
    required this.name,
    this.icon,
    required this.isGroup,
    this.time,
    this.status,
    this.currentMessage,
    this.select = false,
    required this.id,
  });
}
