import bcrypt

password = b'admin123'
# Gerar um hash com o prefixo $2a$10$
hashed_password = bcrypt.hashpw(password, bcrypt.gensalt(10)).decode('utf-8').replace('$2b$', '$2a$', 1)
print(hashed_password)
