
require_relative '../../../src/util/mysql_service'
require 'digest'

class Login

  def initialize
    @mysql = MysqlService.new
  end

  def logar(usuario, senha)
    dados = {}
    result = @mysql.select "SELECT * FROM metrics.users_metrics WHERE user = '#{usuario}' AND password = md5('#{senha}')"
    result.each do |r|
      token = gerar_token_interno r['id']
      dados = { :usuario => r['nome'], :token =>  token }
    end

    if result.empty?
      raise 'Usuario ou Senha Inválida!', -504
    end
    dados
  end

  def validar_token_interno(token)
    result = @mysql.select "SELECT * FROM metrics.auth WHERE token = '#{token}'"
    !result.empty?
  end

  private
    def gerar_token_interno(id_usuario)
      md5 = Digest::MD5.new
      md5 << "#{ENV['MENSAGEM_MD5']}#{id_usuario}#{Time.now}"
      token = md5.hexdigest
      @mysql.instrucoes_params("UPDATE metrics.auth SET token = '#{token}' WHERE id = #{id_usuario}")
      token
    end
end