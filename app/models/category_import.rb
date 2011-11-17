class CategoryImport < LocalezeImport
  PRIMARY_KEY = [:pid]

  def process_row
    m = Category.first(:conditions => CONDITIONS) || create_from_row(Category)
    m.save
  end

  private

  def initialize_fields!
    @fields = [:categoryid, :categoryname]
  end
end