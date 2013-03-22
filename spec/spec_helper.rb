
require 'simplecov'

SimpleCov.start do
  add_filter "spec"
end


require 'vistasoft'
require 'savon'

Dir["./spec/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
end

def busca_imoveis_params
  {
    'key'        => VISTA_CUSTOMER_KEY,
    'module'     => 'imoveis',
    'method'     => 'busca_imoveis',
    'field'      => {
      'CODIGO'     => 'Codigo',
      'CATEGORIA'  => 'Categoria',
      'VLR_VENDA'  => 'Valor',
      'CIDADE'     => 'Cidade',
      'BAIRRO'     => 'Bairro',
      'DORMITORIO' => 'Dormitorios',
      'VAGAS'      => 'NumeroVagas',
      'IMAGEM_G'   => 'Foto',
      'URL_FOTO'   => 'Url',
      'DESCRICAO'  => 'Descricao'
    },
    'order'      => {'VLR_VENDA' => 'DESC'},
    'limit'      => '0,10'
  }
end

def busca_imoveis_request
  Vistasoft::Soap::XmlRequest.new(busca_imoveis_params)
end

def test_builder
  Builder::XmlMarkup.new(indent: 2)
end

def xml_request_message(params = {})
  Vistasoft::Soap::XmlRequestMessage.new(params)
end