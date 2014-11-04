class DateTimeExt

  def datetime_without_seconds
    self.to_time.strftime(DATETIME_WITHOUT_SECONDS_FORMAT)
  end
end