/// Lowercases [input] using Turkish casing rules rather than Dart's default
/// Unicode casing.
///
/// Dart's `String.toLowerCase()` maps both ASCII `I` and Turkish `İ` to the
/// same dotted `i`, which loses the distinction Turkish relies on (`I` ->
/// dotless `ı`, `İ` -> dotted `i`). Left uncorrected, a search for "Kadıköy"
/// typed with a dotless `ı` would fail to match "KADIKÖY" from the backend,
/// since the built-in lowercase turns the `I` into `i` instead of `ı`.
String normalizeTurkish(String input) {
  return input.replaceAll('İ', 'i').replaceAll('I', 'ı').toLowerCase();
}
