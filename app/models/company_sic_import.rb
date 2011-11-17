class CompanySicImport < LocalezeImport
  PRIMARY_KEY = [:pid]

  def process_row
    m = CompanySic.first(:conditions => CONDITIONS) || create_from_row(CompanySic)
    m.save
  end

  private

  def initialize_fields!
    @fields = [:pid, :sic, :relevancy]
  end
end