
class Validar
    
    def id (pId)
        verificar pId
    end

    def auth (pAuth)
        verificar pAuth
    end

    def jsonrpc (pJsonrpc)
        verificar pJsonrpc
    end

    def method (pMethod)
        verificar pMethod
    end

    def params (pParams)
        verificar pParams
    end

    private
        def mensagem
            raise 'Padrão inválido, siga o padrão jsonrpc 2.0'
        end

        def verificar (dado)
            if dado.nil?
                mensagem
            end
        end

end