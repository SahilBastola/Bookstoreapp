import '../../helper/objectbox.dart';
import '../../model/user.dart';
import '../../state/objectboc_state.dart';

class UserDataSource {
  ObjectBoxInstance objectBoxInstance = ObjectBoxState.objectBoxInstance!;

  Future<int> registeruser(User user) async {
    try {
      return objectBoxInstance.registeruser(user);
    } catch (e) {
      return 0;
    }
  }
//instance data for login user
  Future<User> loginStudent(String username, String password) {
    try {
      return Future.value(objectBoxInstance.loginUser(username, password));
    } catch (e) {
      return Future.value(null);
    }
  }
}