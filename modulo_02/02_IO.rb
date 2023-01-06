puts "Digite seu nome:"
nome = gets.chomp
puts "O seu nome é: " + nome

puts "=========="

puts "Com o inspect" + nome.inspect

puts "==========="

#to_f = transforma qualquer number em casa decimal 

puts "Digite seu sálario:"
sal= gets.chomp.to_f

#to_s = transforma o number em string

puts "Seu sálario atualizado é :" + (sal * 1.10).to_s