require 'vistasoft'

RSpec.configure do |config|

end

def busca_imoveis_params
  {
    'key'        => 'thekey',
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