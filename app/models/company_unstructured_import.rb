class CompanyUnstructuredImport < LocalezeImport
  PRIMARY_KEY = [:pid, :attribute]

  def process_row
    m = CompanyUnstructured.first(:conditions => CONDITIONS) || create_from_row(CompanyUnstructured)
    m.save
  end

  private

  def initialize_fields!
    @fields = [:pid, :attribute, :relevancy]
  end
end