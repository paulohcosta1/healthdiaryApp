class MealValidator {
  String validateImage(List images) {
    if (images.isEmpty) return "Adicione uma foto da refeição";
    return null;
  }

  String validateTitle(String title) {
    if (title.isEmpty) return "Adicione um título para a refeição";
    return null;
  }
}
