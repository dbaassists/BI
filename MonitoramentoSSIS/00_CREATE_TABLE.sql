USE [SGBLOG]
GO


/****** Object:  Table [dbo].[TB_Carga]    Script Date: 04/01/2023 10:32:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_Carga]') AND type in (N'U'))
DROP TABLE [dbo].[TB_Carga]
GO

/****** Object:  Table [dbo].[TB_Carga]    Script Date: 04/01/2023 10:32:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TB_Carga](
	[IdCarga] [bigint] IDENTITY(1,1) NOT NULL,
	[AbrGrupo] [varchar](3) NOT NULL,
	[CodRef] [bigint] NOT NULL,
	[IdPacote] [varchar](50) NOT NULL,
	[NomPacote] [varchar](70) NOT NULL,
	[DthInicio] [datetime] NULL,
	[TpoExecucao] [varchar](1) NOT NULL,
	[DthFim] [datetime] NULL,
 CONSTRAINT [PK_IdCarga] PRIMARY KEY NONCLUSTERED 
(
	[IdCarga] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Identificador da tabela de carga.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Carga', @level2type=N'COLUMN',@level2name=N'IdCarga'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Camada de carga dos dados (STG/ODS/DW).' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Carga', @level2type=N'COLUMN',@level2name=N'AbrGrupo'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Armazena a data e hora de execução como referência de controle.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Carga', @level2type=N'COLUMN',@level2name=N'CodRef'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Identificador hexadecimal do pacote em execução no SSIS.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Carga', @level2type=N'COLUMN',@level2name=N'IdPacote'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nome do pacote em execução no SSIS.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Carga', @level2type=N'COLUMN',@level2name=N'NomPacote'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Data de inicio da execução da tarefa.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Carga', @level2type=N'COLUMN',@level2name=N'DthInicio'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Situação da execução no contexto de tarefa (I-Iniciado/F-Finalizado sem erro/E-Finalizado com erro).' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Carga', @level2type=N'COLUMN',@level2name=N'TpoExecucao'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Data de fim da execução da tarefa.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Carga', @level2type=N'COLUMN',@level2name=N'DthFim'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tabela de controle macro das execuções dos pacotes.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Carga'
GO




/****** Object:  Table [dbo].[TB_CargaDetalhe]    Script Date: 04/01/2023 10:32:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_CargaDetalhe]') AND type in (N'U'))
DROP TABLE [dbo].[TB_CargaDetalhe]
GO

/****** Object:  Table [dbo].[TB_CargaDetalhe]    Script Date: 04/01/2023 10:32:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TB_CargaDetalhe](
	[IdCargaDetalhe] [bigint] IDENTITY(1,1) NOT NULL,
	[IdCarga] [bigint] NOT NULL,
	[IdTarefa] [varchar](50) NOT NULL,
	[NomTarefa] [varchar](70) NOT NULL,
	[Descricao] [varchar](200) NOT NULL,
	[QtdLinhasInseridas] [bigint] NOT NULL,
	[QtdLinhasAtualizadas] [bigint] NOT NULL,
	[TpoExecucao] [varchar](1) NOT NULL,
	[DthInicio] [datetime] NULL,
	[DthFim] [datetime] NULL,
 CONSTRAINT [PK_IdCargaDetalhe] PRIMARY KEY NONCLUSTERED 
(
	[IdCargaDetalhe] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TB_CargaDetalhe] ADD  DEFAULT ('') FOR [Descricao]
GO

ALTER TABLE [dbo].[TB_CargaDetalhe]  WITH CHECK ADD  CONSTRAINT [FK_TBCargaDetalhe_TBCarga_01] FOREIGN KEY([IdCarga])
REFERENCES [dbo].[TB_Carga] ([IdCarga])
GO

ALTER TABLE [dbo].[TB_CargaDetalhe] CHECK CONSTRAINT [FK_TBCargaDetalhe_TBCarga_01]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Identificador da tabela de carga detalhe.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_CargaDetalhe', @level2type=N'COLUMN',@level2name=N'IdCargaDetalhe'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Chave estrangeira da tabela de carga.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_CargaDetalhe', @level2type=N'COLUMN',@level2name=N'IdCarga'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Identificador da tarefa(task no SSIS) que esta em execução.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_CargaDetalhe', @level2type=N'COLUMN',@level2name=N'IdTarefa'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nome da tarefa(task no SSIS) que esta em execução.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_CargaDetalhe', @level2type=N'COLUMN',@level2name=N'NomTarefa'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Quantidade de linhas de entrada na tarefa em execução.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_CargaDetalhe', @level2type=N'COLUMN',@level2name=N'QtdLinhasInseridas'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Quantidade de linhas de saida na tarefa em execução.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_CargaDetalhe', @level2type=N'COLUMN',@level2name=N'QtdLinhasAtualizadas'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Situação da execução no contexto de tarefa (I-Iniciado/F-Finalizado sem erro/E-Finalizado com erro).' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_CargaDetalhe', @level2type=N'COLUMN',@level2name=N'TpoExecucao'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Data de inicio da execução da tarefa.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_CargaDetalhe', @level2type=N'COLUMN',@level2name=N'DthInicio'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Data de fim da execução da tarefa.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_CargaDetalhe', @level2type=N'COLUMN',@level2name=N'DthFim'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tabela de controle detalhado das tarefas em execução dentro do pacote.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_CargaDetalhe'
GO



/****** Object:  Table [dbo].[TB_CargaErro]    Script Date: 04/01/2023 10:32:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_CargaErro]') AND type in (N'U'))
DROP TABLE [dbo].[TB_CargaErro]
GO

/****** Object:  Table [dbo].[TB_CargaErro]    Script Date: 04/01/2023 10:32:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TB_CargaErro](
	[IdCargaErro] [bigint] IDENTITY(1,1) NOT NULL,
	[IdCargaDetalhe] [bigint] NULL,
	[NomTarefa] [varchar](70) NOT NULL,
	[NumErro] [int] NOT NULL,
	[DscErro] [varchar](8000) NULL,
	[LinhaRegistro] [varchar](max) NOT NULL,
	[DthErro] [datetime] NOT NULL,
 CONSTRAINT [Pk_IdCargaErro] PRIMARY KEY NONCLUSTERED 
(
	[IdCargaErro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[TB_CargaErro] ADD  DEFAULT ((2147483647)) FOR [NumErro]
GO

ALTER TABLE [dbo].[TB_CargaErro] ADD  DEFAULT ('') FOR [LinhaRegistro]
GO

ALTER TABLE [dbo].[TB_CargaErro]  WITH CHECK ADD  CONSTRAINT [FK_TBCargaErro_TBCargaDetalhe_01] FOREIGN KEY ([IdCargaDetalhe]) REFERENCES [dbo].[TB_CargaDetalhe] ([IdCargaDetalhe])
GO

ALTER TABLE [dbo].[TB_CargaErro] CHECK CONSTRAINT [FK_TBCargaErro_TBCargaDetalhe_01]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Identificador da tabela de carga de erro' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_CargaErro', @level2type=N'COLUMN',@level2name=N'IdCargaErro'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Chave estrangeira do identificador da tabela de carga detalhe' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_CargaErro', @level2type=N'COLUMN',@level2name=N'IdCargaDetalhe'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nome da tarefa(task no SSIS) que esta em execução.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_CargaErro', @level2type=N'COLUMN',@level2name=N'NomTarefa'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo de erro gerado no momento da falha.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_CargaErro', @level2type=N'COLUMN',@level2name=N'NumErro'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Descrição do erro gerado no momento da falha.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_CargaErro', @level2type=N'COLUMN',@level2name=N'DscErro'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Linha de registro expurgado no fluxo de dados (Data Flow).' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_CargaErro', @level2type=N'COLUMN',@level2name=N'LinhaRegistro'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Data e hora em que ocorreu o erro.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_CargaErro', @level2type=N'COLUMN',@level2name=N'DthErro'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tabela de controle de erros ocorridos nas tarefas existentes no pacotes.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_CargaErro'
GO


