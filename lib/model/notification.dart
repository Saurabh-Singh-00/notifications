enum PRIORITY {
  DEFAULT,
  HIGH,
  LOW,
  MAX,
  MIN
}

extension PriorityValue on PRIORITY {

  static Map<PRIORITY, int> _map = {
    PRIORITY.DEFAULT: 0,
    PRIORITY.HIGH: 1,
    PRIORITY.LOW: -1,
    PRIORITY.MAX: 2,
    PRIORITY.MIN: -2
  };

  static Map<int, PRIORITY> _reverseMap = {
    0: PRIORITY.DEFAULT,
    1: PRIORITY.HIGH,
    -1: PRIORITY.LOW,
    2: PRIORITY.MAX,
    -2: PRIORITY.MIN
  };

  // Decode Dart enum to Android PRIORITY int
  int? get value {
    return _map[this];
  }

  PRIORITY? fromInt(int value) {
    return _reverseMap[value];
  }
}

class ProxyNotification {
  final String title;
  final String contentText;
  late PRIORITY priority;

  ProxyNotification({required this.title, required this.contentText, this.priority = PRIORITY.DEFAULT});

  ProxyNotification fromMap(Map<String, dynamic> map) {
    return ProxyNotification(title: map['title'], contentText: map['contentText'], priority: map['priority']);
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "contentText": contentText,
      "priority": priority.value
    };
  }
}