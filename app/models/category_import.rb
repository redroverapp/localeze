class CategoryImport < LocalezeImport
  def process_row
    m = Category.first(:conditions => {:categoryid => row_map[:categoryid]}) || create_from_row(Category)
    m.save
  end

  private

  def initialize_fields!
    @fields = [:categoryid, :categoryname]
  end
end