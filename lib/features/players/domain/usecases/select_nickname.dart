final _nicknameRegex = RegExp(r'^[a-zA-Zа-яА-ЯёЁ0-9_.\s]{1,20}$');
const nicknameRequirements =
    "Никнейм должен содержать от 1 до 20 символов и включать в себя только латинские символы, символы русского алфавита, пробел, символы '.', '_' и цифры.";

bool validateNickname(String nickname) {
  return _nicknameRegex.hasMatch(nickname);
}
