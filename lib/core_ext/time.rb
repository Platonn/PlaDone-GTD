class Time
  def datetime_without_seconds
    self.strftime(DATETIME_WITHOUT_SECONDS_FORMAT)
  end

  private
  DATETIME_WITHOUT_SECONDS_FORMAT = "%F %H:%M"
end