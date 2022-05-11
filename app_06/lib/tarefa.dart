class Tarefa
{
  late String Title;
  late String Subtitle;
  late bool State;

  Tarefa(this.Title, this.Subtitle, [this.State = false]);

  Map toJson() => {
    'title': Title,
    'subtitle': Subtitle,
    'state': State
  };

  Tarefa.fromJson(json) {
    Title = json["title"];
    Subtitle = json["subtitle"];
    State = json["state"];
  }
}