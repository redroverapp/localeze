class SicDetailImport < LocalezeImport
  PRIMARY_KEY = [:sic]

  def process_row
    m = SicDetail.first(:conditions => CONDITIONS) || create_from_row(SicDetail)
    m.save
  end

  private

  def initialize_fields!
    @fields = [:sic, :description, :sic_4, :sic_4_description, :industryclass, :naics, :naics_description]
  end
end