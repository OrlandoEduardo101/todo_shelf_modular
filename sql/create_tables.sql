CREATE TABLE IF NOT EXISTS users (
    id serial PRIMARY KEY,
    passwordHash VARCHAR (255) NOT NULL,
    name VARCHAR (255) NOT NULL,
    email VARCHAR (255) UNIQUE NOT NULL,
    created_on TIMESTAMP NOT NULL,
    last_login TIMESTAMP
);

CREATE TABLE IF NOT EXISTS todos (
    id serial PRIMARY KEY,
    name VARCHAR (255) NOT NULL,
    done BOOLEAN NOT NULL DEFAULT FALSE,
    updateAt TIMESTAMP NOT NULL,
    createAt TIMESTAMP NOT NULL,
    deadlineAt TIMESTAMP NOT NULL,
    userId serial,
    CONSTRAINT userId_fk FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE
);