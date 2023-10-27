final _nicknameRegex = RegExp(r'^[a-zA-Z0-9_.]{1,20}$');
const nicknameRequirements =
    "Никнейм должен содержать не более 20 символов и включать в себя только латинские символы, символы русского алфавита, символы '.', '_' и цифры.";

bool validateNickname(String nickname) {
  return _nicknameRegex.hasMatch(nickname);
}
