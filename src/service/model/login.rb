
require_relative '../../../src/util/mysql_service'

class Login

  def initialize
    @mysql = MysqlService.new
  end

  def logar(usuario, senha)
    dados = []
    result = @mysql.select "SELECT * FROM metrics.users_metrics WHERE user = '#{usuario}' AND password = md5('#{senha}')"
    result.each do |r|
      dados.push [r['nome']]
    end
    dados
  end
end