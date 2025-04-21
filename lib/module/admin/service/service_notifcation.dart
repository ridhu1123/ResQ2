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
  "private_key_id": "3f9742262ea6d3835c84a5b40a59e273d3f6edb4",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCzBaEGMmY+4WTe\nW/Nl/+xYanV7AEnRSm1kNOHJe+Fx/sVZskdvlOfolRuS6jkVGlmsODiAWKjdT2Dk\n1R+5r4iCUYgzPFHw8bOPwZ+ee56SuYxFcDtPa3YKDG9uQ4fJbxI3VBSgUUreQINc\nOoQqiVoUS1x1CHPrcMpQAcG/EldmK/qmeXDUyIRnZGVQ2P4x3DM9jBhi4urIJmEk\nf5Xi1P2pkPEMNbKA1O2G51NkbTpmdW7P9VxqlIPsPAQNDmK2Z/sxfqTLF9TGO9ZE\nwBgy+NdAFACTwxGkg3bSJA8hiPUwYZgmE4kW0UOiDk3y1inrOS9+YnjbXqmyr059\nAGLgeFTlAgMBAAECggEAH4wlZS8qf3g+y0SO7vGbl7UjAMr7NyuTfW4oP9ZZ0znf\nU0AsgIhQGdd05X3rE0HyfXvm0Q9OqrlbTNgV4CYDu1tc0hKWKgyd5P5s/4OvXRHf\nmzj86rD4OysX0+mIm0G8hw2FGP9aXzIlM/KH6esMebkSEPmtW9cjf9ffaal0x2c6\nlJWdEmTqoTxBO9MFbRuf4mR0JjTw2Av8rzEr+JivPRu+Ktr630Fn4nEnSF/3/9vA\n5skkqKpoL3OuangNhGoKw1rSUaB4FShEHIWEGvMCKw5KEaDeLfJcBev1S0ZwU4F4\niIoSggJyZ4UVCymh54jpj/Y3JpySNRHWUVfot7Zi3QKBgQDy/5P6fm+gmAJANCL/\nnfkl8K487Wl1xGBmoNFjoZvfD+mPeGUK3lNt1FZxe4VWjSPDl52kS1IM88DtsPmr\nR9vext21PMMAVnmgk6/7OugCzQXq37R+67+L4Ta7zz2QkJcPhOPoxP64eWmzIdVD\nJ9dzCepvtnp7QE0zWIg4gq/srwKBgQC8mb9SS2WzmEIPTHOlERqZ5shjXmWu+u7F\nT51eTfn4luIpD9rm2SPSBuiI2wYpO89V6WgzgTB9tlyAKBzJEOG8Z6rlTh60s9id\nMP5dup4uu1oL3P/s5hsZVEcBi1tW7TNm9WevH/5KelZu9z9ucK7ULQJftTNuLuhc\nBQKdmIWEqwKBgQDtO5NOpI16ba0U3VGl2KZa4gRZOzcQYG31A+AosqgoN7K//Lw4\nxiERQpI6LGtaumRGGgkvUtGCD5807uhwzbDcZ64fuHhwJfyMRmMylKnZwiuayFfA\n6YuRlogHByaFsoOoBQc0Qs6jbvVAizFXZNg0WWPlOHOPTJGSJUaoVP5HxQKBgF5h\n3rHzU3D+CEkZrGH13kcYjD3WNrLLlwQdJJbWFPuHnqSH77dJATkRBfu/CCVIbikD\nRodH5ply0nW8HTOuBBnCE27vmkQ6IHQB2bnUM2cVkSmQrm7CdNtHJsWqFMq6p9el\nhf7I1vw0nt6nUxIUyBkccSyuRI+mX9f1FesCMgdDAoGBAIjY5PycmYTn7WHDqLtf\nZdT7/tlTTUVQcr808gqBbTjoY5ppShVytss0PiF3EcqfhMblpxg0A15GEMrd3rKM\nGYCKZZRWkOVeupsjkezeObd+Cs1EpluGwo9/aC5r3+WCLvKHEdjGFm1OQdhXHted\nFSGjwdhPcHqV6uawVgEG+uHm\n-----END PRIVATE KEY-----\n",
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
      "notification": {
        "sound": "notification_sound" // Android-specific sound
      }
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
