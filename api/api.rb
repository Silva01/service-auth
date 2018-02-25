require 'sinatra'
require 'json'
require_relative '../src/service/service.rb'
require_relative './validar.rb'

post '/service' do

    validar = Validar.new

    servico = Service.new

    method_params = JSON.parse(request.body.read.to_s)

    validar.id method_params['id']

    validar.jsonrpc method_params['jsonrpc']

    validar.auth method_params['auth']

    validar.method method_params['method']

    validar.params method_params['params']

    method = servico.method(method_params['method'])
    
    method.call method_params['params']
end