class CompanyPaymentTypeImport < LocalezeImport
  PRIMARY_KEY = [:pid]

  def process_row
    m = CompanyPaymentType.first(:conditions => CONDITIONS) || create_from_row(CompanyPaymentType)
    m.save
  end

  private

  def initialize_fields!
    @fields = [:pid, :paymenttypeid]
  end
end