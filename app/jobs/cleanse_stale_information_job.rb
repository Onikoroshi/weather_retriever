class CleanseStaleInformationJob
  def execute
    relation = WeatherInformation.where(updated_at: ..30.minutes.ago)
    ap "cleansing #{relation.count} records"
    relation.destroy_all
  end
end
