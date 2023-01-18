# Projeto-Tickets-MVC

## Objectivo
Desenvolver uma aplicação onde seja possível gerenciar quantidade de tickets de refeições entregues para cada pessoa. 
Deve-se ter também uma opção para o usuário do sistema visualizar quantos tickets foram entregues no total e por 
pessoa em um determinado período.

## Justificativa
Atualmente uma empresa com mais de 1000 funcionários distribui tickets de refeições para seus colaboradores, 
porém, todo o controle é feito com anotações em um caderno.

## Técnologias

- Delphi 10.4 
- MySQL

## Execução

1. Após o download/clone do projeto ir até a raiz da aplicação e executar os comando do arquivo script.sql preferencialmente
  no MySQL server.
2. Em Raiz \executáveis\Win32\Release\config.txt. 
    1. Configurar os dados de acesso ao banco abaixo da sessão [Configuracoes] como 
      UserName=xxxxxxxx 
      DataBase=xxxxxxxx  
      Password=xxxxxxxx

    2. Caso o usuário cadastrado não possua senha remover a linha Password=xxxxxxxx do arquivo.

    3. Após salvar o arquivo se as informações estiverem corretas execute o Tickets_MVC.exe.