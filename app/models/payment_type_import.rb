class PaymentTypeImport < LocalezeImport
  PRIMARY_KEY = [:paymenttypeid]

  def process_row
    m = PaymentType.first(:conditions => CONDITIONS) || create_from_row(PaymentType)
    m.save
  end

  private

  def initialize_fields!
    @fields = [:paymenttypeid, :paymenttype]
  end
end