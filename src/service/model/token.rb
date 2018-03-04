
require 'jwt'

class Token

  def initialize
    # @chave = ENV['AUTH_SERVICE_METRICS_KEY']
    @chave = 'teste'
  end

  def generate_token(payload)
    JWT.encode payload, @chave, 'HS256'
  end

  def validar_token(token)
    begin
      dados = JWT.decode token, @chave, true, { :algorithm => 'HS256' }
      dados[0]['data'] = dados[0]['data'].to_i + 2
      generate_token({:data => dados[0]['data']})
    rescue Exception
      '-503'
    end
  end
end