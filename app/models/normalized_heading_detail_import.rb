class NormalizedHeadingDetailImport < LocalezeImport
  PRIMARY_KEY = [:normalizedid]

  def process_row
    m = NormalizedHeadingDetail.first(:conditions => CONDITIONS) || create_from_row(NormalizedHeadingDetail)
    m.save
  end

  private

  def initialize_fields!
    @fields = [:normalizedid, :normalizedname]
  end
end