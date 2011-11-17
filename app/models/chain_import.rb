class ChainImport < LocalezeImport
  PRIMARY_KEY = [:pid]

  def process_row
    m = Chain.first(:conditions => {:chainid => row_map[:chainid]}) || create_from_row(Chain)
    m.save
  end

  private

  def initialize_fields!
    @fields = [:chainid, :stdname]
  end
end