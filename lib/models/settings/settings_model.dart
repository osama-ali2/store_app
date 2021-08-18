import 'package:yagot_app/models/settings/InformationModel.dart';
import 'package:yagot_app/models/settings/account_type.dart';
import 'package:yagot_app/models/settings/product_status.dart';
import 'package:yagot_app/models/home/category_model.dart';
import 'package:yagot_app/models/settings/bank.dart';
import 'package:yagot_app/models/settings/country.dart';
import 'package:yagot_app/models/settings/subscription_info.dart';
import 'package:yagot_app/models/settings/zone.dart';
import 'package:yagot_app/models/settings/currency.dart';
import 'package:yagot_app/models/settings/social.dart';


class SettingsModel {
  Setting setting;
  InformationModel aboutUs;
  InformationModel alqism;
  InformationModel policyPrivacy;
  InformationModel termsOhbbyist;
  InformationModel termsCompany;
  List<AccountType> accountType;
  List<CategoryModel> categories;
  List<ProductStatus> productStatuses;
  List<Country> countries;
  List<Social> social;
  List<Currency> currencies;
  List<Zones> zones;
  List<Bank> banks;
  List<Subscription> subscriptions;

  SettingsModel({
      this.setting,
      this.aboutUs,
      this.alqism,
      this.policyPrivacy,
      this.termsOhbbyist,
      this.termsCompany,
      this.accountType,
      this.categories,
      this.productStatuses,
      this.countries,
      this.social,
      this.currencies,
      this.zones,
      this.banks,
      this.subscriptions
  });

  SettingsModel.fromJson(Map<String, dynamic> json) {
    setting = json["setting"] != null ? Setting.fromJson(json["setting"]) : null;
    aboutUs = json["about_us"] != null ? InformationModel.fromJson(json["about_us"]) : null;
    alqism = json["alqism"] != null ? InformationModel.fromJson(json["alqism"]) : null;
    policyPrivacy = json["policy_privacy"] != null ? InformationModel.fromJson(json["policy_privacy"]) : null;
    termsOhbbyist = json["terms_ohbbyist"] != null ? InformationModel.fromJson(json["terms_ohbbyist"]) : null;
    termsCompany = json["terms_company"] != null ? InformationModel.fromJson(json["terms_company"]) : null;
    if (json["account_type"] != null) {
      accountType = [];
      json["account_type"].forEach((v) {
        accountType.add(AccountType.fromJson(v));
      });
    }
    if (json["category"] != null) {
      categories = [];
      json["category"].forEach((v) {
        categories.add(CategoryModel.fromJson(v));
      });
    }
    if (json["product_status"] != null) {
      productStatuses = [];
      json["product_status"].forEach((v) {
        productStatuses.add(ProductStatus.fromJson(v));
      });
    }
    if (json["country"] != null) {
      countries = [];
      json["country"].forEach((v) {
        countries.add(Country.fromJson(v));
      });
    }
    if (json["social"] != null) {
      social = [];
      json["social"].forEach((v) {
        social.add(Social.fromJson(v));
      });
    }
    if (json["currency"] != null) {
      currencies = [];
      json["currency"].forEach((v) {
        currencies.add(Currency.fromJson(v));
      });
    }
    if (json["zones"] != null) {
      zones = [];
      json["zones"].forEach((v) {
        zones.add(Zones.fromJson(v));
      });
    }
    if (json["banks"] != null) {
      banks = [];
      json["banks"].forEach((v) {
        banks.add(Bank.fromJson(v));
      });
    }
    if (json["subscriptions"] != null) {
      subscriptions = [];
      json["subscriptions"].forEach((v) {
        subscriptions.add(Subscription.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (setting != null) {
      map["setting"] = setting.toJson();
    }
    if (aboutUs != null) {
      map["about_us"] = aboutUs.toJson();
    }
    if (alqism != null) {
      map["alqism"] = alqism.toJson();
    }
    if (policyPrivacy != null) {
      map["policy_privacy"] = policyPrivacy.toJson();
    }
    if (termsOhbbyist != null) {
      map["terms_ohbbyist"] = termsOhbbyist.toJson();
    }
    if (termsCompany != null) {
      map["terms_company"] = termsCompany.toJson();
    }
    if (accountType != null) {
      map["account_type"] = accountType.map((v) => v.toJson()).toList();
    }
    if (categories != null) {
      map["category"] = categories.map((v) => v.toJson()).toList();
    }
    if (productStatuses != null) {
      map["product_status"] = productStatuses.map((v) => v.toJson()).toList();
    }
    if (countries != null) {
      map["country"] = countries.map((v) => v.toJson()).toList();
    }
    if (social != null) {
      map["social"] = social.map((v) => v.toJson()).toList();
    }
    if (currencies != null) {
      map["currency"] = currencies.map((v) => v.toJson()).toList();
    }
    if (zones != null) {
      map["zones"] = zones.map((v) => v.toJson()).toList();
    }
    if (banks != null) {
      map["banks"] = banks.map((v) => v.toJson()).toList();
    }
    if (subscriptions != null) {
      map["subscriptions"] = subscriptions.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
class Setting {
  double siteCommission;

  Setting({
      this.siteCommission});

  Setting.fromJson( Map<String, dynamic> json) {
    siteCommission = json["site_commission"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["site_commission"] = siteCommission;
    return map;
  }

}