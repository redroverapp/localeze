class CustomAttributeImport < LocalezeImport
  PRIMARY_KEY = [:pid, :attribute, :attributetype]

  def process_row
    m = CustomAttribute.first(:conditions => CONDITIONS) || create_from_row(CustomAttribute)
    m.save
  end

  private

  def initialize_fields!
    @fields = [:pid, :attribute, :attributetype, :description, :relevancy]
  end
end