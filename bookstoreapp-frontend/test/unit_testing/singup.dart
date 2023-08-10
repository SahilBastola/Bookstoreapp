import 'package:ebuy/model/user.dart';
import 'package:ebuy/repository/user_repo.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
    test('user Should be able to login', () async {
    int expectedResult = 0;
    User UserModel = User(
      email: 'sahil@gmail.com',
      name: 'tek444',
      password: 'sahiltek',
    );
    int actualResult = await Userrepositoryimp().registeruser(UserModel);

    expect(actualResult, expectedResult);
  });
}