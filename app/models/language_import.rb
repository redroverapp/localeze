class LanguageImport < LocalezeImport
  PRIMARY_KEY = [:languageid]

  def process_row
    m = Language.first(:conditions => CONDITIONS) || create_from_row(Language)
    m.save
  end

  private

  def initialize_fields!
    @fields = [:languageid, :languagename]
  end
end