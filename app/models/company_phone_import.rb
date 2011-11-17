class CompanyPhoneImport < LocalezeImport
  PRIMARY_KEY = [:pid]

  def process_row
    m = CompanyPhone.first(:conditions => CONDITIONS) || create_from_row(CompanyPhone)
    m.save
  end

  private

  def initialize_fields!
    @fields = [:pid, :areacode, :exchange, :phonenumber, :phonetype, :valflag, :valdate, :dnc]
  end
end