
require_relative '../util/mysql_service.rb'
require_relative './model/token'
require_relative './model/login'

class Service

  def initialize
    @token = Token.new
  end

  def login(p_array)
    login = Login.new
    params = p_array.get_value
    user_name = login.logar params['usuario'], params['senha']
    @token.generate_token ({:data => user_name })
  end

  def validar_token(p_commom)
    params = p_commom.get_auth
    @token.validar_token(params)
  end
end