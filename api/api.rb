require 'sinatra'
require 'json'
require 'sinatra/cross_origin'
require_relative '../src/service/service.rb'
require_relative './validar.rb'
require_relative '../src/util/p_array'
require_relative '../src/util/p_common'

set :bind, '0.0.0.0'

post '/' do
  content_type :json
  response.headers["Access-Control-Allow-Origin"] = "*"

  servico = Service.new

  params = JSON.parse(request.body.read.to_s)

  if params['params'].class == Hash

    p_array = PArray.new
    p_array.set_dados params
    result = servico.login p_array

    {:id => 'auth', :jsonrpc => '2.0', :result => result}.to_json

  else
    p_common = PCommon.new
    p_common.set_dados params
    result = method.call p_common

    {:id => 'auth', :jsonrpc => '2.0', :result => result}.to_json

  end

end