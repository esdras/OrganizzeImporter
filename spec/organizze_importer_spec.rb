require File.join(File.dirname(__FILE__), '..', 'lib', 'organizze_importer')
describe OrganizzeImporter do

  before do
    ofx = File.open(File.join(File.dirname(__FILE__), '..', 'lib', 'data', 'ArquivoFinanceiro.ofx'), 'r')
    @importer = OrganizzeImporter::Importer.new(ofx)
    @importer.parse!
  end

  it 'should recognize the file format' do
    txt = File.new("teste.txt", 'w')
    ofx = File.new("teste.ofx", 'w')

    lambda {OrganizzeImporter::Importer.new(txt)}.should raise_error

    ofx_parser = OrganizzeImporter::Importer.new(ofx)
    ofx_parser.ofx?.should be_true
  end

  it 'should return the attributes of the parsed ofx file' do
    @importer.type.should == :checking
    @importer.id.should == "116115"
    @importer.bank_id.should == "0237"
    @importer.currency.should == "BRL"
    @importer.balance.amount.should == 1057.63
  end

  it 'should return the collection of transactions' do
    collection = @importer.collection
    collection.size.should == 19
    transaction = collection.first
    transaction.type.should == :debit
    transaction.amount.should == -150.00
    transaction.memo.should == "Ag00951maq020919seq08899 - SAQUE CC AUTOAT"
    transaction.check_number.should == "919899"
  end

end
