import 'package:path_provider/path_provider.dart';
import '../model/user.dart';
import '../objectbox.g.dart';

class ObjectBoxInstance {
  late final Store _store;
  late final Box<User> _user;

  ObjectBoxInstance(this._store) {
    _user = Box<User>(_store);
  }
  static Future<ObjectBoxInstance> init() async {
    var dir = await getApplicationDocumentsDirectory();

    final store = Store(getObjectBoxModel(), directory: "${dir.path}/Ebuyuser");
    return ObjectBoxInstance(store);
  }
//register user
  int registeruser(User user) {
    return _user.put(user);
  }

   List<User> getAllStudent() {
    return _user.getAll();
  }
//loginuser
 
User? loginUser(String username, String password) {
    return _user
        .query(
            User_.name.equals(username) & User_.password.equals(password))
        .build()
        .findFirst();
  }
}