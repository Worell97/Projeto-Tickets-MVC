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


<details>
  <summary>
    <h2>Instruções para execução</h2>
  </summary>
  <ul>
    <li>Após o download/clone do projeto ir até a raiz da aplicação e executar os comando do arquivo script.sql preferencialmente
      no MySQL server.</li>
    <li>Em Raiz \executáveis\Win32\Release\config.txt.
      <ul>
        <li>Configurar os dados de acesso ao banco abaixo da sessão [Configuracoes] como 
          UserName=xxxxxxxx 
          DataBase=xxxxxxxx  
          Password=xxxxxxxx</li>
        <li>Caso o usuário cadastrado não possua senha remover a linha Password=xxxxxxxx do arquivo.</li>
        <li>Após salvar o arquivo se as informações estiverem corretas execute o Tickets_MVC.exe.</li>
        <li>Por padrão está com o usuário 'tickets' sem senha.</li>
      </ul>
    </li>
  </ul>
</details>
<details>
  <summary>
    <h2>Informações sobre o uso</h2>    
  </summary>  
  <h3>Funcionarios</h3>
  <div><h4>Cadastro</h4></div>
  <div>Em Principal -> Cadastros -> Funcionarios.</div>
  <ul>
    <li>Clicar no botão "Novo".</li>
    <li>Preencher os dados necessários.</li>
    <li>Salvar.</li>
  </ul>
  <h4>Edição</h4>
  <div>Em Principal -> Cadastros -> Funcionarios.</div>
  <ul>
    <li>Selecionar no grid de pesquisa o funcionario a ser editado.</li>
    <li>Clicar no botão "Editar".</li>
    <li>Preencher as alterações necessárias.</li>
    <li>Salvar.</li>
  </ul>  
  <h4>Inativação</h4>
  <div>Em Principal -> Funcionarios -> Funcionarios</div>
  <ul>
    <li>Selecionar no grid de pesquisa o funcionario a ser inativado.</li>
    <li>Clicar no botão "Inativar".</li>
    <li>Comfirmar a operação.</li>
    <li>Ao fim da operação o funcionario não aparecerá no grid a não ser que o filtro "inativos" esteja selecionado.</li>
  </ul>
  <h3>Tickets</h3>
  <div><h4>Cadastro</h4></div>
  <div>Em Principal -> Lançamentos -> Tickets</div>
  <ul>
    <li>Clicar no botão "Novo".</li>
    <li>Selcionar o funcionario que irá receber os tickets.</li>
    <li>Preencher a quantidade entregue.</li>
    <li>Salvar.</li>
  </ul>
  <h4>Edição</h4>
  <div>Em Principal -> Lançamentos -> Tickets</div>
  <ul>
    <li>Selecionar no grid de pesquisa o ticket a ser editado.</li>
    <li>Clicar no botão "Editar".</li>
    <li>Preencher as alterações necessárias.</li>
    <li>Salvar.</li>
  </ul>
  <h4>Inativação</h4>
  <div>Em Principal -> Lançamentos -> Tickets</div>
  <ul>
    <li>Selecionar no grid de pesquisa o ticket a ser inativado.</li>
    <li>Clicar no botão "Inativar".</li>
    <li>Comfirmar a operação.</li>
    <li>Ao fim da operação o ticket não aparecerá no grid a não ser que o filtro "inativos" esteja selecionado.</li>
  </ul>
</details>
