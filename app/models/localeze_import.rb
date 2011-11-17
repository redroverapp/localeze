class LocalezeImport < ScaffoldLogic::DataImport
  MODEL_ATTRIBUTES = {
    BaseRecord => {
      :fields => [:pid, :chainid, :pubdate, :businessname, :stdname, :subdepartment, :housenumber, :predirectional, :streetname, :streettype, :postdirectional, :apttype, :aptnumber, :exppubcity, :city, :state, :zip, :plus4, :dpc, :carrierroute, :statefips, :countyfips, :z4type, :censustract, :censusblockgroup, :censusblockid, :msa, :cbsa, :mcd, :addresssensitivity, :genrc, :mlsc, :goldflag, :dpvconfirm, :areacode, :exchange, :phonenumber, :dnc, :dso, :timezone, :valflag, :valdate, :valflag2, :confidencescore, :llmatchlevel, :latitude, :longitude, :firstyear, :stdhours, :hoursopen, :tagline, :filler53, :filler54, :filler55, :filler56, :filler57, :filler58, :filler59, :filler60, :filler61, :filler62, :filler63, :filler64, :filler65],
      :filename => 'baserecords.txt',
      :primary_keys => [:pid]
    },
    Category => {
      :fields => [:categoryid, :categoryname],
      :filename => 'categories.txt',
      :primary_keys => [:categoryid]
    },
    Chain => {
      :fields => [:chainid, :stdname],
      :filename => 'chains.txt',
      :primary_keys => [:chainid]
    },
    CompanyAttribute => {
      :fields => [:pid, :attributeid, :attributename, :groupname, :grouptype, :primary],
      :filename => 'companyattributes.txt',
      :primary_keys => [:pid, :attributeid, :groupname]
    },
    CompanyHeading => {
      :fields => [:pid, :normalizedid, :condensedid, :categoryid, :relevancy],
      :filename => 'companyheadings.txt',
      :primary_keys => [:pid, :normalizedid]
    },
    CompanyLanguage => {
      :fields => [:pid, :languageid],
      :filename => 'companylanguages.txt',
      :primary_keys => [:pid, :languageid]
    },
    CompanyPaymentType => {
      :fields => [:pid, :paymenttypeid],
      :filename => 'companypaymenttypes.txt',
      :primary_keys => [:pid, :paymenttypeid]
    },
    CompanyPhone => {
      :fields => [:pid, :areacode, :exchange, :phonenumber, :phonetype, :valflag, :valdate, :dnc],
      :filename => 'companyphones.txt',
      :primary_keys => [:pid, :areacode, :exchange, :phonenumber, :phonetype]
    },
    CompanySic => {
      :fields => [:pid, :sic, :relevancy],
      :filename => 'companysic.txt',
      :primary_keys => [:pid, :sic]
    },
    CompanyUnstructured => {
      :fields => [:pid, :attribute, :relevancy],
      :filename => 'companyunstructured.txt',
      :primary_keys => [:pid, :attribute]
    },
    CondensedHeadingDetail => {
      :fields => [:condensedid, :condensedname],
      :filename => 'condensedheadingdetail.txt',
      :primary_keys => [:condensedid]
    },
    CustomAttribute => {
      :fields => [:pid, :attribute, :attributetype, :description, :relevancy],
      :filename => 'customattributes.txt',
      :primary_keys => [:pid, :attribute, :attributetype]
    },
    CustomAttributeType => {
      :fields => [:attributetypeid, :attributetype],
      :filename => 'customattributestypes.txt',
      :primary_keys => [:attributetypeid]
    },
    Language => {
      :fields => [:languageid, :languagename],
      :filename => 'languages.txt',
      :primary_keys => [:languageid]
    },
    NormalizedHeadingDetail => {
      :fields => [:normalizedid, :normalizedname],
      :filename => 'normalizedheadingdetail.txt',
      :primary_keys => [:normalizedid]
    },
    PaymentType => {
      :fields => [:paymenttypeid, :paymenttype],
      :filename => 'paymenttypes.txt',
      :primary_keys => [:paymenttypeid]
    },
    SicDetail => {
      :fields => [:sic, :description, :sic_4, :sic_4_description, :industryclass, :naics, :naics_description],
      :filename => 'sicdetail.txt',
      :primary_keys => [:sic]
    }
  }.freeze

  def self.pre_process dir, model
    path = "db/#{dir}/Sample/#{MODEL_ATTRIBUTES[model][:filename]}"
    puts "Reading #{path}"
    tmp_path = "tmp/#{MODEL_ATTRIBUTES[model][:filename]}"
    File.open(tmp_path, 'w') {|f| f.puts File.read(path).gsub(/"/, %{&quot;})}
    tmp_path
  end

  def self.import dir
    MODEL_ATTRIBUTES.keys.sort_by{ |m| m.to_s }.inject({}) do |h, model|
      self.import_model dir, model
      h[model] = model.count
      h
    end
  end

  # Calls overriden initializer.
  def self.import_model dir, model
    new(dir, model).run
  end

  # Instance Methods: Overrides ====================================================================

  # Overrides initializer to use parameters from MODEL_ATTRIBUTES.
  def initialize dir, model
    @file = LocalezeImport.pre_process dir, model
    @fields = MODEL_ATTRIBUTES[model][:fields]
    @model = model
  end

  # Overrides row index, column separator, and row initialization.
  def run
    return unless File.size?(@file) > 5
    @errors = []
    @row_index = 0

    FasterCSV.foreach(file, :col_sep => '|', :row_sep => :auto) do |arg|
      @row = arg
      initialize_row_map!
      process_row
      @row_index += 1
    end

    @errors
  end

  # Instance Methods ===============================================================================
  def process_row
    model = @model.first( :conditions => primary_key_conditions ) || create_from_row(@model)
    model.save
  end

  private

  def primary_key_conditions
    MODEL_ATTRIBUTES[@model][:primary_keys].inject({}){ |h, pk| h[pk] = row_map[pk.to_s]; h }
  end
end