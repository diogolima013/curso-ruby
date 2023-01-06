class Pessoa
    attr_accessor :nome, :email
  end
  
  class PessoaFisica < Pessoa
    attr_accessor :cpf
  
    def falar(texto)
      texto
    end
  end
  
  class PessoaJuridica < Pessoa
    attr_accessor :cnpj
  
    def pagar_fornecedor
      "Pagando fornecedor..."
    end
  end
  
  # ---------------------
  p1 = Pessoa.new 
  # setter
  p1.nome = "Jackson"
  p1.email = "jackson@jack.com"
  
  # getter
  puts p1.nome
  puts p1.email
  puts "------------------------"
  # ---------------------
  
  p2 = PessoaFisica.new
  # setter
  p2.nome = "Joao"
  p2.email = "joao@joao.com"
  p2.cpf = "9191919191"
  
  # getter
  puts p2.nome
  puts p2.email
  puts p2.cpf
  
  puts p2.falar("Hello!")
  puts "------------------------"
  
  # ---------------------
  
  p3 = PessoaJuridica.new
  # setter
  p3.nome = "Vídeos de Ti"
  p3.email = "vit@vti.com"
  p3.cnpj = "9191919191-0001"
  
  # getter
  puts p3.nome
  puts p3.email
  puts p3.cnpj
  
  puts p3.pagar_fornecedor
  puts "------------------------"