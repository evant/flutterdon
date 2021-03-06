part of mastodon;

class RegisterResponse {
  String id;
  String name;
  String website;
  String redirectUri;
  String clientId;
  String clientSecret;
  
  RegisterResponse.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    website = json["website"];
    redirectUri = json["redirect_uri"];
    clientId = json["client_id"];
    clientSecret = json["client_secret"];
  }
}

class Account {
  String id;
  String username;
  String acct;
  String displayName;
  bool locked;
  int followersCount;
  int followingCount;
  int statusesCount;
  String note;
  String url;
  String avatar;
  String avatarStatic;
  String header;
  String headerStatic;

  Account.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    username = json["username"];
    acct = json["acct"];
    displayName = json["display_name"];
    locked = json["locked"];
    followersCount = json["followers_count"];
    followingCount = json["following_count"];
    statusesCount = json["statuses_count"];
    note = json["note"];
    url = json["url"];
    avatar = json["avatar"];
    avatarStatic = json["avatar_static"];
    header = json["header"];
    headerStatic = json["header_static"];
  }
}

class ClientInfo {
  String instanceName;
  String clientId;
  String clientSecret;
  String accessToken;

  ClientInfo(this.instanceName, this.clientId, this.clientSecret, [this.accessToken]);

  static ClientInfo fromSharedPreferences(SharedPreferences sp, String instanceName) {
    ClientInfo clientInfo;
    final encoded = sp.getString("mastodon:instance:data:$instanceName");
    if(encoded != null) {
      final json = JSON.decode(encoded);
    
      clientInfo = new ClientInfo(json['instance_name'], json['client_id'], json['client_secret'], json['access_token']);
    }
    return clientInfo;
  }
  

  Future clearFromSharedPreferences(SharedPreferences sp) async {
    sp.remove("mastodon:instance:data:$instanceName");
  }

  Future saveToSharedPreferences(SharedPreferences sp) async {
    var encoded = JSON.encode({ 
      'instance_name': instanceName,
      'client_id': clientId,
      'client_secret': clientSecret,
      'access_token': accessToken
    });
  
    sp.setString("mastodon:instance:data:$instanceName", encoded);
    await sp.commit();
  }

}