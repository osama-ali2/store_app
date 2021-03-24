class Bank {
  int id;
  String name;
  String accountNo;
  String iban;

  Bank({
    this.id,
    this.name,
    this.accountNo,
    this.iban});

  Bank.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    accountNo = json["account_no"];
    iban = json["iban"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["account_no"] = accountNo;
    map["iban"] = iban;
    return map;
  }

}