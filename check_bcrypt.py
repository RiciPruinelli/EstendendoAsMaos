import bcrypt

# Hash da senha 'admin123' do arquivo V2__insert_initial_data.sql
hashed_password = b'$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy'
# Senha que está sendo usada no teste
password = b'admin123'

if bcrypt.checkpw(password, hashed_password):
    print("A senha corresponde ao hash.")
else:
    print("A senha NÃO corresponde ao hash.")
