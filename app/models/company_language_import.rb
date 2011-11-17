class CompanyLanguageImport < LocalezeImport
  PRIMARY_KEY = [:pid]

  def process_row
    m = CompanyLanguage.first(:conditions => CONDITIONS) || create_from_row(CompanyLanguage)
    m.save
  end

  private

  def initialize_fields!
    @fields = [:pid, :languageid]
  end
end