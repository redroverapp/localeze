class BaseRecordImport < LocalezeImport
  def process_row
    m = BaseRecord.first(:conditions => {:pid => row_map[:pid]}) || create_from_row(BaseRecord)
    m.save
  end

  private

  def initialize_fields!
    @fields = [:pid, :chainid, :pubdate, :businessname, :stdname, :subdepartment, :housenumber, :predirectional, :streetname, :streettype, :postdirectional, :apttype, :aptnumber, :exppubcity, :city, :state, :zip, :plus4, :dpc, :carrierroute, :statefips, :countyfips, :z4type, :censustract, :censusblockgroup, :censusblockid, :msa, :cbsa, :mcd, :addresssensitivity, :genrc, :mlsc, :goldflag, :dpvconfirm, :areacode, :exchange, :phonenumber, :dnc, :dso, :timezone, :valflag, :valdate, :valflag2, :confidencescore, :llmatchlevel, :latitude, :longitude, :firstyear, :stdhours, :hoursopen, :tagline, :filler53, :filler54, :filler55, :filler56, :filler57, :filler58, :filler59, :filler60, :filler61, :filler62, :filler63, :filler64, :filler65]
  end
end