import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart';

class SendNotificationService {
  final String _projectId = 'resq-72836';

  // 👇 Your Firebase service account JSON
  final _serviceAccount = r'''
{
  "type": "service_account",
  "project_id": "resq-72836",
  "private_key_id": "d74e7949b7ec5de11207461e214c2a1ccef0355e",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCpp8E6bO84raEz\nRQZhKUZRMDi2clQ2vWAbcnnhAZCkDkeYy0d6vtfP1K5MtXFtcw/seg7A2+Qd4h1n\nTzawRO548JmkNhxf3yps+ssMyVXN/9Qj8SXGfKLOaANk7lfyCN3SqEc9I/Z+fuXJ\nEjMtJ8C3zjmvmSF8+IhNPAnf5wRH0cLHI9cIvXylRcOu5N5kSYSllFgd4khUGahd\nCflc2uBlKLob39yynjEk0PzZUH9uXYKcZZaaWjz/EYUGmurbhdC4E5roRNfM98a4\nGwS0sp2PakUjbKd4C1gl7Mxvc95MB1zkLl3bsiVCNZ8QYEDdzCyIflGMYGdFAuhS\n4mKQSDcdAgMBAAECggEAE2ZRXCL0v+Bq3Hf6IMYdek8vTP2Jz7Cb+sd+VFJffcL8\nQOaNx+VmvCcvvynITKGponrakQcT8K7YeeW+9S0Mr9ujVfmyCOx153xOF6o2G5Yz\nZeC/VxENdNjD+pieidiltN71NnKUTyank/R20aUIDnyQcBnskGPDAkHpRycdgDC2\nKhnqpVP4saioRkN7tEfqnJ/Q6rY99xJ+NzFbM6m/GSDou85L7q0Aee3mmMZFezKf\nh7qR6Irr+upgVq/Jb+jiB35vmc1UsUhSO0M1rMJAdBrYztUEy0wE0h/sthifLkxM\ngqfla4dq+p6d9uYoBuoGR89tePdk1oiKzWwVjMYDAQKBgQDtZeglrzfi5CCh1NQ5\nhrV2Ivm5nsKz20nf2B8ue6EHYGkEkKiH7qyBW6B+AbJA8aA2JhYph4V7PS14P9zL\nvHSTNyle/CVKnJyV7GsvXfqNG2736kTh3S3ozyz7VZSXCC7lvvfBOcDKl1kwHQRj\nQYE578iUtl4qINyKtFnrTyIV4QKBgQC28vW0yqQSN7RnghNPRFi5KIq3R3hf408X\nGXZcBxymBV0O0Ltnubt374E7ukdUpDnBWRC4MGLHbwE/o7CFeiD0y/v10QlDCg/H\nzMyQik3Z/SBec4H4A+pX99NUAQan+gILpK/hLbMYmXPzPLtY5Nkm3jPiID6SwBSO\neGEl2sAQvQKBgQCuuk6/TdOoX5fVBLyfCpMMvHlpMXzEvCYHZx6sK7o9n6wr+/zO\n79Bv9WyO0djNDAqLUEUHlAOezUxmMTrliXOT1wnQK22XGOX3QucxGc6LhSGLvxWr\n2AsuSy4kXrza3N8HoiLgSQ2pDvRKAVF1bIUci2vqaL+t6jnorQ1xr/C6gQKBgHlo\nJDwU2eqpAtRJ0sygm4xMZjmYeT6Q1zSKFiyeH5nhJ08kn6kG7Wx7CTT8ukdmMFmp\n5FmG6pZUiOyVkRgS4vnwwETxsobFj5FUzFADKATIYQms94wB9SrpcFln0OX6GA9n\n+7ugGyDw/KxnGiC0xZJwlNez9DJou3uMUVPQpfK1AoGBAKHDYQbqQDLnNBsKnRwD\nxkMIDWItvAFloifMtpzaBrOFnfWT2QqIfsoHRncSiBxUF/hQfafFWLpeopNrOnOF\nj6La6xBOoiuEwscaOkmqirv7pVGX3dqEXxdNrmAeJwNadc4JYqc+AC9yVbhbjz/V\na/jhsouYmuJN7U1b3fzFVNol\n-----END PRIVATE KEY-----\n",
  "client_email": "firebase-adminsdk-fbsvc@resq-72836.iam.gserviceaccount.com",
  "client_id": "110451333649398116289",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40resq-72836.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
  ''';

  // 🔐 Step 1: Get Access Token
  Future<String> getAccessToken() async {
    final credentials = ServiceAccountCredentials.fromJson(_serviceAccount);
    final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
    final client = await clientViaServiceAccount(credentials, scopes);
    return client.credentials.accessToken.data;
  }

  // 🚀 Step 2: Send Notifications
  Future<void> sendNotificationToUsers({
    required List<String> fcmTokens,
    required String title,
    required String body,
    required String type,
  }) async {
    final accessToken = await getAccessToken();
    log('accessToken $accessToken');
    final url = Uri.parse(
      'https://fcm.googleapis.com/v1/projects/$_projectId/messages:send',
    );

    for (final token in fcmTokens) {
      // final message = {
      //   "message": {
      //     "token": token,
      //     "notification": {"title": title, "body": body},
      //     "data":'sound' 'notification_sound',
      //     "android": {"priority": "high"},
   
      //   },
      // };

      final message = {
  "message": {
    "token": token, 
    "notification": {
      "title": title, 
      "body": body
    },
    "data": {
      "type": type,
    },
    "android": {
      "priority": "high",
      // "notification": {
      //   // "sound": "notification_sound" // Android-specific sound
      // }
    }
  }
};

      // {
      //   "message": {
      //     "token": token,
      //     "notification": {
      //       "title": title,
      //       "body": body,
      //       // "android_channel_id": "custom_channel"
      //     },
      //     "android": {
      //       "priority": "high",
      //       "notification": {
      //         "sound": "notification_sound",
      //         // "android_channel_id": "custom_channel"
      //       },
      //     },
      //     // "android": {
      //     //   "priority": "high",
      //     // },
      //   },
      // };

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(message),
      );

      if (response.statusCode == 200) {
      } else {}
    }
  }
}




// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:googleapis_auth/auth_io.dart';

// class SendNotificationService {
//   final String _projectId = 'resq-72836'; 


//   // 👇 Your Firebase service account JSON
//   final _serviceAccount = r'''
//   {
//   "type": "service_account",
//   "project_id": "resq-72836",
//   "private_key_id": "a4e8ee568f50deeb6f48bf1eed20d264b89df734",
//   "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCbd2pJEQxga9CZ\npZuGYq9jz09kYk4V1eyYvQUguUsZHy1OiS571sEqBAlxEQmtqam77efs80tcoLxN\nePsYKT8TnmpfWpgRJWQAa9y0knxYhCXpRDoeKeU0Gc11zxpIjOlAprXlvOgTpvRr\n8ehCkuvgp3oFZmrfp17AHYhv0x9Um0Q3zuU0kpZj1TRUasZukTIgbtJ9sYRrKrsS\n4e55xNbmktsqev0wNLx9RfAo6oxlzfeFmhNzWcB+W2MlnT/4Xc0KtTnKkZuaVAZ6\nNmd4/RAc2lcDuYQn7ylhZoZM+GU8/46hL88py73fmBMLzGRt0ouGa42AiWEwT348\n/dDkCnWTAgMBAAECggEAGTm7Qgd6ocs3VImVs9dKYcsPCkOV1kmDnirkF0cJg5Yr\n9KIiATpmKv+Zr+zATHCK7Rvb9ctqRH7Y3vHiPYLfzGVNbuhqY98pxpRkgjDXQp46\nmorAAAnzOfd1KjLvBFZHjf50OvE3xOHiUgDf8KwZ4DYR1f4kGY3KPCjul5ptldK/\nlB4cc6+NTz94vVKQpnn5YurviRSfZXygWbgHlTlMwVgGjhA4BGPDMUpUtt43RHcH\n58skljvKqanVZKesqE+dD6sRe8tbxtDwwAqhbKr92jrWaTXIqi2ar2bY4Bv68r74\nuQ97V9UwavVDEpxmJMLI1HHwi2q9t5P6+T5YwSwmRQKBgQDPOsTVIQ54WLvh+dUb\nPjvugpqd35JE0s79lAhgBOusLkKnxRyoZrMHdfK5RF4zu8F/0XRCuio/5oLQLte1\nKYmAo4QV+l8vY3fvo7crKHDANO9yM/5gKr1cMH6h8466stAhjUBNWQhuJJpnY18v\nMQ7rG3pUwJsgzvzSF6z9w2wIDwKBgQDADgHJo+qd8iOreyttJAxa4POp2qkeCo6t\nShH7oFtnfdi5MpwTSGww4W2G/ZQ2F++PzVYJ4+uGB+1VJmN7Gpuov6MYU0CNcLyW\nLqrSlP8uZLmkj38ih4q8C86OK0YyE1djzPCsSWKtDNapZurprETk9IgEofvPXFGc\nqB5gonDWPQKBgBW+x/rJXjhYr1Z2Hdue+zD6+XiJhlK8gEXxq7NPsN8/d3UdZPVy\n2WR2BwNT3kK1eAeOlhGOcXKFIMLxt2bmNeyOvASGYkiZunMmDcl0k+hHZbzpIc87\njOVInXEnGpoSu25Z4R58sjrEkoM41TshfbxEBOEx2NVngvYUz+1M/WAXAoGAHO6/\nRDJGeQ7uYroGe8Wves1ix9biHV13yxFaji7FNl0WFihSrPD/I4oCZxCykEeg1mgX\nqxvD8oglL+u9luEWTCC6oEKCegxezL0xDNJXcxTHhsv7WidTNisNLgvE4mxZgPZx\n13Kiw/EoMZMIlrVWF6vjBdelSMLepJwLH4G5P/0CgYBsEwC5PV82ckNga64y408F\nOqtenTqsSOI1xzBHs4VrmytSVWT1bYEW2JKVCtwac4Cb+ahnoG8F98dvh2Z5XJZg\nqGr1zy01Y9S9mpn3gIi2slfCMr/U9ERKgegWKI5gk0jZqrFyqFNkCq9/JxOj4sXK\n1PMSbLDS/03Jwb9+UNEOgA==\n-----END PRIVATE KEY-----\n",
//   "client_email": "firebase-adminsdk-fbsvc@resq-72836.iam.gserviceaccount.com",
//   "client_id": "110451333649398116289",
//   "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//   "token_uri": "https://oauth2.googleapis.com/token",
//   "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
//   "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40resq-72836.iam.gserviceaccount.com",
//   "universe_domain": "googleapis.com"
// }
//   ''';

//   // 🔐 Step 1: Get Access Token
//   Future<String> _getAccessToken() async {
//     final credentials = ServiceAccountCredentials.fromJson(_serviceAccount);
//     final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
//     final client = await clientViaServiceAccount(credentials, scopes);
//     return client.credentials.accessToken.data;
//   }

//   // 🚀 Step 2: Send Notifications
//   Future<void> sendNotificationToUsers({
//     required List<String> fcmTokens,
//     required String title,
//     required String body,
//   }) async {
//     final accessToken = await _getAccessToken();

//     final url = Uri.parse(
//         'https://fcm.googleapis.com/v1/projects/$_projectId/messages:send');

//     for (final token in fcmTokens) {
//       final message = {
//         "message": {
//           "token": token,
//           "notification": {
//             "title": title,
//             "body": body,
//           },
//           "android": {
//             "priority": "high",
//           },
//         }
//       };

//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $accessToken',
//         },
//         body: jsonEncode(message),
//       );

//       if (response.statusCode == 200) {
//         print("✅ Notification sent to $token");
//       } else {
//         print("❌ Failed for $token: ${response.statusCode} - ${response.body}");
//       }
//     }
//   }
// }
