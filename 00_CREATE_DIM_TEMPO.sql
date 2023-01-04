/****** Object:  Table [dbo].[Dim_Tempo]    Script Date: 04/03/2020 14:49:26 ******/
IF EXISTS ( SELECT 1 FROM sys.tables where name = 'Dim_Tempo' )
DROP TABLE [dbo].[Dim_Tempo]
GO

/****** Object:  Table [dbo].[Dim_Tempo]    Script Date: 04/03/2020 14:49:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Dim_Tempo](
	[Id_DimTempo] [bigint] NOT NULL IDENTITY(1,1),
	[Dta] [date] NULL,
	[AnoMesDia] [int] NULL,
	[Ano] [int] NULL,
	[Mes] [int] NULL,
	[Dia] [int] NULL,
	[AnoMes] [int] NULL,
	[NomAnoMes] [varchar](15) NULL,
	[NomAnoMesAbrev] [varchar](8) NULL,
	[NomMes] [varchar](9) NULL,
	[NomMesAbrev] [varchar](3) NULL,
	[DiaDaSemana] [int] NULL,
	[NomDiaDaSemana] [varchar](7) NULL,
	[DiaDoAno] [int] NULL,
	[Bimestre] [int] NULL,
	[Trimestre] [int] NULL,
	[Semestre] [int] NULL,
	[SemanaMes] [int] NULL,
	[SemanaAno] [int] NULL,
	[AnoBimestre] [int] NULL,
	[AnoTrimestre] [int] NULL,
	[AnoSemestre] [int] NULL,
	[DiaUtil] [int] NULL,
	[FinalSemana] [int] NULL,
	[DataPorExtenso] [varchar](50) NULL,
 CONSTRAINT [Pk_IdDimTempo] PRIMARY KEY CLUSTERED 
(
	[Id_DimTempo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

set nocount on
go
declare @dataini as date
declare @datafin as date 

declare @Id_DimTempo int,
		@Dia as int,
		@DiadaSemana as int,
		@DiadaSemana_nome  as varchar(7),
		@Ano as int,
		@Mes as int,
		@NomMes as varchar(9),
		@NomMes_abrev as varchar(3),
		@Bimestre as int,
		@Trimestre as int,
		@Semestre as int,
		@DiaUtil as int,
		@FinalSemana as int,
		@SemanaMes as int,
		@SemanaAno as int

set @dataini ='2000-01-01'
set @datafin ='2030-12-31'
set @Id_DimTempo = (SELECT MAX(Id_DimTempo) FROM dbo.Dim_Tempo)

while @dataini <= @datafin
begin

	set @Id_DimTempo = @Id_DimTempo + 1
	set @Dia = day(@dataini)
	set @DiadaSemana = datepart(weekday,@dataini)
	set @Ano = year(@dataini)
	set @Mes = month(@dataini)

	set @DiadaSemana_nome = case
	when @DiadaSemana =1 then 'domingo'
	when @DiadaSemana =2 then 'segunda'
	when @DiadaSemana =3 then 'terça'
	when @DiadaSemana =4 then 'quarta'
	when @DiadaSemana =5 then 'quinta'
	when @DiadaSemana =6 then 'sexta'
	when @DiadaSemana =7 then 'sábado' end

	set @NomMes = case 
	when @Mes = 1 then 'janeiro'
	when @Mes = 2 then 'fevereiro'
	when @Mes = 3 then 'março'
	when @Mes = 4 then 'abril'
	when @Mes = 5 then 'maio'
	when @Mes = 6 then 'junho'
	when @Mes = 7 then 'julho'
	when @Mes = 8 then 'agosto'
	when @Mes = 9 then 'setembro'
	when @Mes = 10 then 'outubro'
	when @Mes = 11 then 'novembro'
	when @Mes = 12 then 'dezembro' end

	set @NomMes_abrev = case 
	when @Mes = 1 then 'jan'
	when @Mes = 2 then 'fev'
	when @Mes = 3 then 'mar'
	when @Mes = 4 then 'abr'
	when @Mes = 5 then 'mai'
	when @Mes = 6 then 'jun'
	when @Mes = 7 then 'jul'
	when @Mes = 8 then 'ago'
	when @Mes = 9 then 'set'
	when @Mes = 10 then 'out'
	when @Mes = 11 then 'nov'
	when @Mes = 12 then 'dez' end

	set @Bimestre = case 
	when @Mes <= 2 then 1
	when @Mes <= 4 then 2
	when @Mes <= 6 then 3
	when @Mes <= 8 then 4
	when @Mes <= 10 then 5
	when @Mes <= 12 then 6 end

	set @Trimestre = case 
	when @Mes <= 3 then 1
	when @Mes <= 6 then 2
	when @Mes <= 9 then 3
	when @Mes <= 12 then 4 end

	set @Semestre = case 
	when @Mes <= 6 then 1
	when @Mes <= 12 then 2 end

	select @SemanaMes = case
	when @Dia < 8 then 1
	when @Dia < 15 then 2
	when @Dia < 22 then 3
	when @Dia < 29 then 4
	when @Dia < 32 then 5 end

	set @SemanaAno = datepart(wk,@dataini)

	set @DiaUtil = 1
	set @FinalSemana = 0

	if @DiadaSemana = 1 or @DiadaSemana = 7 
		set @FinalSemana = 1

	if @FinalSemana = 1
		set @DiaUtil = 0
	else if @Mes = 1 and @Dia = 1 --confraternização universal
		set @DiaUtil = 0
	else if @Mes = 4 and @Dia = 21 --tiradentes
		set @DiaUtil = 0
	else if @Mes = 5 and @Dia = 1 --trabalho
		set @DiaUtil = 0
	else if @Mes = 9 and @Dia = 7 --independência
		set @DiaUtil = 0
	else if @Mes = 10 and @Dia = 12 --nossa sra. aparecida
		set @DiaUtil = 0
	else if @Mes = 11 and @Dia = 2 --finados
		set @DiaUtil = 0
	else if @Mes = 11 and @Dia = 15 --proclamação da república
		set @DiaUtil = 0
	else if @Mes = 12 and @Dia = 25 --natal
		set @DiaUtil = 0

	/*
		feriados sem Dia fixo devem ser atualizados manualmente
		ex:
		carnaval 
		paixão de cristo
		corpus christi
	*/
	--select * from dbo.Dim_Tempo
	insert into dbo.Dim_Tempo
	select 
	--@Id_DimTempo as Id_DimTempo,
	@dataini as data,
	convert(char(8),@dataini,112) as AnoMesDia,--convert(char(10),@dataini,120) as AnoMesDia,
	@Ano as Ano,
	@Mes as Mes,
	@Dia as Dia,
	convert(char(6),@dataini,112) as AnoMes, --convert(char(7),@dataini,120) as AnoMes,
	cast(@Ano as char(4)) + '-' + @NomMes as AnoNomMes,
	cast(@Ano as char(4)) + '-' + @NomMes_abrev as AnoNomMes_abrev,
	@NomMes as NomMes,
	@NomMes_abrev as NomMes_abrev,
	@DiadaSemana as DiadaSemana,
	@DiadaSemana_nome as DiadaSemana_nome,
	datepart(dayofyear,@dataini) as DiaDoAno,
	@Bimestre as Bimestre,
	@Trimestre as Trimestre,
	@Semestre as Semestre,
	@SemanaMes as SemanaMes,
	@SemanaAno as SemanaAno,
	cast(@Ano as varchar) + '0' + cast(@Bimestre as varchar) as AnoBimestre,--cast(@Ano as varchar) + '-0' + cast(@Bimestre as varchar) as AnoBimestre,
	cast(@Ano as varchar) + '0' + cast(@Trimestre as varchar) as AnoTrimestre,--cast(@Ano as varchar) + '-0' + cast(@Trimestre as varchar) as AnoTrimestre,
	cast(@Ano as varchar) + '0' + cast(@Semestre as varchar) as AnoSemestre,--cast(@Ano as varchar) + '-0' + cast(@Semestre as varchar) as AnoSemestre,
	@DiaUtil as DiaUtil,
	@FinalSemana as FinalSemana,
	lower(@DiadaSemana_nome + ', Dia ' + cast(@Dia as varchar) + ' de ' + @NomMes + ' de ' + cast(@Ano as varchar)) as DataPorExtenso

	set @dataini = dateadd(day,1,@dataini)
end
GO

--if (select count(*) from dbo.Dim_Tempo where [Id_DimTempo] = -1) = 0
--begin
--	insert into dbo.Dim_Tempo([Id_DimTempo], [Dta], [AnoMesDia], [Ano], [Mes], [Dia], [AnoMes], [NomAnoMes], [NomAnoMesAbrev], [NomMes], [NomMesAbrev], [DiaDaSemana], [NomDiaDaSemana], [DiaDoAno], [Bimestre], [Trimestre], [Semestre], [SemanaMes], [SemanaAno], [AnoBimestre], [AnoTrimestre], [AnoSemestre], [DiaUtil], [FinalSemana], [DataPorExtenso])
--	values
--	(-1, null, '-1', 0, 0, 0, '-1', 'NÃO INFORMADO','NI', 'NI', 'NI', 0, 'NI', 0, 0, 0, 0, 0, 0, '-1', '-1', '-1', 0, 0, 'NÃO INFORMADO')
--end
--go
--if (select count(*) from dbo.Dim_Tempo where [Id_DimTempo] = 1) = 0
--begin
--	insert into dbo.Dim_Tempo([Id_DimTempo], [Dta], [AnoMesDia], [Ano], [Mes], [Dia], [AnoMes], [NomAnoMes], [NomAnoMesAbrev], [NomMes], [NomMesAbrev], [DiaDaSemana], [NomDiaDaSemana], [DiaDoAno], [Bimestre], [Trimestre], [Semestre], [SemanaMes], [SemanaAno], [AnoBimestre], [AnoTrimestre], [AnoSemestre], [DiaUtil], [FinalSemana], [DataPorExtenso])
--	values
--	(1	,	'1753-01-01'	,	'17530101'	,	1753	,	1	,	1	,	'175301'	,	'1753-janeiro'	,	'1753-jan'	,	'janeiro'	,	'jan'	,	2	,	'segunda'	,	1	,	1	,	1	,	1	,	1	,	1	,	'175301'	,	'175301'	,	'175301'	,	0	,	0	,	'segunda, dia 1 de janeiro de 1753')
--end
--go
--if (select count(*) from dbo.Dim_Tempo where [Id_DimTempo] = 2) = 0
--begin
--	insert into dbo.Dim_Tempo([Id_DimTempo], [Dta], [AnoMesDia], [Ano], [Mes], [Dia], [AnoMes], [NomAnoMes], [NomAnoMesAbrev], [NomMes], [NomMesAbrev], [DiaDaSemana], [NomDiaDaSemana], [DiaDoAno], [Bimestre], [Trimestre], [Semestre], [SemanaMes], [SemanaAno], [AnoBimestre], [AnoTrimestre], [AnoSemestre], [DiaUtil], [FinalSemana], [DataPorExtenso])
--	values
--	(2	,	'9999-12-31'	,	'99991231'	,	9999	,	12	,	31	,	'999912'	,	'9999-dezembro'	,	'9999-dez'	,	'dezembro'	,	'dez'	,	6	,	'sext'	,	365	,	6	,	4	,	2	,	5	,	53	,	'999906'	,	'999904'	,	'999902'	,	1	,	0	,	'sexta, dia 31 de dezembro de 9999')
--end

--GO