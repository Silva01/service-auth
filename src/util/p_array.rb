
class PArray
  def set_dados(dados)
    if dados['params'].class == Hash
      @auth = dados['auth']
      @params = dados['params']
    else
      raise 'Dados inválidos, valor não é array', -502
    end
  end

  def get_auth
    @auth
  end

  def get_value
    @params
  end
end