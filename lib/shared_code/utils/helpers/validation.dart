class Validation {
  static bool isPhoneValid(String phone) {
    final regexPhone = RegExp(r'^[0-9]+$');
    return regexPhone.hasMatch(phone);
  }

  static bool isNumberValid(String id) {
    final regex = RegExp(r'^[0-9]+$');
    return regex.hasMatch(id);
  }

  static bool isPassValid(String? pass) {
    if (pass == null) {
      return false;
    }
    return pass.length >= 6;
  }

  static bool isPhoneVietnameseValid(String phone) {
    // var viettel = '086|096|097|098|032|033|034|035|036|037|038|039|';
    // var mobi = '089|090|093|070|071|072|076|077|078|079|';
    // var vina = '088|091|094|083|084|085|081|082|';
    // var vietnamobile = '092|056|058|';
    // var gmobile = '099|059|';
    // var sFone = '095';

    if (phone != '' && phone.length < 10) {
      return false;
    }

    final regexPhone = RegExp(r'(086|096|097|098|032|033|034|035|036|037|038|039|'
        r'089|090|093|070|071|072|076|077|078|079|'
        r'088|091|094|083|084|085|081|082|'
        r'092|056|058|'
        r'099|059|'
        r'095)[0-9]+$');

    return regexPhone.hasMatch(phone);
  }

  static bool isEmailValid(String email) {
    final regexEmail = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return regexEmail.hasMatch(email);
  }

  static bool isCharactersValid(String? character) {
    if (character == null) {
      return false;
    }
    final regexCharacters = RegExp(r'^[a-zA-Z0-9]+$');
    return regexCharacters.hasMatch(character);
  }

  static bool isCharactersVietnameseValid(String character) {
    final regexCharacters = RegExp(
        r'^[a-zA-Z _ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼẾỀỂưăạảấầẩẫậắằẳẵặẹẻẽềếểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲÝỴÝỶỸửữựỳýỵỷỹ]+$');
    return regexCharacters.hasMatch(character);
  }

  static bool isAddressVietnameseValid(String character) {
    final regexCharacters = RegExp(
        r'^[a-zA-Z0-9./,\ _ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼẾỀỂưăạảấầẩẫậắằẳẵặẹẻẽềếểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲÝỴÝỶỸửữựỳýỵỷỹ]+$');
    return regexCharacters.hasMatch(character);
  }

  static bool isPrivateId(String id) {
    if (id.isEmpty || id == '') {
      return false;
    }

    if ((id.length != 9 && id.length != 12)) {
      return false;
    }

    return true;
  }

  static bool checkDisplaySameValid(String newPassWord, String reInputPassWord) {
    return reInputPassWord == newPassWord;
  }

  static bool isSixWordValid(String text) {
    return text.length == 6;
  }

  static bool isFourWordValid(String text) {
    return text.length == 4;
  }
}
