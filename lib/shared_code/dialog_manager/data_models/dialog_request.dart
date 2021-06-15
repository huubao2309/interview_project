class DialogRequest {
  DialogRequest({
    required this.title,
    required this.description,
    required this.typeDialog,
    required this.isMustTapButton,
    required this.titleButton,
  });

  final String title;
  final String description;
  final String typeDialog;
  final bool isMustTapButton;
  final String titleButton;
}
