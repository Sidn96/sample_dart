class LocalCacheManager {

  final Map<String, DateTime> _expiryMap =  {};
  final Map<String, dynamic> _recordMap =  {};
  final Duration expiryDuration;

  LocalCacheManager({this.expiryDuration = const Duration(minutes: 15)});

  void addToCache(
    String key,
    dynamic value, {
    Duration? expiryDuration,
  }) {
    _expiryMap[key] = DateTime.now().add(expiryDuration ?? this.expiryDuration);
    _recordMap[key] = value;
  }

  dynamic getFromCache(String key, {dynamic defaultValue}) {
    if (_expiryMap.containsKey(key)) {
      if (isExpired(_expiryMap[key]!)) {
        removeFromCache(key);
        return defaultValue;
      }

      /// Cache found
      return _recordMap[key];
    }
    return defaultValue;
  }

  void removeFromCache(String key) {
    _expiryMap.remove(key);
    _recordMap.remove(key);
  }

  bool isExpired(DateTime expiryTime) => expiryTime.isBefore(DateTime.now());
}