class LocalezeImport < ScaffoldLogic::DataImport
  MODELS_TO_FILES = {
    BaseRecordImport => 'baserecords.txt',
    CategoryImport => 'categories.txt'
#     Chain => 'chains.txt',
#     CompanyAttribute => 'companyattributes.txt',
#     CompanyHeading => 'companyheadings.txt',
#     CompanyPaymentType => 'companypaymenttypes.txt',
#     CompanyPhone => 'companyphones.txt',
#     CompanySic => 'companysic.txt',
#     CompanyUnstructured => 'companyunstructured.txt',
#     CondensedHeadingDetail => 'condensedheadingdetail.txt',
#     CustomAttribute => 'customattributes.txt',
#     CustomAttributeType => 'customattributetypes.txt',
#     Language => 'languages.txt',
#     NormalizedHeadingDetail => 'normalizedheadingdetail.txt',
#     PaymentType => 'paymenttypes.txt',
#     SicDetail => 'sicdetail.txt'
  }.freeze

  def self.import dir
    MODELS_TO_FILES.inject({}) do |h, (import_model, file)|
      import_model.test "db/#{dir}/Sample/#{file}"
      model = Kernel.const_get(import_model.name.gsub 'Import', '')
      h[model] = model.count
      h
    end
  end

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