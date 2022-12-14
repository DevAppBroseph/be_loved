import 'dart:io';
import 'package:be_loved/core/services/database/auth_params.dart';
import 'package:be_loved/core/services/database/shared_prefs.dart';
import 'package:be_loved/core/services/network/config.dart';
import 'package:be_loved/core/utils/helpers/events.dart';
import 'package:be_loved/locator.dart';
import 'package:dio/dio.dart';

import '../../features/auth/data/models/auth/check_is_user_exist.dart';
import '../../features/auth/data/models/auth/check_nickName.dart';
import '../../features/auth/data/models/auth/init_user.dart';
import '../../features/auth/data/models/auth/user.dart';

class Repository {
  static var uri = Uri.parse(Config.url.url);
  var dio = Dio(
    BaseOptions(
        baseUrl: Config.url.url, validateStatus: (status) => status! <= 400),
  );

  Future<bool?> editUser(File? file) async {
    var options = Options(headers: {
      'Authorization': 'Token ${await MySharedPrefs().token}',
    }, validateStatus: (status) => status! <= 500);

    try {
      var response = await dio.put('auth/users',
          options: options,
          data: FormData.fromMap({
            'photo': MultipartFile.fromFileSync(file!.path, filename: file.path)
          }));
      print('RES: ${response.statusCode} ||| ${response.requestOptions.uri} ||| ${response.data}');
      if (response.statusCode == 200) {
        return true;
      }
      if (response.statusCode == 400) {}
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<int?> registration(String number) async {
    try {
      var response =
          await dio.post('auth/code_phone', data: {'phone_number': number});
      print('RES: ${response.statusCode} ||| ${response.requestOptions.uri} ||| ${response.data}');
      if (response.statusCode == 204) {
        return 12345;
      }
      if (response.statusCode == 400) {}
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<CheckIsUserExist?> checkIsUserExist(String number, int code) async {
    try {
      var response = await dio.put('auth/code_phone', data: {
        'phone_number': number,
        'code': code,
      });
      print('RES: ${response.statusCode} ||| ${response.requestOptions.uri} ||| ${response.data}');
      if (response.statusCode == 200) {
        return CheckIsUserExist.fromJson(response.data);
      }
      if (response.statusCode == 400) {}
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool?> checkNickName(String name) async {
    try {
      var response = await dio.get(
        'auth/code_phone',
        queryParameters: {
          'username': name,
        },
      );
      print('RES: ${response.statusCode} ||| ${response.requestOptions.uri} ||| ${response.data}');
      if (response.statusCode == 200) {
        return CheckNickName.fromJson(response.data).exists;
      }
      if (response.statusCode == 400) {}
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool?> checkPhoneNumber(String phone) async {
    try {
      var response = await dio.get(
        '/auth/code_phone',
        queryParameters: {
          'phone_number': phone,
        },
      );
      print('RES: ${response.statusCode} ||| ${response.requestOptions.uri} ||| ${response.data}');
      if (response.statusCode == 200) {
        final bool res = response.data['exists'];
        return res;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<String?> initUser(
      String secretKey, String nickname, File? xFile) async {
    try {
      final data = xFile != null
          ? {
              'secret_key': secretKey,
              'username': nickname,
              'photo':
                  MultipartFile.fromFileSync(xFile.path, filename: xFile.path),
            }
          : {
              'secret_key': secretKey,
              'username': nickname,
            };
      var response = await dio.post(
        'auth/users',
        data: FormData.fromMap(data),
        options: Options(
          validateStatus: (status) => status! <= 450,
        ),
      );
      print('RES: ${response.statusCode} ||| ${response.requestOptions.uri} ||| ${response.data}');

      if (response.statusCode == 200) {
        return InitUserAnswer.fromJson(response.data).authToken;
      }
      if (response.statusCode == 400) {}
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<UserAnswer?> inviteUser(String phone) async {
    print('PHNE: ${phone} ::: ${await MySharedPrefs().token}');
    var options = Options(headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Token ${await MySharedPrefs().token}",
    }, validateStatus: (status) => status! <= 600);
    try {
      var response = await dio.post(
        '/relations/',
        data: FormData.fromMap({
          "to_phone_number": phone,
        }),
        options: options,
      );
      print('RES: ${response.statusCode} ||| ${response.requestOptions.uri} ||| ${response.data}');
      if (response.statusCode == 200) {
        return UserAnswer.fromJson(response.data);
      }
      if (response.statusCode == 400) {}

      return null;
    } catch (e) {
      return null;
    }
  }

  Future<UserAnswer?> deleteInviteUser(int relationId) async {
    var options = Options(headers: {
      'Authorization': 'Token ${await MySharedPrefs().token}',
    }, validateStatus: (status) => status! <= 500);

    try {
      var response = await dio.put(
        '/relations/',
        data: {"relation_id": relationId, "status": '????????????????'},
        options: options,
      );
      print('RES: ${response.statusCode} ||| ${response.requestOptions.uri} ||| ${response.data}');
      if (response.statusCode == 200) {
        return UserAnswer.fromJson(response.data);
      }
      if (response.statusCode == 400) {}
      if (response.statusCode == 400) {}

      return null;
    } catch (e) {
      return null;
    }
  }

  Future<UserAnswer?> getUser() async {
    String? token = await MySharedPrefs().token;
    var options = Options(headers: {
      'Authorization': 'Token ${token}',
    });
    try {
      var response = await dio.get(
        'auth/users',
        options: options,
      );

      print('RES: ${response.statusCode} ||| ${response.requestOptions.uri} ||| ${response.data}');
      if (response.statusCode == 200) {
        sl<AuthConfig>().token = token;
        return UserAnswer.fromJson(response.data);
      }
      if (response.statusCode == 400) {}
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<UserAnswer?> startRelationships(String date, int relationId) async {
    var options = Options(headers: {
      'Authorization': 'Token ${await MySharedPrefs().token}',
    }, validateStatus: (status) => status! <= 500);
    try {
      var response = await dio.put(
        '/relations/',
        data: {"date": date, "relation_id": relationId},
        options: options,
      );

      print('RES: ${response.statusCode} ||| ${response.requestOptions.uri} ||| ${response.data}');
      if (response.statusCode == 200) {
        return UserAnswer.fromJson(response.data);
      }
      if (response.statusCode == 400) {}
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<UserAnswer?> acceptRelationships(int relationId) async {
    var options = Options(headers: {
      'Authorization': 'Token ${await MySharedPrefs().token}',
    }, validateStatus: (status) => status! <= 500);
    try {
      var response = await dio.put(
        '/relations/',
        data: {"relation_id": relationId, "status": '??????????????'},
        options: options,
      );

      print('RES: ${response.statusCode} ||| ${response.requestOptions.uri} ||| ${response.data}');
      if (response.statusCode == 200) {
        return UserAnswer.fromJson(response.data);
      }
      if (response.statusCode == 400) {}
      if (response.statusCode == 400) {}

      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<Events>?> getEvents() async {
    String? token = await MySharedPrefs().token;
    var options = Options(headers: {
      'Authorization': 'Token $token',
    });
    try {
      var response = await dio.get(
        'events/',
        options: options,
      );

      print('RES: ${response.statusCode} ||| ${response.requestOptions.uri} ||| ${response.data}');
      if (response.statusCode == 200) {
        List<Events> events = [];
        for(final val in response.data) {
          events.add(Events.fromJson(val));
        }
        // sl<AuthConfig>().token = token;
        // return Events.fromJson(response.data);
        return events;
      }
      if (response.statusCode == 400) {}
      return null;
    } catch (e) {
      return null;
    }
  }
}
