

class SubscriptionInfo {
  String startSubscription;

  String endSubscription;

  int numberDays;

  SubscriptionInfo(
      {this.startSubscription, this.endSubscription, this.numberDays});

  SubscriptionInfo.fromJson(Map<String, dynamic> json) {
    startSubscription = json['start_subscription'];
    endSubscription = json['end_subscription'];
    numberDays = json['number_days'];
  }

  Map<String, dynamic> toJson() {
    return {
      'start_subscription': startSubscription,
      'end_subscription': endSubscription,
      'number_days': numberDays,
    };
  }
}
