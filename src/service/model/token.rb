
require 'jwt'

class Token

  def initialize
    @chave = ENV['AUTH_SERVICE_METRICS_KEY']
  end

  def generate_token(payload)
    JWT.encode payload, @chave, 'HS256'
  end

  def validar_token(token)
    begin
      JWT.decode token, @chave, true, { :algorithm => 'HS256' }
      {:validate => true}
    rescue Exception
      {:error => '-503', :message => 'Token inválido'}
    end
  end
end