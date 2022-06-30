class UserRoutePath {
  final String? id;
  final bool isUnknown;

  UserRoutePath.home({this.id = null, this.isUnknown = false});

  UserRoutePath.details({this.id, this.isUnknown = false});

  UserRoutePath.unknown({this.id = null, this.isUnknown = true});

  bool get isHomePage => id == null;

  bool get isDetailsPage => id != null;
  @override
  String toString() {
    return "[id]  $id - [unknown] $isUnknown";
  }
}
