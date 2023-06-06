/* cria a tabela */
DROP TABLE IF EXISTS posts;

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    title CHAR(50) NOT NULL,
    content CHAR(100) NOT NULL,
    hora timestamp,
    concluido CHAR(3) NOT NULL
);

/* insere dados iniciais */
INSERT INTO posts(title, content, hora, concluido) VALUES 
('First Post', 'Content for the first post', '2023-06-05 05:30:00', 'Nao');

INSERT INTO posts (title, content, hora, concluido) VALUES 
('Second Post', 'Content for the second post', '2023-12-15 10:30:00', 'Sim');