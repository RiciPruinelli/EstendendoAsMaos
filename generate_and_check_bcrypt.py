import bcrypt

password = b'admin123'
# Gerar um hash com o prefixo $2a$
hashed_password = bcrypt.hashpw(password, bcrypt.gensalt(10)).decode('utf-8').replace('$2b$', '$2a$', 1)
print(f"Novo Hash: {hashed_password}")

# Testar se a senha corresponde ao hash gerado
if bcrypt.checkpw(password, hashed_password.encode('utf-8')):
    print("A senha corresponde ao hash gerado.")
else:
    print("A senha NÃO corresponde ao hash gerado.")
