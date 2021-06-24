class PlaceNetworkResponse {
  bool? success;
  String? placed;
  String? forUserId;
  String? error;
  PlaceNetworkResponse.fromMap(Map<String, dynamic> map) {
    success = map['success'];
    placed = map['placed'];
    forUserId = map['for_user_id'];
    if (!map['success']) {
      error = map['error'];
    }
  }
}
