require_relative 'pagamento'

include Pagamento

p = Visa.new # precisa do INCLUDE PAGAMENTO

p = Pagamento::Visa.new #aqui ja inclui o módulo... metodo mais prático!
puts p.pagando