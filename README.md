# Vistasoft Soap API

The ruby API for accessing the vistasoft SOAP interface.
[VistSoft.com.br](http://vistasoft.com.br/)
## See the soap specification

[Soap Specification](http://www.vistasoft.com.br/download/RQV_035%20-%20Integra%C3%A7%C3%A3o%20dos%20Im%C3%B3veis%20no%20Website%20ver2_rev01.pdf)

## Usage example
### Method: busca_imoveis

```ruby

params = {
  'key'        => '{the client code}',
  'module'     => 'imoveis',
  'method'     => 'busca_imoveis',
  'field'      => {
    'CODIGO'     => 'vista_id',
    'CATEGORIA'  => 'category',
    'VLR_VENDA'  => 'price',
    'CIDADE'     => 'city',
    'BAIRRO'     => 'area',
    'DORMITORIO' => 'bedrooms',
    'VAGAS'      => 'garages',
    'IMAGEM_G'   => 'picture',
    'URL_FOTO'   => 'picture_url',
    'DESCRICAO'  => 'description'
  },
  'order'      => {'VLR_VENDA' => 'DESC'},
  'limit'      => '0,10'
}

# Savon::Response
response = Vistasoft::Soap::Service.new(params).call

# Hash
parsed_response = Vistasoft::Soap::ResponseParser.new.parse(response)

# {
#   "0" =>  {
#     "vista_id"    => '3',
#     "category"    => "Apartamentos",
#     "price"       => nil,
#     "city"        => "Porto Alegre",
#     "area"        => "Bairro Remover",
#     "bedrooms"    => '5',
#     "garages"     => nil,
#     "picture"     => "i_9586_3_ceb68.jpg",
#     "picture_url" => "http://strg-rse.vistahosting.com.br/wx4imove/vista.imobi/fotos/",
#     "description" => nil,
#   },
#   "1" = {
#     "vista_id"    => '3',
#     "category"    => "Apartamentos",
#     "price"       => nil,
#     "city"        => "Porto Alegre",
#     "area"        => "Bairro Remover",
#     "bedrooms"    => '5',
#     "garages"     => nil,
#     "picture"     => "i_9586_3_ceb68.jpg",
#     "picture_url" => "http://strg-rse.vistahosting.com.br/wx4imove/vista.imobi/fotos/",
#     "description" => nil,
#   },
#   "total_registros" => "2"
# }

# Vistasoft::Soap::Collections::PropertyCollection
properties = Vistasoft::Soap::Collections::PropertyCollection.factory(parsed_response)

# Vistasoft::Soap::Models::Property
property = properties.first

property.category # => Apartamentos

```

### Method: busca_fotos
```Ruby
params = {
  'key'        => '{the client code}',
  'module'     => 'imoveis',
  'method'     => 'busca_fotos',
  'field'      => {
    'CODIGO'    => 'Codigo',
    'IMAGEM_P'  => 'Thumbnail',
    'IMAGEM_G'  => 'Foto',
    'URL_FOTO'  => 'Url',
    'DESCRICAO' => 'Descricao'
  },
 'filter' => {
    # 'CODIGO' => 875
  }
}

response = Vistasoft::Soap::Service.new(params).call

parsed = Vistasoft::Soap::ResponseParser.new.parse(response)

# {
#   "0"=> {
#     "Codigo"=>"3",
#     "Thumbnail"=>"i_9586_3_34f71_p.jpg",
#     "Foto"=>"i_9586_3_ceb68.jpg",
#     "Url"=>"http://strg-rse.vistahosting.com.br/wx4imove/vista.imobi/fotos/",
#     "Descricao"=>false
#   },
#   "1"=> {
#     "Codigo"=>"3",
#     "Thumbnail"=>"i_9586_3_c4e6f_p.jpg",
#     "Foto"=>"i_9586_3_6e8a6.jpg",
#     "Url"=>"http://strg-rse.vistahosting.com.br/wx4imove/vista.imobi/fotos/",
#     "Descricao"=>false
#   }
# }

```


### Method: lista_origens

```ruby
params = {
  'key'        => '{the client code}',
  'module'     => 'imoveis',
  'method'     => 'listar_origens'
}

response = Vistasoft::Soap::Service.new(params).call
Vistasoft::Soap::ResponseParser.new.parse(response) # not tested yet
```


### Method: lista_itens_filtro

```ruby
params = {
  'key'        => '{the client code}',
  'module'     => 'imoveis',
  'method'     => 'lista_itens_filtro',
  'field'      => 'BAIRRO',
  'filter' => {
    'CIDADE' => 'Porto Alegre'
  }
}

response = Vistasoft::Soap::Service.new(params).call
Vistasoft::Soap::ResponseParser.new.parse(response) # ['Centro', 'Higienopolis']
```

### Method: listar_documentos
Not working by the time of plugin development.