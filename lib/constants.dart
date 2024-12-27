class Constants {
  // Modes
  static const int MODE_UNKNOWN = 1;
  static const int MODE_COLLECT = 2;
  static const int MODE_DELETE = 3;
  static const int MODE_INFO = 4;
  static const int MODE_INSERT = 5;
  static const int MODE_LIST = 6;
  static const int MODE_UPDATE = 7;

  // Menus
  static const int MENU_STANDARD = 1;
  static const int MENU_BUTTONS = 2;

  // Database Types
  static const int DBTYPE_UNKNOWN = 1;
  static const int DBTYPE_BLOB = 2;
  static const int DBTYPE_BOOLEAN = 3;
  static const int DBTYPE_BYTE = 4;
  static const int DBTYPE_BYTEARRAY = 5;
  static const int DBTYPE_DATETIME = 6;
  static const int DBTYPE_FLOAT = 7;
  static const int DBTYPE_INTEGER = 8;
  static const int DBTYPE_MONEY = 9;
  static const int DBTYPE_STRING = 10;
  static const int DBTYPE_TIME = 11;

  // Input Types
  static const int INPUT_NULL = 1;
  static const int INPUT_STRING = 2;
  static const int INPUT_TEXTBOX = 3;
  static const int INPUT_CHECKBOX = 4;
  static const int INPUT_INTEGER = 5;
  static const int INPUT_FLOAT = 6;
  static const int INPUT_PHONE = 7;
  static const int INPUT_DECIMAL = 8;
  static const int INPUT_EXTRAS = 9;
  static const int INPUT_DATE = 10;
  static const int INPUT_TIME = 11;
  static const int INPUT_CONTACT = 12;
  static const int INPUT_SPIN_ARRAY = 13;
  static const int INPUT_SPIN_DB = 14;
  static const int INPUT_EMAIL = 15;
  static const int INPUT_BYTE = 16;
  static const int INPUT_MONEY = 17;
  static const int INPUT_SEARCH_WITH_IMAGE = 18;
  static const int INPUT_SCANINT = 19;
  static const int INPUT_SCANSTRING = 20;
  static const int INPUT_BARCODE = 21;
  static const int INPUT_PICTURE = 22;
  static const int INPUT_BYTEARRAY = 23;
  static const int INPUT_BACKGROUND = 24;
  static const int INPUT_RATINGBAR = 25;
  static const int INPUT_HELP = 26;
  static const int INPUT_SEARCH_TEXT_ONLY = 27;

  // Actions
  static const int ACT_ADD = 1;
  static const int ACT_EDIT = 2;
  static const int ACT_DELETE = 3;
  static const int ACT_CALL = 4;
  static const int ACT_MAP = 5;
  static const int ACT_DIRECTIONS = 6;
  static const int ACT_WEBSITE = 7;

  // Utility method to fetch options
  static List<String>? getOptions(String name) {
    switch (name) {
      case "_categoryid":
        return [
          "Auto",
          "Beauty",
          "Clothing",
          "Entertainment",
          "Food",
          "Health",
          "Home",
          "Pets",
          "Services",
          "Travel"
        ];
      case "_account":
        return ["Checking", "Master", "Visa", "American Express", "PayPal"];
      case "_loantype":
        return ["Micro<50k", "Medium<1k", "Large>1K"];
      case "_inputtype":
        return [
          "UNKNOWN",
          "STRING",
          "TEXTBOX",
          "CHECKBOX",
          "INTEGER",
          "FLOAT",
          "PHONE",
          "DECIMAL",
          "EXTRAS",
          "DATE",
          "TIME",
          "CONTACT",
          "SPIN_ARRAY",
          "SPIN_DB",
          "EMAIL",
          "BYTE",
          "MONEY",
          "SEARCH WITH IMAGE",
          "SCANINT",
          "SCANSTRING",
          "BARCODE",
          "PICTURE",
          "BYTEARRAY",
          "BACKGROUND",
          "RATINGBAR",
          "HELP",
          "SEARCH TEXT ONLY"
        ];
      case "_dbtype":
        return [
          "UNKNOWN",
          "BLOB",
          "BOOLEAN",
          "BYTE",
          "BYTEARRAY",
          "DATETIME",
          "FLOAT",
          "INTEGER",
          "MONEY",
          "STRING",
          "TIME"
        ];
      case "_mode":
      case "_targetmode":
      case "_targetmodeid":
        return [
          "UNKNOWN",
          "COLLECT",
          "DELETE",
          "INFO",
          "INSERT",
          "LIST",
          "UPDATE"
        ];
      default:
        return null;
    }
  }
}
enum EnumActions {
  none,
  add,
  edit,
  delete,
  save,
  info,
  call,
  map,
  directions,
  website,
  scanner,
  qrScanner,
  pickImage,
  pickContact,
}

enum enumControls {
	None,
	Browser,
	Dialer,
	FormAdd,
	GridView,
	ListView,
	Mapper,
	Message,
	Splash,
	TabFrame,
	TableView
}