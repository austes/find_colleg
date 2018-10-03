class Colleague{
  String colleagueName;
  String colleagueSurname;
  String colleagueTeam;
  String colleaguerespons;

  Object name;

  Colleague({
    this.colleagueName,
    this.colleagueSurname,
    this.colleagueTeam,
    this.colleaguerespons
});

  factory Colleague.fromJson(Map<String, dynamic> parsedJson){
    return Colleague(
      colleagueName: parsedJson['name'],
      colleagueSurname : parsedJson['surname'],
      colleagueTeam : parsedJson ['team'],
      colleaguerespons : parsedJson ['score']
    );
  }
}