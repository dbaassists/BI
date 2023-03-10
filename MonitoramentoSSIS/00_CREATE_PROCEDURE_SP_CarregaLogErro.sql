USE [SGBLOG]
GO
/****** Object:  StoredProcedure [SCH_LOG].[STP_SIU_CarregaLogErro]    Script Date: 04/01/2023 10:29:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--DBCC CHECKIDENT ('SCH_LOG.TB_CargaErro', RESEED, 0)

CREATE procedure [dbo].[SP_CarregaLogErro]
	@IdPacote varchar(50)
	,@IdTarefa varchar(50)
	,@NomeTarefa varchar(60)
	,@NumeroErro int = 0
	,@DescricaoErro varchar(8000) = ''
	,@LinhaRegistro varchar(max) = ''
as
begin
	SET NOCOUNT ON;
	
	declare @IdCarga bigint = 0
	declare @IdCargaDetalhe bigint = 0
	declare @DataHoraErro datetime = getdate()
	
	declare @IdPacote_c varchar(50)
	declare @IdTarefa_c varchar(50)
	
	-- FORMATA VALORES DAS VARIAVEIS INFORMADAS
	set @IdPacote_c = REPLACE(REPLACE(@IdPacote, '{', ''), '}', '')
	set @IdTarefa_c = REPLACE(REPLACE(@IdTarefa, '{', ''), '}', '')
	
	
	select @IdCarga = MAX(IdCarga)
	from SCH_LOG.TB_Carga cg
	where cg.IdPacote = @IdPacote_c
	
	select 
		@IdCargaDetalhe = MAX(CD1.IdCargaDetalhe)
	from [SCH_LOG].[TB_CargaDetalhe] CD1
	where CD1.IdTarefa = @IdTarefa_c
	and CD1.IdCarga = @IdCarga
		
	--Insere o erro na tabela de log de erros
	INSERT INTO [SGBLOG].[SCH_LOG].[TB_CargaErro]
           ([IdCargaDetalhe]
           ,[NomTarefa]
           ,[NumErro]
           ,[DscErro]
           ,[LinhaRegistro]
           ,[DthErro])
     VALUES
           (@IdCargaDetalhe
           ,@NomeTarefa
           ,@NumeroErro
           ,@DescricaoErro
           ,@LinhaRegistro
           ,@DataHoraErro)
          
    --Atualiza a situação da etapa que ocorreu o erro para "E" na tabela de carga
    update a set 
		a.TpoExecucao = 'E'
		,a.DthFim = @DataHoraErro
	from SCH_LOG.TB_CargaDetalhe a
	where a.IdCargaDetalhe = @IdCargaDetalhe     
               
    --Atualiza a situação da etapa que ocorreu o erro para "E" na tabela de carga detalhe
    update a set 
		a.TpoExecucao = 'E'
		,a.DthFim = @DataHoraErro
	from SCH_LOG.TB_Carga a
	where a.IdCarga = @IdCarga

end

