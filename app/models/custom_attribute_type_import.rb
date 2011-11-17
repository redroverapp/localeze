class CustomAttributeTypeImport < LocalezeImport
  PRIMARY_KEY = [:attributetypeid]

  def process_row
    m = CustomAttributeType.first(:conditions => CONDITIONS) || create_from_row(CustomAttributeType)
    m.save
  end

  private

  def initialize_fields!
    @fields = [:attributetypeid, :attributetype]
  end
end