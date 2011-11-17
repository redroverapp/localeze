class CompanyHeadingImport < LocalezeImport
  PRIMARY_KEY = [:pid]

  def process_row
    m = CompanyHeading.first(:conditions => CONDITIONS) || create_from_row(CompanyHeading)
    m.save
  end

  private

  def initialize_fields!
    @fields = [:pid, :normalizedid, :condensedid, :categoryid, :relevancy]
  end
end