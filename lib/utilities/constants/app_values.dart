import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

double fullWidth = Get.width;
double fullHeight = Get.height;
double verticalPagePadding = fullHeight * 0.02;
double horizontalPagePadding = fullWidth * 0.05;
double customHorizontalSpace = Get.width * 0.04;
double smallFont = 14.spMin;
double smallHeadingFont = 18.spMin;
double headingFont = 20.sp;
List<TextInputFormatter> phoneInputFormatters = [
  FilteringTextInputFormatter.digitsOnly,
];
final Map<String, int> phoneLengthMap = {
  // North America
  "1":
      10, // USA, Canada, and other countries in the North American Numbering Plan
  "20": 9, // Egypt
  "212": 9, // Morocco
  "213": 9, // Algeria
  "216": 8, // Tunisia
  "218": 8, // Libya
  "220": 8, // Gambia
  "221": 8, // Senegal
  "222": 8, // Mauritania
  "223": 8, // Mali
  "224": 8, // Guinea
  "225": 8, // Ivory Coast
  "226": 8, // Burkina Faso
  "227": 8, // Niger
  "228": 8, // Togo
  "229": 8, // Benin
  "230": 8, // Mauritius
  "231": 8, // Liberia
  "232": 8, // Sierra Leone
  "233": 8, // Ghana
  "234": 8, // Nigeria
  "235": 8, // Chad
  "236": 8, // Central African Republic
  "237": 8, // Cameroon
  "238": 8, // Cape Verde
  "239": 8, // São Tomé and Príncipe
  "240": 8, // Equatorial Guinea
  "241": 8, // Gabon
  "242": 8, // Republic of the Congo
  "243": 8, // Democratic Republic of the Congo
  "244": 8, // Angola
  "245": 8, // Guinea-Bissau
  "246": 8, // British Indian Ocean Territory
  "247": 8, // Ascension Island
  "248": 8, // Seychelles
  "249": 8, // Sudan
  "250": 8, // Rwanda
  "251": 8, // Ethiopia
  "252": 8, // Somalia
  "253": 8, // Djibouti
  "254": 8, // Kenya
  "255": 8, // Tanzania
  "256": 8, // Uganda
  "257": 8, // Burundi
  "258": 8, // Mozambique
  "260": 8, // Zambia
  "261": 8, // Madagascar
  "262": 8, // Réunion
  "263": 8, // Zimbabwe
  "264": 8, // Namibia
  "265": 8, // Malawi
  "266": 8, // Lesotho
  "267": 8, // Botswana
  "268": 8, // Eswatini
  "269": 8, // Comoros
  "290": 8, // Saint Helena
  "291": 8, // Eritrea
  "297": 8, // Aruba
  "298": 8, // Faroe Islands
  "299": 8, // Greenland
  "30": 10, // Greece
  "31": 9, // Netherlands
  "32": 9, // Belgium
  "33": 9, // France
  "34": 9, // Spain
  "350": 9, // Gibraltar
  "351": 9, // Portugal
  "352": 9, // Luxembourg
  "353": 9, // Ireland
  "354": 8, // Iceland
  "355": 8, // Albania
  "356": 8, // Malta
  "357": 8, // Cyprus
  "358": 9, // Finland
  "359": 9, // Bulgaria
  "370": 8, // Lithuania
  "371": 8, // Latvia
  "372": 8, // Estonia
  "373": 8, // Moldova
  "374": 8, // Armenia
  "375": 9, // Belarus
  "376": 6, // Andorra
  "377": 8, // Monaco
  "378": 8, // San Marino
  "379": 8, // Vatican City
  "380": 9, // Ukraine
  "381": 8, // Serbia
  "382": 8, // Montenegro
  "383": 8, // Kosovo
  "385": 8, // Croatia
  "386": 8, // Slovenia
  "387": 8, // Bosnia and Herzegovina
  "389": 8, // North Macedonia
  "420": 9, // Czech Republic
  "421": 9, // Slovakia
  "423": 8, // Liechtenstein
  "500": 6, // Falkland Islands
  "501": 8, // Belize
  "502": 8, // Guatemala
  "503": 8, // El Salvador
  "504": 8, // Honduras
  "505": 8, // Nicaragua
  "506": 8, // Costa Rica
  "507": 8, // Panama
  "508": 8, // Saint Pierre and Miquelon
  "509": 8, // Haiti
  "51": 9, // Peru
  "52": 10, // Mexico
  "53": 8, // Cuba
  "54": 10, // Argentina
  "55": 11, // Brazil
  "56": 9, // Chile
  "57": 10, // Colombia
  "58": 10, // Venezuela
  "590": 9, // Guadeloupe
  "591": 8, // Bolivia
  "592": 8, // Guyana
  "593": 8, // Ecuador
  "594": 9, // French Guiana
  "595": 8, // Paraguay
  "596": 9, // Martinique
  "597": 8, // Suriname
  "598": 8, // Uruguay
  "60": 9, // Malaysia
  "62": 9, // Indonesia
  "63": 9, // Philippines
  "64": 9, // New Zealand
  "65": 8, // Singapore
  "66": 9, // Thailand
  "81": 10, // Japan
  "82": 10, // South Korea
  "84": 9, // Vietnam
  "86": 11, // China
  "852": 8, // Hong Kong
  "853": 8, // Macau
  "886": 9, // Taiwan
  "960": 7, // Maldives
  "961": 8, // Lebanon
  "962": 8, // Jordan
  "963": 9, // Syria
  "964": 9, // Iraq
  "965": 8, // Kuwait
  "966": 9, // Saudi Arabia
  "967": 9, // Yemen
  "968": 8, // Oman
  "971": 9, // UAE
  "972": 9, // Israel
  "973": 8, // Bahrain
  "974": 8, // Qatar
  "975": 8, // Bhutan
  "976": 8, // Mongolia
  "977": 10, // Nepal
  "98": 10, // Iran
  "992": 9, // Tajikistan
  "993": 8, // Turkmenistan
  "994": 9, // Azerbaijan
  "995": 9, // Georgia
  "996": 9, // Kyrgyzstan
  "998": 9, // Uzbekistan
};
