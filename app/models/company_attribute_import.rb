class CompanyAttributeImport < LocalezeImport
  PRIMARY_KEY = [:pid]

  def process_row
    m = CompanyAttribute.first(:conditions => {:attributeid => row_map[:attributeid], :groupname => row_map[:groupname], :pid => row_map[:pid]}) || create_from_row(CompanyAttribute)
    m.save
  end

  private

  def initialize_fields!
    @fields = [:pid, :attributeid, :attributename, :groupname, :grouptype, :primary]
  end
end