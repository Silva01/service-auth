require 'sinatra'
require 'json'
require 'sinatra/cross_origin'
require_relative '../src/service/service.rb'
require_relative './validar.rb'
require_relative '../src/util/p_array'
require_relative '../src/util/p_common'

set :bind, '0.0.0.0'

post '/service' do
  content_type :json
  response.headers["Access-Control-Allow-Origin"] = "*"

  validar = Validar.new

  servico = Service.new

  method_params = JSON.parse(request.body.read.to_s)

  validar.id method_params['id']

  validar.jsonrpc method_params['jsonrpc']

  validar.auth method_params['auth']

  validar.method method_params['method']

  validar.params method_params['params']

  method = servico.method(method_params['method'])

  if method_params['params'].class == Hash

    p_array = PArray.new
    p_array.set_dados method_params
    result = method.call p_array

    {:id => 'auth', :jsonrpc => '2.0', :result => result}.to_json

  else
    p_common = PCommon.new
    p_common.set_dados method_params
    result = method.call p_common

    {:id => 'auth', :jsonrpc => '2.0', :result => result}.to_json

  end

end