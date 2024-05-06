-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Tempo de geração: 28/04/2024 às 20:23
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `ProAcademicHub`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `Comentarios`
--

CREATE TABLE `Comentarios` (
  `comentario_id` int(11) NOT NULL,
  `conteudo` text NOT NULL,
  `data` timestamp NOT NULL DEFAULT current_timestamp(),
  `usuario_id` int(11) DEFAULT NULL,
  `tarefa_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `Configuracoes`
--

CREATE TABLE `Configuracoes` (
  `config_id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `preferencias` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `Membros`
--

CREATE TABLE `Membros` (
  `projeto_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `Projetos`
--

CREATE TABLE `Projetos` (
  `projeto_id` int(11) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `descricao` text DEFAULT NULL,
  `data_inicio` date DEFAULT NULL,
  `data_termino` date DEFAULT NULL,
  `criador_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `Relatorios`
--

CREATE TABLE `Relatorios` (
  `relatorio_id` int(11) NOT NULL,
  `tipo` enum('progresso','desempenho') NOT NULL,
  `projeto_id` int(11) DEFAULT NULL,
  `conteudo` text NOT NULL,
  `data` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `Tarefas`
--

CREATE TABLE `Tarefas` (
  `tarefa_id` int(11) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `descricao` text DEFAULT NULL,
  `status` enum('pendente','concluida') NOT NULL DEFAULT 'pendente',
  `data_inicio` date DEFAULT NULL,
  `data_termino` date DEFAULT NULL,
  `projeto_id` int(11) DEFAULT NULL,
  `responsavel_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `Usuarios`
--

CREATE TABLE `Usuarios` (
  `usuario_id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `permissoes` enum('admin','usuario') NOT NULL DEFAULT 'usuario'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `Usuarios`
--

INSERT INTO `Usuarios` (`usuario_id`, `nome`, `email`, `senha`, `permissoes`) VALUES
(1, 'eliseu', 'eliseu.ferreira@fatec.sp.gov.br', 'admin1234', 'admin');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `Comentarios`
--
ALTER TABLE `Comentarios`
  ADD PRIMARY KEY (`comentario_id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `tarefa_id` (`tarefa_id`);

--
-- Índices de tabela `Configuracoes`
--
ALTER TABLE `Configuracoes`
  ADD PRIMARY KEY (`config_id`),
  ADD UNIQUE KEY `usuario_id` (`usuario_id`);

--
-- Índices de tabela `Membros`
--
ALTER TABLE `Membros`
  ADD PRIMARY KEY (`projeto_id`,`usuario_id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Índices de tabela `Projetos`
--
ALTER TABLE `Projetos`
  ADD PRIMARY KEY (`projeto_id`),
  ADD KEY `criador_id` (`criador_id`);

--
-- Índices de tabela `Relatorios`
--
ALTER TABLE `Relatorios`
  ADD PRIMARY KEY (`relatorio_id`),
  ADD KEY `projeto_id` (`projeto_id`);

--
-- Índices de tabela `Tarefas`
--
ALTER TABLE `Tarefas`
  ADD PRIMARY KEY (`tarefa_id`),
  ADD KEY `projeto_id` (`projeto_id`),
  ADD KEY `responsavel_id` (`responsavel_id`);

--
-- Índices de tabela `Usuarios`
--
ALTER TABLE `Usuarios`
  ADD PRIMARY KEY (`usuario_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `Comentarios`
--
ALTER TABLE `Comentarios`
  MODIFY `comentario_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `Configuracoes`
--
ALTER TABLE `Configuracoes`
  MODIFY `config_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `Projetos`
--
ALTER TABLE `Projetos`
  MODIFY `projeto_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `Relatorios`
--
ALTER TABLE `Relatorios`
  MODIFY `relatorio_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `Tarefas`
--
ALTER TABLE `Tarefas`
  MODIFY `tarefa_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `Usuarios`
--
ALTER TABLE `Usuarios`
  MODIFY `usuario_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `Comentarios`
--
ALTER TABLE `Comentarios`
  ADD CONSTRAINT `Comentarios_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `Usuarios` (`usuario_id`),
  ADD CONSTRAINT `Comentarios_ibfk_2` FOREIGN KEY (`tarefa_id`) REFERENCES `Tarefas` (`tarefa_id`);

--
-- Restrições para tabelas `Configuracoes`
--
ALTER TABLE `Configuracoes`
  ADD CONSTRAINT `Configuracoes_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `Usuarios` (`usuario_id`);

--
-- Restrições para tabelas `Membros`
--
ALTER TABLE `Membros`
  ADD CONSTRAINT `Membros_ibfk_1` FOREIGN KEY (`projeto_id`) REFERENCES `Projetos` (`projeto_id`),
  ADD CONSTRAINT `Membros_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `Usuarios` (`usuario_id`);

--
-- Restrições para tabelas `Projetos`
--
ALTER TABLE `Projetos`
  ADD CONSTRAINT `Projetos_ibfk_1` FOREIGN KEY (`criador_id`) REFERENCES `Usuarios` (`usuario_id`);

--
-- Restrições para tabelas `Relatorios`
--
ALTER TABLE `Relatorios`
  ADD CONSTRAINT `Relatorios_ibfk_1` FOREIGN KEY (`projeto_id`) REFERENCES `Projetos` (`projeto_id`);

--
-- Restrições para tabelas `Tarefas`
--
ALTER TABLE `Tarefas`
  ADD CONSTRAINT `Tarefas_ibfk_1` FOREIGN KEY (`projeto_id`) REFERENCES `Projetos` (`projeto_id`),
  ADD CONSTRAINT `Tarefas_ibfk_2` FOREIGN KEY (`responsavel_id`) REFERENCES `Usuarios` (`usuario_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
