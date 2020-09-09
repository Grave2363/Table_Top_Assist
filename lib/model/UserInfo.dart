class UserInfo{
   String name;
  UserInfo({this.name});
  void fromMap(Map map)
  {
    this.name = map["Name"];
  }
  String getName (){
    return this.name;
  }
}