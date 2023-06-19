# Trabalho Final Sistemas Distribuído - Flask

Site desenvolvido para ser lista de tarefas.
É possível adicionar título, descrição, hora de vencimento e se foi concluído ou não.

Feito por: Gabriel Rodrigues Ferraz da Silva e Matheus Henrique da Silva.


# Instrução para rodar o site

Para esta prática, iremos construir três imagens: Blog (Flask), Postgres e PgAdmin (gerenciador do banco).

1- docker pull postgres
2- docker pull dpage/pgadmin4

Após a execução desses dois comandos, as duas imagens postgres e pgadmin estão disponíveis.

3- Criar uma rede própria para os conteineres: docker network create --driver bridge postgres-network
4- Certifique de que a rede foi criada: docker network ls

Agora, iremos construir os conteineres, um para cada imagem criada.

5- docker run --name postgresql --network=postgres-network -e "POSTGRES_PASSWORD=admin123" -p 5432:5432 -d postgres
Criamos um conteiner chamado postgresql, o colocamos na rede criada, configuramos a porta local 5432 na máquina local, que será mapeada para a porta 5432 do conteiner, além de configurar a senha admin123 para o usuário padrão postgres.

O próximo comando precisa de um e-mail válido, apenas para criar o usuário para o gerenciador do banco.

6- docker run --name pgadmin4 --network=postgres-network -p 15432:80 -e "PGADMIN_DEFAULT_EMAIL=email-para-autenticacao" -e "PGADMIN_DEFAULT_PASSWORD=admin123" -d dpage/pgadmin4

Criamos um conteiner chamado pgadmin4, o colocamos na mesma rede criada do postgres, configuramos a porta local 15432 na máquina local, que será mapeada para a porta 80 do conteiner, já que o acesso é via http, além de configurar a senha admin123 para o usuário criado, cujo login é o email informado.

A partir desse momento, o banco pode ser acessado. Vamos fazer um pequeno teste de acesso ao banco (conteiner postgresql).

7- docker exec -it id-do-container-postgres bash

O acesso ao container foi concedido.

8- psql -U postgres

O acesso ao banco foi concedido, por meio do usuário postgres. Acesse o link https://dbschema.com/2020/04/14/postgresql-show-tables/ para alguns comandos de manipulação do postgres via terminal. Dê atenção aos comandos \l, \c database-name, \dt. Utilize esses comandos apenas para conferir o banco. Não iremos gerenciá-lo via terminal, mas pelo pgadmin.

9- Acesse localhost:15432 na máquina local, via browser.

10- Faça o login com o usuário e a senha criada para o pgadmin. Efetuada a autenticação, teremos então o painel principal, com as funcionalidades que permitirão o gerenciamento de servidores e bases de dados.

11- Não há servidor cadastrado. Registre um servidor e informe os seguintes parâmetros de conexão: a. Na aba General informar a identificação (Name) da conexão. b. Na aba Connection, informe o hostname: postgresql, Port: 5432, Username: postgres e Password: admin123. Marque para deixar a senha salva.
Nota: Em caso de erro no pgAdmin: https://github.com/orgs/community/discussions/17918

Assim o gerenciador já está conectado ao postgres, isto é, dois conteineres estão se comunicando. Agora vamos criar um banco para a aplicação.

12- No menu clique em Object -> Create -> Database. Dê um nome ao banco, por exemplo blog com o usuário postgres como o dono.

13- Na lateral, clique sobre o nome do banco criado, e em seguida, no menu, clique em Tools -> Query Tool. Isso abre o gerenciador de queries.

14- Acesse o arquivo schema_posgres.sql do projeto. Execute cada comando, DROP e CREATE juntos (copie, cole e execute), em seguida os comandos INSERT. Isso cria a tabela e registros. Você pode conferir fazendo o SELECT no banco. Se quiser, confira via conteiner, conforme o passo 8.

Agora, basta executar nossa aplicação Flask, que já está configurada para acessar o banco. Explore bem o arquivo app.py para entender a conexão com o banco. Lembre do arquivo .env que criamos com as variáveis de acesso.

15- Execute o arquivo app.py
16- Acesse o endereço localhost na porta 5000 (localhost:5000) para visualizar a aplicação.

Realize todas as operações CRUD e certifique o resultado no banco, via pgAdmin ou pelo acesso direto ao conteiner via terminal.

Veja como nossa aplicação está desacoplada em três instâncias: banco, gerenciador de banco, e aplicação web. Isso é uma aplicação distribuída. Quer brincar mais um pouco? Crie um conteiner da aplicação web na mesma rede dos outros dois conteineres. Assim você terá sua aplicação distribuída em três conteineres.