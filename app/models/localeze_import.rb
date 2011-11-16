class LocalezeImport < ScaffoldLogic::DataImport
  def self.test path
    text = File.read path
    File.open(path, 'w') {|file| file.puts text.gsub(/"/, %{&quot;})}
    self.run path
  end

  def run
    @errors = []
    @row_index = 0

    FasterCSV.foreach(file, :col_sep => '|', :row_sep => :auto) do |arg|
      @row = arg
      initialize_fields! unless @fields
      initialize_row_map!
      process_row
      @row_index += 1
    end

    @errors
  end
end