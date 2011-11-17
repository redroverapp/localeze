class CondensedHeadingDetailImport < LocalezeImport
  PRIMARY_KEY = [:condensedid]

  def process_row
    m = CondensedHeadingDetail.first(:conditions => CONDITIONS) || create_from_row(CondensedHeadingDetail)
    m.save
  end

  private

  def initialize_fields!
    @fields = [:condensedid, :condensedname]
  end
end