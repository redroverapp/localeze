class BaseRecord
  include Mongoid::Document
  include Mongoid::Timestamps

  index :pid

  def company_attributes
    CompanyAttribute.where :pid => self.pid
  end

  def company_headings
    CompanyHeading.where :pid => self.pid
  end

  def company_languages
    CompanyLanguage.where :pid => self.pid
  end

  def company_payment_types
    CompanyPaymentType.where :pid => self.pid
  end

  def company_phones
    CompanyPhone.where :pid => self.pid
  end

  def company_sics
    CompanySic.where :pid => self.pid
  end

  def company_unstructureds
    CompanyUnstructured.where :pid => self.pid
  end

  def custom_attributes
    CustomAttribute.where :pid => self.pid
  end
end