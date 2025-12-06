-- =============================================
-- Migration V2: Dados iniciais do sistema
-- =============================================

-- Inserir Permissões
INSERT INTO permissoes (codigo_permissao, descricao) VALUES
('ADMIN', 'Permissão de administrador total'),
('BENEFICIARIA_LEITURA', 'Visualizar beneficiárias'),
('BENEFICIARIA_ESCRITA', 'Criar/Editar beneficiárias'),
('DOACAO_LEITURA', 'Visualizar doações'),
('DOACAO_ESCRITA', 'Criar/Editar doações');

-- Inserir Perfis de Acesso
INSERT INTO perfis_acesso (nome_perfil, descricao, nivel_acesso) VALUES
('ADMINISTRADOR', 'Acesso total ao sistema', 4),
('COORDENADOR', 'Coordena atividades da ONG', 3),
('OPERADOR', 'Operador básico', 1);

-- Associar permissões aos perfis
-- Administrador tem todas as permissões
INSERT INTO perfil_permissoes (id_perfil, id_permissao)
SELECT p.id, pm.id
FROM perfis_acesso p
CROSS JOIN permissoes pm
WHERE p.nome_perfil = 'ADMINISTRADOR';

-- Coordenador tem permissões de leitura e escrita
INSERT INTO perfil_permissoes (id_perfil, id_permissao)
SELECT p.id, pm.id
FROM perfis_acesso p
JOIN permissoes pm
  ON pm.codigo_permissao IN ('BENEFICIARIA_LEITURA', 'BENEFICIARIA_ESCRITA', 'DOACAO_LEITURA')
WHERE p.nome_perfil = 'COORDENADOR';

-- Operador tem apenas permissões de leitura
INSERT INTO perfil_permissoes (id_perfil, id_permissao)
SELECT p.id, pm.id
FROM perfis_acesso p
JOIN permissoes pm
  ON pm.codigo_permissao IN ('BENEFICIARIA_LEITURA', 'DOACAO_LEITURA')
WHERE p.nome_perfil = 'OPERADOR';

-- Inserir usuário administrador padrão
-- Senha: admin123 (hash BCrypt)
INSERT INTO usuarios (nome_completo, email, senha_hash, id_perfil, status) VALUES
(
  'Administrador do Sistema',
  'admin@ong.org',
  '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
  (SELECT id FROM perfis_acesso WHERE nome_perfil = 'ADMINISTRADOR'),
  'ATIVO'
);
