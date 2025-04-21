import 'package:googleapis_auth/auth_io.dart';

class get_server_key {
  Future<String> server_token() async {
    final scopes = [
    
      'https://www.googleapis.com/auth/firebase.messaging',
    ];
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
  "type": "service_account",
  "project_id": "resq-72836",
  "private_key_id": "a4e8ee568f50deeb6f48bf1eed20d264b89df734",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCbd2pJEQxga9CZ\npZuGYq9jz09kYk4V1eyYvQUguUsZHy1OiS571sEqBAlxEQmtqam77efs80tcoLxN\nePsYKT8TnmpfWpgRJWQAa9y0knxYhCXpRDoeKeU0Gc11zxpIjOlAprXlvOgTpvRr\n8ehCkuvgp3oFZmrfp17AHYhv0x9Um0Q3zuU0kpZj1TRUasZukTIgbtJ9sYRrKrsS\n4e55xNbmktsqev0wNLx9RfAo6oxlzfeFmhNzWcB+W2MlnT/4Xc0KtTnKkZuaVAZ6\nNmd4/RAc2lcDuYQn7ylhZoZM+GU8/46hL88py73fmBMLzGRt0ouGa42AiWEwT348\n/dDkCnWTAgMBAAECggEAGTm7Qgd6ocs3VImVs9dKYcsPCkOV1kmDnirkF0cJg5Yr\n9KIiATpmKv+Zr+zATHCK7Rvb9ctqRH7Y3vHiPYLfzGVNbuhqY98pxpRkgjDXQp46\nmorAAAnzOfd1KjLvBFZHjf50OvE3xOHiUgDf8KwZ4DYR1f4kGY3KPCjul5ptldK/\nlB4cc6+NTz94vVKQpnn5YurviRSfZXygWbgHlTlMwVgGjhA4BGPDMUpUtt43RHcH\n58skljvKqanVZKesqE+dD6sRe8tbxtDwwAqhbKr92jrWaTXIqi2ar2bY4Bv68r74\nuQ97V9UwavVDEpxmJMLI1HHwi2q9t5P6+T5YwSwmRQKBgQDPOsTVIQ54WLvh+dUb\nPjvugpqd35JE0s79lAhgBOusLkKnxRyoZrMHdfK5RF4zu8F/0XRCuio/5oLQLte1\nKYmAo4QV+l8vY3fvo7crKHDANO9yM/5gKr1cMH6h8466stAhjUBNWQhuJJpnY18v\nMQ7rG3pUwJsgzvzSF6z9w2wIDwKBgQDADgHJo+qd8iOreyttJAxa4POp2qkeCo6t\nShH7oFtnfdi5MpwTSGww4W2G/ZQ2F++PzVYJ4+uGB+1VJmN7Gpuov6MYU0CNcLyW\nLqrSlP8uZLmkj38ih4q8C86OK0YyE1djzPCsSWKtDNapZurprETk9IgEofvPXFGc\nqB5gonDWPQKBgBW+x/rJXjhYr1Z2Hdue+zD6+XiJhlK8gEXxq7NPsN8/d3UdZPVy\n2WR2BwNT3kK1eAeOlhGOcXKFIMLxt2bmNeyOvASGYkiZunMmDcl0k+hHZbzpIc87\njOVInXEnGpoSu25Z4R58sjrEkoM41TshfbxEBOEx2NVngvYUz+1M/WAXAoGAHO6/\nRDJGeQ7uYroGe8Wves1ix9biHV13yxFaji7FNl0WFihSrPD/I4oCZxCykEeg1mgX\nqxvD8oglL+u9luEWTCC6oEKCegxezL0xDNJXcxTHhsv7WidTNisNLgvE4mxZgPZx\n13Kiw/EoMZMIlrVWF6vjBdelSMLepJwLH4G5P/0CgYBsEwC5PV82ckNga64y408F\nOqtenTqsSOI1xzBHs4VrmytSVWT1bYEW2JKVCtwac4Cb+ahnoG8F98dvh2Z5XJZg\nqGr1zy01Y9S9mpn3gIi2slfCMr/U9ERKgegWKI5gk0jZqrFyqFNkCq9/JxOj4sXK\n1PMSbLDS/03Jwb9+UNEOgA==\n-----END PRIVATE KEY-----\n",
  "client_email": "firebase-adminsdk-fbsvc@resq-72836.iam.gserviceaccount.com",
  "client_id": "110451333649398116289",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40resq-72836.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
),
        scopes);
    final accessserverkey = client.credentials.accessToken.data;
    return accessserverkey;
  }
}