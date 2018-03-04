
require_relative '../util/mysql_service.rb'
require_relative './model/token'

class Service
  def login(params)
    token = Token.new
    contador = 1

    token.generate_token ({:data => contador })
  end

  def validar_token(params)
    token = Token.new
    token.validar_token(params['token'])
  end
end