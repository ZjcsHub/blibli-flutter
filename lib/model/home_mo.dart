// https://api.bilibili.com/x/web-show/res/locs?pf=0&ids=3449
class HomeMo {
  int? id;
  String? contractId;
  int? resId;
  int? asgId;
  int? posNum;
  String? name;
  String? pic;
  String? litpic;
  String? url;
  int? style;
  String? agency;
  String? label;
  String? intro;
  int? creativeType;
  String? requestId;
  int? srcId;
  int? area;
  bool? isAdLoc;
  String? adCb;
  String? title;
  int? serverType;
  int? cmMark;
  int? stime;
  String? mid;
  int? activityType;
  int? epid;
  String? season;
  Room? room;
  String? subTitle;
  String? adDesc;
  String? adverName;
  bool? nullFrame = false;
  String? picMainColor;
  int? cardType;
  String? businessMark;
  Inline? inline;
  String? operater;

  HomeMo(
      {this.id,
      this.contractId,
      this.resId,
      this.asgId,
      this.posNum,
      this.name,
      this.pic,
      this.litpic,
      this.url,
      this.style,
      this.agency,
      this.label,
      this.intro,
      this.creativeType,
      this.requestId,
      this.srcId,
      this.area,
      this.isAdLoc,
      this.adCb,
      this.title,
      this.serverType,
      this.cmMark,
      this.stime,
      this.mid,
      this.activityType,
      this.epid,
      this.season,
      this.room,
      this.subTitle,
      this.adDesc,
      this.adverName,
      this.nullFrame,
      this.picMainColor,
      this.cardType,
      this.businessMark,
      this.inline,
      this.operater});

  HomeMo.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    contractId = json['contract_id'];
    resId = json['res_id'];
    asgId = json['asg_id'];
    posNum = json['pos_num'];
    name = json['name'];
    pic = json['pic'];
    litpic = json['litpic'];
    url = json['url'];
    style = json['style'];
    agency = json['agency'];
    label = json['label'];
    intro = json['intro'];
    creativeType = json['creative_type'];
    requestId = json['request_id'];
    srcId = json['src_id'];
    area = json['area'];
    isAdLoc = json['is_ad_loc'];
    adCb = json['ad_cb'];
    title = json['title'];
    serverType = json['server_type'];
    cmMark = json['cm_mark'];
    stime = json['stime'];
    mid = json['mid'];
    activityType = json['activity_type'];
    epid = json['epid'];
    season = json['season'];
    room = json['room'] != null ? new Room.fromJson(json['room']) : null;
    subTitle = json['sub_title'];
    adDesc = json['ad_desc'];
    adverName = json['adver_name'];
    nullFrame = json['null_frame'];
    picMainColor = json['pic_main_color'];
    cardType = json['card_type'];
    businessMark = json['business_mark'];
    inline =
        json['inline'] != null ? new Inline.fromJson(json['inline']) : null;
    operater = json['operater'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['contract_id'] = this.contractId;
    data['res_id'] = this.resId;
    data['asg_id'] = this.asgId;
    data['pos_num'] = this.posNum;
    data['name'] = this.name;
    data['pic'] = this.pic;
    data['litpic'] = this.litpic;
    data['url'] = this.url;
    data['style'] = this.style;
    data['agency'] = this.agency;
    data['label'] = this.label;
    data['intro'] = this.intro;
    data['creative_type'] = this.creativeType;
    data['request_id'] = this.requestId;
    data['src_id'] = this.srcId;
    data['area'] = this.area;
    data['is_ad_loc'] = this.isAdLoc;
    data['ad_cb'] = this.adCb;
    data['title'] = this.title;
    data['server_type'] = this.serverType;
    data['cm_mark'] = this.cmMark;
    data['stime'] = this.stime;
    data['mid'] = this.mid;
    data['activity_type'] = this.activityType;
    data['epid'] = this.epid;
    data['season'] = this.season;
    if (this.room != null) {
      data['room'] = this.room!.toJson();
    }
    data['sub_title'] = this.subTitle;
    data['ad_desc'] = this.adDesc;
    data['adver_name'] = this.adverName;
    data['null_frame'] = this.nullFrame;
    data['pic_main_color'] = this.picMainColor;
    data['card_type'] = this.cardType;
    data['business_mark'] = this.businessMark;
    if (this.inline != null) {
      data['inline'] = this.inline!.toJson();
    }
    data['operater'] = this.operater;
    return data;
  }
}

class Room {
  int? roomId;
  int? uid;
  Status? status;
  Show? show;
  Area? area;

  Room({
    this.roomId,
    this.uid,
    this.status,
    this.show,
    this.area,
  });

  Room.fromJson(Map<String, dynamic> json) {
    roomId = json['room_id'];
    uid = json['uid'];
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    show = json['show'] != null ? new Show.fromJson(json['show']) : null;
    area = json['area'] != null ? new Area.fromJson(json['area']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_id'] = this.roomId;
    data['uid'] = this.uid;
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    if (this.show != null) {
      data['show'] = this.show!.toJson();
    }
    if (this.area != null) {
      data['area'] = this.area!.toJson();
    }

    return data;
  }
}

class Status {
  int? liveStatus;
  int? liveScreenType;
  int? liveMark;
  int? lockStatus;
  int? lockTime;
  int? hiddenStatus;
  int? hiddenTime;
  int? liveType;
  int? roomShield;
  int? anchorRoundSwitch;
  int? anchorRoundStatus;
  String? password;

  Status(
      {this.liveStatus,
      this.liveScreenType,
      this.liveMark,
      this.lockStatus,
      this.lockTime,
      this.hiddenStatus,
      this.hiddenTime,
      this.liveType,
      this.roomShield,
      this.anchorRoundSwitch,
      this.anchorRoundStatus,
      this.password});

  Status.fromJson(Map<String, dynamic> json) {
    liveStatus = json['live_status'];
    liveScreenType = json['live_screen_type'];
    liveMark = json['live_mark'];
    lockStatus = json['lock_status'];
    lockTime = json['lock_time'];
    hiddenStatus = json['hidden_status'];
    hiddenTime = json['hidden_time'];
    liveType = json['live_type'];
    roomShield = json['room_shield'];
    anchorRoundSwitch = json['anchor_round_switch'];
    anchorRoundStatus = json['anchor_round_status'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['live_status'] = this.liveStatus;
    data['live_screen_type'] = this.liveScreenType;
    data['live_mark'] = this.liveMark;
    data['lock_status'] = this.lockStatus;
    data['lock_time'] = this.lockTime;
    data['hidden_status'] = this.hiddenStatus;
    data['hidden_time'] = this.hiddenTime;
    data['live_type'] = this.liveType;
    data['room_shield'] = this.roomShield;
    data['anchor_round_switch'] = this.anchorRoundSwitch;
    data['anchor_round_status'] = this.anchorRoundStatus;
    data['password'] = this.password;
    return data;
  }
}

class Show {
  int? shortId;
  String? title;
  String? cover;
  String? keyframe;
  int? popularityCount;
  List<TagList>? tagList;
  int? liveStartTime;
  int? liveId;
  bool? hiddenOnline;

  Show(
      {this.shortId,
      this.title,
      this.cover,
      this.keyframe,
      this.popularityCount,
      this.tagList,
      this.liveStartTime,
      this.liveId,
      this.hiddenOnline});

  Show.fromJson(Map<String, dynamic> json) {
    shortId = json['short_id'];
    title = json['title'];
    cover = json['cover'];
    keyframe = json['keyframe'];
    popularityCount = json['popularity_count'];
    if (json['tag_list'] != null) {
      tagList = [];
      json['tag_list'].forEach((v) {
        tagList!.add(new TagList.fromJson(v));
      });
    }
    liveStartTime = json['live_start_time'];
    liveId = json['live_id'];
    hiddenOnline = json['hidden_online'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['short_id'] = this.shortId;
    data['title'] = this.title;
    data['cover'] = this.cover;
    data['keyframe'] = this.keyframe;
    data['popularity_count'] = this.popularityCount;
    if (this.tagList != null) {
      data['tag_list'] = this.tagList!.map((v) => v.toJson()).toList();
    }
    data['live_start_time'] = this.liveStartTime;
    data['live_id'] = this.liveId;
    data['hidden_online'] = this.hiddenOnline;
    return data;
  }
}

class TagList {
  int? tagId;
  int? tagSubId;
  int? tagExpireAt;

  TagList({this.tagId, this.tagSubId, this.tagExpireAt});

  TagList.fromJson(Map<String, dynamic> json) {
    tagId = json['tag_id'];
    tagSubId = json['tag_sub_id'];
    tagExpireAt = json['tag_expire_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag_id'] = this.tagId;
    data['tag_sub_id'] = this.tagSubId;
    data['tag_expire_at'] = this.tagExpireAt;
    return data;
  }
}

class Area {
  int? areaId;
  String? areaName;
  int? parentAreaId;
  String? parentAreaName;
  int? oldAreaId;
  String? oldAreaName;
  String? oldAreaTag;
  int? areaPkStatus;
  bool? isVideoRoom;

  Area(
      {this.areaId,
      this.areaName,
      this.parentAreaId,
      this.parentAreaName,
      this.oldAreaId,
      this.oldAreaName,
      this.oldAreaTag,
      this.areaPkStatus,
      this.isVideoRoom});

  Area.fromJson(Map<String, dynamic> json) {
    areaId = json['area_id'];
    areaName = json['area_name'];
    parentAreaId = json['parent_area_id'];
    parentAreaName = json['parent_area_name'];
    oldAreaId = json['old_area_id'];
    oldAreaName = json['old_area_name'];
    oldAreaTag = json['old_area_tag'];
    areaPkStatus = json['area_pk_status'];
    isVideoRoom = json['is_video_room'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['area_id'] = this.areaId;
    data['area_name'] = this.areaName;
    data['parent_area_id'] = this.parentAreaId;
    data['parent_area_name'] = this.parentAreaName;
    data['old_area_id'] = this.oldAreaId;
    data['old_area_name'] = this.oldAreaName;
    data['old_area_tag'] = this.oldAreaTag;
    data['area_pk_status'] = this.areaPkStatus;
    data['is_video_room'] = this.isVideoRoom;
    return data;
  }
}

class Inline {
  int? inlineUseSame;
  int? inlineType;
  String? inlineUrl;
  int? inlineBarrageSwitch;

  Inline(
      {this.inlineUseSame,
      this.inlineType,
      this.inlineUrl,
      this.inlineBarrageSwitch});

  Inline.fromJson(Map<String, dynamic> json) {
    inlineUseSame = json['inline_use_same'];
    inlineType = json['inline_type'];
    inlineUrl = json['inline_url'];
    inlineBarrageSwitch = json['inline_barrage_switch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inline_use_same'] = this.inlineUseSame;
    data['inline_type'] = this.inlineType;
    data['inline_url'] = this.inlineUrl;
    data['inline_barrage_switch'] = this.inlineBarrageSwitch;
    return data;
  }
}
