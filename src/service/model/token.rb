
require 'jwt'
require_relative '../../../src/service/model/login'

class Token

  def initialize
    @chave = ENV['AUTH_SERVICE_METRICS_KEY']
  end

  def generate_token(payload)
    JWT.encode payload, @chave, 'HS256'
  end

  def validar_token(token)
    begin
      decode_token = JWT.decode token, @chave, true, { :algorithm => 'HS256' }
      valid = validar_token_banco decode_token[0]['data']['token']
      { :validate => valid }
    rescue Exception
      { :error => '-503', :message => 'Token inválido' }
    end
  end

  private
    def validar_token_banco (token_interno)
      login = Login.new
      login.validar_token_interno token_interno
    end
end