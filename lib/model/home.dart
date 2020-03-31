class HomeStatisticsModel {
  dynamic todayCar;
  dynamic todayCardConsume;
  dynamic todayCardIncome;
  dynamic todayMemberCar;
  dynamic todayMemberCount;
  dynamic todayTotal;
  dynamic yesterdayCar;
  dynamic yesterdayCardConsume;
  dynamic yesterdayCardIncome;
  dynamic yesterdayMemberCar;
  dynamic yesterdayMemberCount;
  dynamic yesterdayTotal;
  dynamic notPaidOrderCount;

  HomeStatisticsModel(
      {this.todayCar,
      this.todayCardConsume,
      this.todayCardIncome,
      this.todayMemberCar,
      this.todayMemberCount,
      this.todayTotal,
      this.yesterdayCar,
      this.yesterdayCardConsume,
      this.yesterdayCardIncome,
      this.yesterdayMemberCar,
      this.yesterdayMemberCount,
      this.notPaidOrderCount,
      this.yesterdayTotal});

  factory HomeStatisticsModel.fromJson(Map<String, dynamic> json) {
    return HomeStatisticsModel(
      todayCar: json['todayCar'],
      todayCardConsume: json['todayCardConsume'],
      todayCardIncome: json['todayCardIncome'],
      todayMemberCar: json['todayMemberCar'],
      todayMemberCount: json['todayMemberCount'],
      todayTotal: json['todayTotal'],
      yesterdayCar: json['yesterdayCar'],
      yesterdayCardConsume: json['yesterdayCardConsume'],
      yesterdayCardIncome: json['yesterdayCardIncome'],
      yesterdayMemberCar: json['yesterdayMemberCar'],
      yesterdayMemberCount: json['yesterdayMemberCount'],
      notPaidOrderCount: json['notPaidOrderCount'],
      yesterdayTotal: json['yesterdayTotal'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['todayCar'] = this.todayCar;
    data['todayCardConsume'] = this.todayCardConsume;
    data['todayCardIncome'] = this.todayCardIncome;
    data['todayMemberCar'] = this.todayMemberCar;
    data['todayMemberCount'] = this.todayMemberCount;
    data['todayTotal'] = this.todayTotal;
    data['yesterdayCar'] = this.yesterdayCar;
    data['yesterdayCardConsume'] = this.yesterdayCardConsume;
    data['yesterdayCardIncome'] = this.yesterdayCardIncome;
    data['yesterdayMemberCar'] = this.yesterdayMemberCar;
    data['yesterdayMemberCount'] = this.yesterdayMemberCount;
    data['yesterdayTotal'] = this.yesterdayTotal;
    data['notPaidOrderCount'] = this.notPaidOrderCount;
    return data;
  }
}
