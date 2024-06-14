enum Recurrence {
  nenhuma('NENHUMA'),
  diariamente('DIARIAMENTE'),
  semanalmente('SEMANALMENTE'),
  mensalmente('MENSALMENTE'),
  anualmente('ANUALMENTE');

  const Recurrence(this.label);
  final String label;
}
