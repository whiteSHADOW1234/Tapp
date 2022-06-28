class TaipeiBusRoute {
  String? routeUID;
  String? routeID;
  bool? hasSubRoutes;
  List<Operators>? operators;
  String? authorityID;
  String? providerID;
  List<SubRoutes>? subRoutes;
  int? busRouteType;
  OperatorName? routeName;
  String? departureStopNameZh;
  String? departureStopNameEn;
  String? destinationStopNameZh;
  String? destinationStopNameEn;
  String? ticketPriceDescriptionZh;
  String? ticketPriceDescriptionEn;
  String? routeMapImageUrl;
  String? city;
  String? cityCode;
  String? updateTime;
  int? versionID;

  TaipeiBusRoute(
      {this.routeUID,
      this.routeID,
      this.hasSubRoutes,
      this.operators,
      this.authorityID,
      this.providerID,
      this.subRoutes,
      this.busRouteType,
      this.routeName,
      this.departureStopNameZh,
      this.departureStopNameEn,
      this.destinationStopNameZh,
      this.destinationStopNameEn,
      this.ticketPriceDescriptionZh,
      this.ticketPriceDescriptionEn,
      this.routeMapImageUrl,
      this.city,
      this.cityCode,
      this.updateTime,
      this.versionID});

  TaipeiBusRoute.fromJson(Map<String, dynamic> json) {
    routeUID = json['RouteUID'];
    routeID = json['RouteID'];
    hasSubRoutes = json['HasSubRoutes'];
    if (json['Operators'] != null) {
      operators = <Operators>[];
      json['Operators'].forEach((v) {
        operators!.add(new Operators.fromJson(v));
      });
    }
    authorityID = json['AuthorityID'];
    providerID = json['ProviderID'];
    if (json['SubRoutes'] != null) {
      subRoutes = <SubRoutes>[];
      json['SubRoutes'].forEach((v) {
        subRoutes!.add(new SubRoutes.fromJson(v));
      });
    }
    busRouteType = json['BusRouteType'];
    routeName = json['RouteName'] != null
        ? new OperatorName.fromJson(json['RouteName'])
        : null;
    departureStopNameZh = json['DepartureStopNameZh'];
    departureStopNameEn = json['DepartureStopNameEn'];
    destinationStopNameZh = json['DestinationStopNameZh'];
    destinationStopNameEn = json['DestinationStopNameEn'];
    ticketPriceDescriptionZh = json['TicketPriceDescriptionZh'];
    ticketPriceDescriptionEn = json['TicketPriceDescriptionEn'];
    routeMapImageUrl = json['RouteMapImageUrl'];
    city = json['City'];
    cityCode = json['CityCode'];
    updateTime = json['UpdateTime'];
    versionID = json['VersionID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RouteUID'] = this.routeUID;
    data['RouteID'] = this.routeID;
    data['HasSubRoutes'] = this.hasSubRoutes;
    if (this.operators != null) {
      data['Operators'] = this.operators!.map((v) => v.toJson()).toList();
    }
    data['AuthorityID'] = this.authorityID;
    data['ProviderID'] = this.providerID;
    if (this.subRoutes != null) {
      data['SubRoutes'] = this.subRoutes!.map((v) => v.toJson()).toList();
    }
    data['BusRouteType'] = this.busRouteType;
    if (this.routeName != null) {
      data['RouteName'] = this.routeName!.toJson();
    }
    data['DepartureStopNameZh'] = this.departureStopNameZh;
    data['DepartureStopNameEn'] = this.departureStopNameEn;
    data['DestinationStopNameZh'] = this.destinationStopNameZh;
    data['DestinationStopNameEn'] = this.destinationStopNameEn;
    data['TicketPriceDescriptionZh'] = this.ticketPriceDescriptionZh;
    data['TicketPriceDescriptionEn'] = this.ticketPriceDescriptionEn;
    data['RouteMapImageUrl'] = this.routeMapImageUrl;
    data['City'] = this.city;
    data['CityCode'] = this.cityCode;
    data['UpdateTime'] = this.updateTime;
    data['VersionID'] = this.versionID;
    return data;
  }
}

class Operators {
  String? operatorID;
  OperatorName? operatorName;
  String? operatorCode;
  String? operatorNo;

  Operators(
      {this.operatorID, this.operatorName, this.operatorCode, this.operatorNo});

  Operators.fromJson(Map<String, dynamic> json) {
    operatorID = json['OperatorID'];
    operatorName = json['OperatorName'] != null
        ? new OperatorName.fromJson(json['OperatorName'])
        : null;
    operatorCode = json['OperatorCode'];
    operatorNo = json['OperatorNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OperatorID'] = this.operatorID;
    if (this.operatorName != null) {
      data['OperatorName'] = this.operatorName!.toJson();
    }
    data['OperatorCode'] = this.operatorCode;
    data['OperatorNo'] = this.operatorNo;
    return data;
  }
}

class OperatorName {
  String? zhTw;
  String? en;

  OperatorName({this.zhTw, this.en});

  OperatorName.fromJson(Map<String, dynamic> json) {
    zhTw = json['Zh_tw'];
    en = json['En'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Zh_tw'] = this.zhTw;
    data['En'] = this.en;
    return data;
  }
}

class SubRoutes {
  String? subRouteUID;
  String? subRouteID;
  List<String>? operatorIDs;
  OperatorName? subRouteName;
  int? direction;
  String? firstBusTime;
  String? lastBusTime;
  String? holidayFirstBusTime;
  String? holidayLastBusTime;

  SubRoutes(
    {
      this.subRouteUID,
      this.subRouteID,
      this.operatorIDs,
      this.subRouteName,
      this.direction,
      this.firstBusTime,
      this.lastBusTime,
      this.holidayFirstBusTime,
      this.holidayLastBusTime
    }
  );

  SubRoutes.fromJson(Map<String, dynamic> json) {
    subRouteUID = json['SubRouteUID'];
    subRouteID = json['SubRouteID'];
    operatorIDs = json['OperatorIDs'].cast<String>();
    subRouteName = json['SubRouteName'] != null
        ? new OperatorName.fromJson(json['SubRouteName'])
        : null;
    direction = json['Direction'];
    firstBusTime = json['FirstBusTime'];
    lastBusTime = json['LastBusTime'];
    holidayFirstBusTime = json['HolidayFirstBusTime'];
    holidayLastBusTime = json['HolidayLastBusTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SubRouteUID'] = this.subRouteUID;
    data['SubRouteID'] = this.subRouteID;
    data['OperatorIDs'] = this.operatorIDs;
    if (this.subRouteName != null) {
      data['SubRouteName'] = this.subRouteName!.toJson();
    }
    data['Direction'] = this.direction;
    data['FirstBusTime'] = this.firstBusTime;
    data['LastBusTime'] = this.lastBusTime;
    data['HolidayFirstBusTime'] = this.holidayFirstBusTime;
    data['HolidayLastBusTime'] = this.holidayLastBusTime;
    return data;
  }
}
