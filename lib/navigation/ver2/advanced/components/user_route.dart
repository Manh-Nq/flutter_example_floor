// const HOME ="home";
// const UNKNOWN ="unknown";
//
// class UserRoutePath {
//   final String? id;
//   final bool isUnknown;
//
//   UserRoutePath.home({this.id = HOME, this.isUnknown = false});
//
//   UserRoutePath.details({this.id, this.isUnknown = false});
//
//   UserRoutePath.unknown({this.id = UNKNOWN, this.isUnknown = true});
//
//   bool get isHomePage => id == HOME;
//
//   bool get isDetailsPage => id != HOME && id != UNKNOWN;
//   @override
//   String toString() {
//     return "[id]  $id - [unknown] $isUnknown";
//   }
// }

enum ScreenState{
  home, detail, err, settings
}
