

class GetNumbersAPI {
  bool? status;
  int? count;
  int? page;
  List<Payload>? payload;

  GetNumbersAPI({this.status, this.count, this.page, this.payload});

  GetNumbersAPI.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    count = json['count'];
    page = json['page'];
    if (json['payload'] != null) {
      payload = <Payload>[];
      json['payload'].forEach((v) {
        payload!.add(new Payload.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['count'] = this.count;
    data['page'] = this.page;
    if (this.payload != null) {
      data['payload'] = this.payload!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Payload {
  String? accountSid;
  String? phoneSid;
  String? phoneNumber;
  String? voiceUrl;
  String? voiceMethod;
  String? voiceFallbackUrl;
  String? voiceFallbackMethod;
  int? renewalDate;
  int? purchaseDate;
  String? region;
  int? timezone;
  String? smsUrl;
  String? smsMethod;
  String? smsFallbackUrl;
  String? smsFallbackMethod;
  String? heartbeatUrl;
  String? heartbeatMethod;
  String? hangupCallbackUrl;
  String? hangupCallbackMethod;
  List<String>? attributes;
  int? numberType;

  Payload(
      {this.accountSid,
      this.phoneSid,
      this.phoneNumber,
      this.voiceUrl,
      this.voiceMethod,
      this.voiceFallbackUrl,
      this.voiceFallbackMethod,
      this.renewalDate,
      this.purchaseDate,
      this.region,
      this.timezone,
      this.smsUrl,
      this.smsMethod,
      this.smsFallbackUrl,
      this.smsFallbackMethod,
      this.heartbeatUrl,
      this.heartbeatMethod,
      this.hangupCallbackUrl,
      this.hangupCallbackMethod,
      this.attributes,
      this.numberType});

  Payload.fromJson(Map<String, dynamic> json) {
    accountSid = json['accountSid'];
    phoneSid = json['phoneSid'];
    phoneNumber = json['phoneNumber'];
    voiceUrl = json['voiceUrl'];
    voiceMethod = json['voiceMethod'];
    voiceFallbackUrl = json['voiceFallbackUrl'];
    voiceFallbackMethod = json['voiceFallbackMethod'];
    renewalDate = json['renewalDate'];
    purchaseDate = json['purchaseDate'];
    region = json['region'];
    timezone = json['timezone'];
    smsUrl = json['smsUrl'];
    smsMethod = json['smsMethod'];
    smsFallbackUrl = json['smsFallbackUrl'];
    smsFallbackMethod = json['smsFallbackMethod'];
    heartbeatUrl = json['heartbeatUrl'];
    heartbeatMethod = json['heartbeatMethod'];
    hangupCallbackUrl = json['hangupCallbackUrl'];
    hangupCallbackMethod = json['hangupCallbackMethod'];
    attributes = json['attributes'].cast<String>();
    numberType = json['numberType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountSid'] = this.accountSid;
    data['phoneSid'] = this.phoneSid;
    data['phoneNumber'] = this.phoneNumber;
    data['voiceUrl'] = this.voiceUrl;
    data['voiceMethod'] = this.voiceMethod;
    data['voiceFallbackUrl'] = this.voiceFallbackUrl;
    data['voiceFallbackMethod'] = this.voiceFallbackMethod;
    data['renewalDate'] = this.renewalDate;
    data['purchaseDate'] = this.purchaseDate;
    data['region'] = this.region;
    data['timezone'] = this.timezone;
    data['smsUrl'] = this.smsUrl;
    data['smsMethod'] = this.smsMethod;
    data['smsFallbackUrl'] = this.smsFallbackUrl;
    data['smsFallbackMethod'] = this.smsFallbackMethod;
    data['heartbeatUrl'] = this.heartbeatUrl;
    data['heartbeatMethod'] = this.heartbeatMethod;
    data['hangupCallbackUrl'] = this.hangupCallbackUrl;
    data['hangupCallbackMethod'] = this.hangupCallbackMethod;
    data['attributes'] = this.attributes;
    data['numberType'] = this.numberType;
    return data;
  }
}