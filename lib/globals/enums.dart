enum ControlType {
  none,
  browser,
  dialer,
  formAdd,
  gridView,
  listView,
  mapper,
  message,
  splash,
  tabFrame,
  tableView,
}

enum ControlActions {
  none,
  add,
  edit,
  delete,
  save,
  info,
  call,
  map,
  directions,
  webSite,
  scanner,
  qrScanner,
  pickImage,
  pickContact,
}

enum ControlMode {
  unknown,
  collect,
  delete,
  info,
  insert,
  list,
  update,
}

enum MenuType {
  standard,
  buttons,
}

enum DbType {
  unknown,
  blob,
  boolean,
  byte,
  byteArray,
  dateTime,
  float,
  integer,
  money,
  string,
  time,
}

enum InputType {
  nullInput,
  string,
  textBox,
  checkBox,
  integer,
  float,
  phone,
  decimal,
  extras,
  date,
  time,
  contact,
  spinArray,
  spinDb,
  email,
  byte,
  money,
  searchWithImage,
  scanInt,
  scanString,
  barcode,
  picture,
  byteArray,
  background,
  ratingBar,
  help,
  searchTextOnly,
}