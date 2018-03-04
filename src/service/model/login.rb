
require_relative '../../../src/util/mysql_service'

class Login

  def initialize
    @mysql = MysqlService.new
  end

  def logar(usuario, senha)
    dados = []
    result = @mysql.select "SELECT * FROM metrics.usuarios WHERE user = #{usuario} AND senha = md5(#{senha})"
    result.each do |r|
      dados.push [r['nome']]
    end
    dados
  end
end