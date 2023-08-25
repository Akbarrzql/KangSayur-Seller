class InputValidator {
  static String? emptyValidator(value) {
    return value.toString().trim().isEmpty ? 'Bidang tidak boleh kosong' : null;
  }

  static String? emailValidator(value) {
    bool emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    return !emailValid ? 'Email tidak valid' : null;
  }

  static String? passwordValidator(value) {
    return value.toString().length < 8
        ? 'Kata sandi tidak boleh kurang dari 8 karakter'
        : null;
  }

  static String? phoneValidator(value) {
    return value.toString().length <= 11 && value.toString().length >= 12
        ? 'Nomor telepon tidak valid'
        : null;
  }

  static String? nameValidator(value) {
    return value.toString().length <= 3
        ? 'Nama tidak valid'
        : null;
  }

  static String? nameTokoValidator(value) {
    return value.toString().length <= 3
        ? 'Nama Toko tidak valid'
        : null;
  }

  static String? descTokovalidator(value){
    return value.toString().length <= 3
        ? 'Deksripsi Toko tidak valid'
        : null;
  }

  static String? addressValidator(value) {
    return value.toString().length <= 3
        ? 'Alamat tidak valid'
        : null;
  }

  static String? vehicleValidator(value) {
    return value.toString().length <= 3
        ? 'Jenis Kendaraan tidak valid'
        : null;
  }

  static String? licenseValidator(value) {
    return value.toString().length <= 3
        ? 'Nomor Polisi tidak valid'
        : null;
  }

  static String? noRangkaValidator(value) {
    return value.toString().length <= 3
        ? 'Nomor Rangka tidak valid'
        : null;
  }

  static String? emailRegisteredValidator(value) {
    return value.toString().length <= 5
        ? 'Email sudah terdaftar'
        : null;
  }

  static String? noPolisiDepan(value) {
    return value.toString().length >= 3
        ? 'Tidak valid'
        : null;
  }

  static String? noPolisiBelakang(value) {
    return value.toString().length >= 5
        ? 'Tidak valid'
        : null;
  }

  static String? noPolisiTengah(value) {
    return value.toString().trim().isEmpty && value.toString().length >= 5
        ? 'Tidak valid'
        : null;
  }
}