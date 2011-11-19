puts 'Creating users...'
User.create :email => 'rod@seologic.com', :password => '1234ab'
LocalezeImport.import 'Psychologist Sample 20111114'