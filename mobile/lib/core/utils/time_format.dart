/// Formats a backend time string (`java.time.LocalTime`'s JSON form,
/// `HH:mm:ss`) down to `HH:mm` for display. Returns `null` unchanged if the
/// input is `null` or shorter than expected, rather than throwing.
String? formatDutyTime(String? rawTime) {
  if (rawTime == null || rawTime.length < 5) return rawTime;
  return rawTime.substring(0, 5);
}
