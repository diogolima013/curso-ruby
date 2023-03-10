namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando o BD...") {puts %x(rails db:drop)}
      show_spinner("Criando o BD...")  {puts %x(rails db:create)}
      show_spinner("Criando o BD...")  {puts %x(rails db:migrate)}
      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins)
    else 
      puts "Você não está em ambiente de desenvolvimento!"
  end
end

desc "Cadastra as moedas"
task add_coins: :environment do
  show_spinner("Cadastrando moedas...") do
    coins = [
              {  #hashes
                  description:"Bitcoin",
                  acronym:"BTC",
                  url_image:"https://static.vecteezy.com/system/resources/previews/008/505/801/original/bitcoin-logo-color-illustration-png.png",
                  mining_type: MiningType.find_by(acronym: 'PoW')
              },
              {   
                  description:"Ethereum",
                  acronym:"ETH",
                  url_image:"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAoHCBISFRgREhYSGBgaFRoYGBwYHBUaGBgYGBgZGRgZGBgcIS4lHB4rIRkYJjgmKy8xODU1GiU/QDs0Py40NTEBDAwMBgYGEAYGEDEdFh0xMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMf/AABEIAR0AsQMBIgACEQEDEQH/xAAcAAABBQEBAQAAAAAAAAAAAAADAAECBAcGBQj/xAA4EAABAgMFBgQEBwADAQEAAAABAAIDESEEEhMxUQUGIkFhcTKBkbEHFHKhI0JSYoLB0TOy8EQk/8QAFAEBAAAAAAAAAAAAAAAAAAAAAP/EABQRAQAAAAAAAAAAAAAAAAAAAAD/2gAMAwEAAhEDEQA/ANmQo+SWM1Rc4OEhmgArFnyPdDwXKbDdoUB1Tdme5R8ZqGYZNfNBGF4grarNYQZnIImM1BG0cvNARn8Xh5KOC5BO+GtvOMgASToBmhWG2sjw2xobrzHAkH7EHQgghc3vdtW60WVpqZF8uQ5N881yPw03kwo77DEdwRHuMMnJsSZm3s73HVBqCLZ8/JNguTsbcqeyCyqsfPyRcZqG5pcZjJAJXlVwXIuM1Ao2SrI7nBwkM1DBcgnZ8j3R0Bhu0KljNQFSQsZqSCsiQM0TBGp+yYtu1H3QHVa0Z+SWOeik1t6p7UQAVtmQ7BQwRqfsoGKRSlKIDRciqiKIhdwmVVPBGp+yBrPz8kHadtbAhuiO5Cg1ccgiu4cuevRcHvTtcxomG2Vxhl3dkT/Xqg8W1RnPe57jNznTPcrPIry17nNJBDyQRQgh0wQeRWghk6rP7Q3jf9bvcoN83K3gFvs7YhliN4IoHJwyMtHCvqvetGXn/qwHcneJ1gtDXk/hvkyKP28nd2mvaa3uG8PAqJEXgRzHL3QCVmDl5psEan7KLnXaD7oLCoouOeingjr9kA4PiVpALLvEPuo456IFaMx2QkdovVP2T4I1P2QV0lYwRqfskgMhR8lXvHUokEzNUAlYs+R7olwaBAjUNKU5ILKpuzPcprx1KssaJCgyQAh5hW0OIAAVTixgxpe50gBMnQBB529m0sGGGtPG+Yb0FJu/9qs8XobRtzrREdEdOVA0Hk0ZBVpIGZks+tPif9bvcrvXmq4C0Hjd9bvcoBLX/hTvDiwzY4juOG2bCc3Q5indpMuxCyOStbM2hEssVlohmTmODh1HNp6ETCD6ZVWPn5KhsnabLVBZaIZN17QZTq0/maeoMx5L1IQmK1QVleUbg0CqXjqUFiP4VWRYRmao90aBAKz5HujqtGoaU7Id46lBdSVK8dSkglhu0UobS0zNArKFHyQSxBqgxBeM21QlYs+R7oBYbtEYPAFSiqm7M9ygO5wIkDVcdvftA0szOhf7tb/fove2hbmwGGIcxRo1ccgs+jRXPcXuM3OJJOpKCuymaneCjE5IaCbmkmYWf2gcbvrd7laGzJZ9afE/63e5QDmmKinag7v4YbfwYvykQ8EUzZM0bEoAOgcBLuAtkhkNEjRfMbXEEEEggzBGYIyI6rdNzN4BbrO17iMVgDYo/cBR8tHCveaDqsVuqBhu0UFeQVmNLTM0CNiDVRjZKsgNEF6raqGG7REs+R7o6Cphu0SVtJBXx+n3SvXuHJBRIGaCeD1+ya9dpnz0VhVrRn5IHx+n3Swp1nnVBXm7zbUwYQY08bxIftbLid/Xmg5jebaGLEutM2QyQNHOyc7+vJeLidFN+SCgn4k+H1Sh80RAO/Kiz+0u43fW73K75+a4C0eN31u9yghdSlJOmcgV5e7uft02K0tiknDdwRQKzYfzS1aa+uq8BSag+mobGuAc0gggEEZEHIhSx+n3XAfCrePEYbDEPHDF6GTm6HOrf4+x6LuUBr97hyT4PX7KEHxK0grzuUzn5JY/T7prRmOyEgNj9PukgpILeG3QKERoAmKKd8aj1UIrgRIV7IA33alFhC8JmtUK4dD6FFgmQrSvOiBo7mMaXvkGgEk9Asw2pb3x4johnUyaP0tGQXSb47VBIszHCQkYkjzza3+/RcgQUDtKndCG0VRbw6IBvpkmvFO+uSa6dCgm0TWf2kcb/rd7laAw0Wf2k8b/AK3e5QBmkE0k7UEpKJUpqLkFnZ1viWeKyPDMnsdeb/YPQiY819E7D2jCtcBlohyuvbMjm1wo5p6gzC+bF3nww3kFmjfKxXShxSLpJo2LQDsHZd5INkiNAExQoN92pR4jgRIV7IFw6H0KAsOudUTDboEOCZCtO9ES+NR6oFht0CZPfGo9UkFREgZqWAdQkG3eIoLC8rbtvbZ4ZiHOUmjVxy/3yV75gaFZ9vLtL5mLJp4GTa3qebv/AGiDxYjy4lziSSZk6korclDDSvyogk/JBRL86JYaBQ+aIhDhVe17ShQvG6ugqfRAd+a4C0eN31u9yvatu3nvmIYuDU1d/gXKfNuDjerU980F9M5Ch2lrss9Ci5oIqTU11POSB1AEiooeXfkpXk11Bunw/wB4PnYDb5/FhyZE1Mhwv/kPuCuxXztujt11gtDI9Sw8ERo5sJqe4zHbqt/hWtj2h7KtcAWkZEETBQPaMx2QkaV+oolgHUIApI2AdQkgsIUfJCxXa+yhGtAY1z3nha0uPkg8HejaWEzDaeOIJdmcz55eq4qHkre0bSY0R0R3M0GjeQVNxlkgIguz807okhMkALzbXtuEyjON3Tw+v+IPSZmqts2vCh0JvO0bX1OQXMWzacSJmbo0bQeeqozQepb9txYlG8DdBn5uXlk804qlJAmrxYmZ7leySvFfme5QMjQrS5vUaFBSQelDtbXZ0PX/AFFK8hEhxXNyKD0lNVYdqafFT2Rw+eRQSctR+Fm8F9hsMQ8TAXQp82ZuZ/HPseiy0FWLDanwIjI0Myexwc09RyPTkg+lrPke6OvF2HtdlrgMtEKgeOIZlrhRzT2K9DFdr7ILSSq4rtfZMghJclvXtKbhZ2Ggq/qeTfLNdPvBtRtkgPjunQSFCamgnLksV2lvK55OGKkzL35kk1ICD3osVrBee4NGpIC8O37wMFIYvHU0b5DMrnY8d8Q3nuLj1/oclBqA9qtsSIeNxI0yaPJBCdRKByopwpIItUlFyZA5XivzPcr2wvFiZnuUEUikkECSSSKBJ2xC3IyTJILkK2fqHmP8Vtrw6oIK8hO1xFQZINJ+HO8Py0f5eI78OKQK5Mifld0ByPktkkvluDbCPF6ihX0J8Ot4jb7IHPvX4Zw3uIMnSFHA8zLPqCg6CSSvJIK7ntIkRMGhBAII6rhd5vh5AtE4lkIhRKksP/G49vyHtTouzc4DMgVl5osDNB867V2THsr8O0Mcx3KeThq1wo4KmKL6U2hs+FaGGFGY17TycPuDmD1Cy3ej4bvhkxLES9ueG7xt+lxo/sa90GeXk8kojHMcWPBa4GRDgQQdCDkkECkmvJyooJGqjdTtUkDTXivNT3K9krxX5nuUDJJJFAkkkkCSSSAmQBUkyAGZJyAHMoErOz7BFtDxBgMfEecmsEzLU8gOpXb7pfDG02oti2sugQjW7IYrxnQfkHU16LZ9h7Cs1ih4VmhtY3mc3OOrnGrj3QZ1up8KYbLsXaJD3ZiCwm4PreKu7CQ7rULO2HDaIbGhrWiTWtAAA0ACe0ZjsgNeCSAQSMxzE8p6ILeMOqSrJICWixsiNLHTIIkf/arlTtSNYYhhRpxGflcfFdORnz7FdovH3j2YLRCIEr7asPX9J6FAWxbVhxm3obmnUcx3HJXGi9U9qLKIcSJCfNpcx7TIymCCMwV1uxN6gRctAkZ+Jop/Icu4Qejt7dOy25v4rSHyo9sg8ecqjoVku8m5dqsZLwMWECeNgM2j97fy98lu0OI1wDmkEHIggg+arPzPcoPmsGaeS2LeHcCz2omJAlBiGvCBhuP7mDI9R91mO2thWmxuu2hhb+lwmWO+l2R7ZoPLNE15JyZBKS8V4qe5XtBeLEzPcoIpJJBAklf2Rsi0Wt4hWaG97ud0cLRq92TR3Wtbs/CyDAuxLcWxnyncH/C09Zibz3kOiDN92dzrXtAgw2XIfOK8EM/hzee3qts3W3BsdgAe1piRZViRJEj6G5MHavVe+xgaA1oAAEgAAABoAMlce8NBLiAAJkmgA1JQQcwN4hn1VLaG1oVnYYkd7IbBzcZT6AZk9AuQ3q+JEGEHQrIBFiZXz/xNPQgzee1Oqynam1I9qfiR3ve7lPwt6Mbk0dkGh7Q34tO0IzbJs1pZfN3EcOO7mXAVDWgTMzXstC2PsiHZoTYTS5xFXOcZue8+JzicyT/S5r4bbsfJwjHit/HiATnmxmYZ0JoT5aLuUAcAdUkZJBSmiQc1HCdp7KTGlpmaBBzW92x5/wD6YYqPGBp+r/Vxj1rbntIINQRIiRqFnW8WyjAicNWOqw6atPZBT2ftSLAM4bjLm0zLT5LudkbxQY4DXSY+WTsif2n+lnlwqQeEGtxBQqharNDisMOKxr2HNrgCD5FcdsveSLCF1xvsykfEPpd/RXWbOt0O0CcMzPNpkHDuEHAbwfDU8USwmfMwnn/o8+x9Vnlpsz4TjDiMcx7TItcCCPIr6Sh8PipP/wByXm7c2JZbay5HYCR4XCYez6XD2yQfPBXivzPcrSt5NwbVZZxIIMaFneaBiNH7mZnuPQLwd2dwbZtA4gbhQST+I8Zif5GTBf3oOqDlIbHOcGMa5ziZNa0EuJ0AFSVpO7HwqjRQ2LbyYTJgiG0jEcM+M5MHQTPZaTuvulYdnD8Fl6IRJ0R9Xu7HJo6CS6GI4OEhXmg83ZWzIFkYIVnYxjByaJTOrjm49SvUginmvK2vtODY2Yloe1jeXNzjo1oq4rL94/iPaIwMKyzgs/VTEeO/5B2r1QaJvLvlZbCC17r8XlDZIu/kcmjusf3i3ttduJbEfch8obCQz+XN57+i8IunUmZNSTmT1UZIE1aD8Md1vmH/ADkZv4bHcAIo945/S337Lld19hPt1obBbMNHFEd+hgIme5yHUr6CsUCFBY2DDAaxjQ1oE6AIJx80OaLEF6raqGE7T2QRmkpYTtPZJBbQo+ShjnRIPvUyQBQ7XYWWiE6G/mZg82uGRCt4HVMTdpnzQZharO+E50Nwk5pkf6I6Kmc/Nd5vPs7GZisbxsHL8zdO45Lhrk6oIszViHEcwhzSWkZEUI80G5KqWIg6mwb1mjLQJ/uaK/ybz7hdNAjMiND2ODmnIioWXjiVqw2qJBdehvI1GbT3HNBqcLIKTsj2XNbK3qhxJMigMdlMngd2PLzVLeTf6zWObGSixcrjSJNP73cu1Sg6ONFbDaXvc1rQJlziAAOpKz/eH4lMZeh2IB7pSxHDgH0N/N3NO64Pb28Vqtrpxn8M+FjZhjf48z1M15GSC1b7dFtDzFjPc9xzc4z8hoOgVRyV5PKaCKNAguiObDY0uc5wa1ozLiZABDurUvhfu3cHz8ZvERKC0/lac3y1OQ6d0HWbo7ut2fZhDoYjpOiu1fThH7RkPM817CMH3uHJPgdUCs+R7o6rk3aZpY50QWElXxzokgCiQM0e4NB6KEVoAmKdkBlWtGfkoYh1KLBExWteaAC5DejZOE4RmDgfmB+V5/orurg0CpWuEIjXQ31aZgjp0QZi/JBV7aVifAiGG6ZGbT+pvIqvdGgQRh80RCfTJNeOpQJ+a4C0eN31u9ytCaFn9pHG/wCt3uUA0zlGadqBlJqeSsbNsES0xWQIQm95kNBzLj0Aqg6HcPdk2+POIDgwyDEP6j+WGO8q9O4W1sYGgNAAAEgBQADIAKjsHZcOxwGWeHOTRNx5vcfE49SvauDQIAQfErSFEaAJinZAxDqUE7RmOyEjwRMVr3RLg0HogqJK3cGg9EkCxG6hQiOBEhVV0SBmgjhnQosI3RWleaOq1oz8kBsRuoVdzSSaHNQVtmQ7BB4m29k/MMlKT21YT/1PQrgX0JaaEGRGhGa1mLkVxW9uyf8A6YY+sD0Dv9Qcs+uSa6dFKHzREEGFZ/aTxv8Ard7ld6/NcBaPG763e5QCknCkmcgea2b4ebrGyQvmIjfxojQerGZhnc0J8hyXI/DXdn5h/wA3Fb+HDdwA5PeJV6tb79ls0HLzQAwzoVZvjUKaooLERwIkKoOGdCpQfErSAELhFad0TEbqEG0ZjshILeI3UJlVSQG+X6pBl2uasIUfJBHH6Ji29XLkgqxZ8j3QR+X6p8WVJZU9EdU3ZnuUBcS9SWaibNMEGRBoQRmFGHmFbQZpt7ZRsr5CrHVYe2bT1E/ReViLTdtWFkdmG7qWnm13IrM7TZ3Q3uY8Sc0yP+joga5Oqz60t4n/AFu9ytDZks+tPif9bvcoBXl627Gwn2+0NgMmG+J7uTGAi8e/IdV5UGE57msYC5ziGtAzJNAAt53H3dbYIN0yMRwvRHfu5NB/S3L1Qe3YdmsgQ2QYQDWMaGtHQa6nqjh12masKrHz8kE8fomwOqCryCvcu8WafH6KUbJVkBiL9cpJfL9U9nyPdHQV/l+qSsJIKmK7X2UmOLjI1CHdOhRIIkaoC4TdPdDiG7RtEa8NQgRqmmiCOK7X2RhDBE5KvdOhVphEh2QRcwATAqg4rtfZHiGhVa6dCgLD4p3qyXhb1bFEVuKxvG0VH6mjMdwvdgUnPojXhqEGPlxBkFwFoPG763e5Wv717IwnmKwcDzWWTXmp8iuF3O3ZNvtLr4OCx5MQ1rUyYDqefRB1fwu3VAA2hHbUiUBp5CoMTzyHSvNaVEF0TbRThhrQAJAASAEpADIBRjGYpqgFiu19kVjQ4TNSgXToVYhGQqgfCbp7oOK7X2Vi8NQql06FARji4yNQi4TdPdCgiRqj3hqEAYhu0bRQxXa+ylGqRLRDunQoJYrtfZJRunQpILqFHyRUKPkgrKxZ8j3VdWLPke6AypPzPcq6qT8z3KB4XiCuKpCzCtoAWjl5oCPaOXmgICRrM2JDMN4mHCR/0dVW2LsmHZIIgwxSrnE5uc6rnFX4XhCd+R7IKiLZ8/JCRbPn5ILKqx8/JWlVj5+SAavKirqAcbJVlZj+FVkB7Pke6OgWfI90dAkkkkH/2Q==",
                  mining_type: MiningType.all.sample
              },
              {
                  description:"DASH",
                  acronym:"DASH",
                  url_image:"https://cryptologos.cc/logos/dash-dash-logo.png",
                  mining_type: MiningType.all.sample
              }
            ]

      coins.each do |coin|
          sleep(1) 
          Coin.find_or_create_by!(coin)
    end
  end
end

desc "Cadastra os tipos de mineração"
task add_mining_types: :environment do
  show_spinner("Cadastrando a mineração...") do
    mining_types = [
      {description: "Proof of Work", acronym: "PoW"},
      {description: "Proof of Stake", acronym: "PoS"},
      {description: "Proof of Capacity", acronym: "PoC"}
    ]

      mining_types.each do |mining_type|
        MiningType.find_or_create_by!(mining_type)
    end
  end
end

  def show_spinner(msg_start, msg_end = "Concluído")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end
  