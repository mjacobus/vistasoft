# Vistasoft Soap API

[![Build Status](https://travis-ci.org/mjacobus/vistasoft.png?branch=master)](https://travis-ci.org/mjacobus/vistasoft)
[![Coverage Status](https://coveralls.io/repos/mjacobus/vistasoft/badge.png)](https://coveralls.io/r/mjacobus/vistasoft)
[![Code Climate](https://codeclimate.com/github/mjacobus/vistasoft.png)](https://codeclimate.com/github/mjacobus/vistasoft)
[![Dependency Status](https://gemnasium.com/mjacobus/vistasoft.png)](https://gemnasium.com/mjacobus/vistasoft)
[![Gem Version](https://badge.fury.io/rb/vistasoft.png)](http://badge.fury.io/rb/vistasoft)

The ruby API for accessing the vistasoft SOAP interface.
[VistSoft.com.br](http://vistasoft.com.br/).
See Vista's [Soap Specification](http://www.vistasoft.com.br/download/RQV_035%20-%20Integra%C3%A7%C3%A3o%20dos%20Im%C3%B3veis%20no%20Website%20ver2_rev01.pdf)


## Instalation

Add this line to your application's Gemfile:

```ruby
gem 'vistasoft'
```

And then execute:

    $ bundle

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

# Vistasoft::Soap::Collections::ModelCollection
collection = Vistasoft::Soap::Collection.factory(parsed_response, Vistasoft::Soap::Model)

# Vistasoft::Soap::Model
model = collection.first

model.category # => Apartamentos

```

### Method: busca_fotos
```ruby
params = {
  'key'        => '{the client code}',
  'module'     => 'imoveis',
  'method'     => 'busca_fotos',
  'field'      => {
    'CODIGO'    => 'codigo',
    'IMAGEM_P'  => 'thumb',
    'IMAGEM_G'  => 'foto',
    'URL_FOTO'  => 'url',
    'DESCRICAO' => 'descricao'
  },
 'filter' => {
    # 'CODIGO' => 875
  }
}

# Savon::Response
response = Vistasoft::Soap::Service.new(params).call

# Hash
parsed_response = Vistasoft::Soap::ResponseParser.new.parse(response)

# {
#   "0"=> {
#     "codigo"=>"3",
#     "thumb"=>"i_9586_3_34f71_p.jpg",
#     "foto"=>"i_9586_3_ceb68.jpg",
#     "url"=>"http://strg-rse.vistahosting.com.br/wx4imove/vista.imobi/fotos/",
#     "descricao"=> 'Pretty, uh?'
#   },
#   "1"=> {
#     "codigo"=>"3",
#     "thumb"=>"i_9586_3_c4e6f_p.jpg",
#     "foto"=>"i_9586_3_6e8a6.jpg",
#     "url"=>"http://strg-rse.vistahosting.com.br/wx4imove/vista.imobi/fotos/",
#     "descricao"=> 'Pretty, uh?'
#   }
# }

# Vistasoft::Soap::Collections::ModelCollection
collection = Vistasoft::Soap::Collection.factory(parsed_response, Vistasoft::Soap::Model)

# Vistasoft::Soap::Model
model = collection.first

model.descricao # => 'Pretty, uh?'

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

## Authors

- [Marcelo Jacobus](https://github.com/mjacobus)


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
**Do not forget to write tests**
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

