import bcrypt

password = b'admin123'
hashed_password = bcrypt.hashpw(password, bcrypt.gensalt(10))
print(hashed_password.decode('utf-8'))
