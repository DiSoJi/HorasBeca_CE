USE [BecasCE]
GO
ALTER TABLE [dbo].[solicitud_tutoria] DROP CONSTRAINT [SolTuto_x_SolGeneral]
GO
ALTER TABLE [dbo].[solicitud_tutoria] DROP CONSTRAINT [SolTuto_x_Profesor]
GO
ALTER TABLE [dbo].[solicitud_tutoria] DROP CONSTRAINT [SolTuto_x_Estudiante]
GO
ALTER TABLE [dbo].[solicitud_tutoria] DROP CONSTRAINT [SolTuto_x_Curso]
GO
ALTER TABLE [dbo].[solicitud_general] DROP CONSTRAINT [SolGen_x_Estado]
GO
ALTER TABLE [dbo].[solicitud_estudiante] DROP CONSTRAINT [SolEst_x_SolGeneral]
GO
ALTER TABLE [dbo].[solicitud_estudiante] DROP CONSTRAINT [SolEst_x_Estudiante]
GO
ALTER TABLE [dbo].[solicitud_especial] DROP CONSTRAINT [SolEsp_x_SolGeneral]
GO
ALTER TABLE [dbo].[solicitud_especial] DROP CONSTRAINT [SolEsp_x_Estudiante]
GO
ALTER TABLE [dbo].[solicitud_asistente] DROP CONSTRAINT [SolAsis_x_SolGeneral]
GO
ALTER TABLE [dbo].[solicitud_asistente] DROP CONSTRAINT [SolAsis_x_Profesor]
GO
ALTER TABLE [dbo].[solicitud_asistente] DROP CONSTRAINT [SolAsis_x_Estudiante]
GO
ALTER TABLE [dbo].[solicitud_asistente] DROP CONSTRAINT [SolAsis_x_Curso]
GO
ALTER TABLE [dbo].[roles_por_usuario] DROP CONSTRAINT [rol_rol_p_usario_fkey]
GO
ALTER TABLE [dbo].[roles_por_usuario] DROP CONSTRAINT [email_rol_p_usario_fkey]
GO
ALTER TABLE [dbo].[rol] DROP CONSTRAINT [rol_sistema_fkey]
GO
/****** Object:  Table [dbo].[usuario]    Script Date: 15/6/2018 21:38:51 ******/
DROP TABLE [dbo].[usuario]
GO
/****** Object:  Table [dbo].[solicitud_tutoria]    Script Date: 15/6/2018 21:38:51 ******/
DROP TABLE [dbo].[solicitud_tutoria]
GO
/****** Object:  Table [dbo].[solicitud_general]    Script Date: 15/6/2018 21:38:51 ******/
DROP TABLE [dbo].[solicitud_general]
GO
/****** Object:  Table [dbo].[solicitud_estudiante]    Script Date: 15/6/2018 21:38:51 ******/
DROP TABLE [dbo].[solicitud_estudiante]
GO
/****** Object:  Table [dbo].[solicitud_especial]    Script Date: 15/6/2018 21:38:51 ******/
DROP TABLE [dbo].[solicitud_especial]
GO
/****** Object:  Table [dbo].[solicitud_asistente]    Script Date: 15/6/2018 21:38:51 ******/
DROP TABLE [dbo].[solicitud_asistente]
GO
/****** Object:  Table [dbo].[sistema_informacion]    Script Date: 15/6/2018 21:38:51 ******/
DROP TABLE [dbo].[sistema_informacion]
GO
/****** Object:  Table [dbo].[roles_por_usuario]    Script Date: 15/6/2018 21:38:51 ******/
DROP TABLE [dbo].[roles_por_usuario]
GO
/****** Object:  Table [dbo].[rol]    Script Date: 15/6/2018 21:38:51 ******/
DROP TABLE [dbo].[rol]
GO
/****** Object:  Table [dbo].[estudiantes]    Script Date: 15/6/2018 21:38:51 ******/
DROP TABLE [dbo].[estudiantes]
GO
/****** Object:  Table [dbo].[estados_solicitud]    Script Date: 15/6/2018 21:38:51 ******/
DROP TABLE [dbo].[estados_solicitud]
GO
/****** Object:  Table [dbo].[curso]    Script Date: 15/6/2018 21:38:51 ******/
DROP TABLE [dbo].[curso]
GO
/****** Object:  Table [dbo].[curso]    Script Date: 15/6/2018 21:38:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[curso](
	[codigo_curso] [varchar](20) NOT NULL,
	[nombre_curso] [varchar](20) NOT NULL,
	[activo] [bit] NOT NULL,
 CONSTRAINT [codigo_curso] PRIMARY KEY CLUSTERED 
(
	[codigo_curso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[estados_solicitud]    Script Date: 15/6/2018 21:38:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[estados_solicitud](
	[id_estado] [int] NOT NULL,
	[nombre] [varchar](max) NULL,
	[activo] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_estado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[estudiantes]    Script Date: 15/6/2018 21:38:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[estudiantes](
	[carne] [varchar](11) NOT NULL,
	[correo_electronico] [varchar](100) NOT NULL,
	[primer_nombre] [varchar](20) NOT NULL,
	[segundo_nombre] [varchar](20) NULL,
	[primer_apellido] [varchar](20) NOT NULL,
	[segundo_apellido] [varchar](20) NOT NULL,
 CONSTRAINT [estudiantes_pkey] PRIMARY KEY CLUSTERED 
(
	[carne] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[correo_electronico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[rol]    Script Date: 15/6/2018 21:38:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rol](
	[id_rol] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[sistema] [int] NOT NULL,
 CONSTRAINT [rol_pkey] PRIMARY KEY CLUSTERED 
(
	[id_rol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[roles_por_usuario]    Script Date: 15/6/2018 21:38:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[roles_por_usuario](
	[usuario] [int] NOT NULL,
	[rol] [int] NOT NULL,
 CONSTRAINT [roles_por_usuario_pkey] PRIMARY KEY CLUSTERED 
(
	[usuario] ASC,
	[rol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[sistema_informacion]    Script Date: 15/6/2018 21:38:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sistema_informacion](
	[id_sistema] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](15) NOT NULL,
 CONSTRAINT [sistema_informacion_pkey] PRIMARY KEY CLUSTERED 
(
	[id_sistema] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[solicitud_asistente]    Script Date: 15/6/2018 21:38:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[solicitud_asistente](
	[id_sol] [int] IDENTITY(1,1) NOT NULL,
	[id_estudiante] [varchar](11) NOT NULL,
	[id_sol_general] [int] NOT NULL,
	[id_curso] [varchar](20) NOT NULL,
	[horas] [int] NULL,
	[id_prof_asistir] [int] NOT NULL,
	[nota_curso_asist] [int] NOT NULL,
	[nota_curso_asist_img] [varbinary](max) NOT NULL,
	[activo] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_sol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[solicitud_especial]    Script Date: 15/6/2018 21:38:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[solicitud_especial](
	[id_sol] [int] IDENTITY(1,1) NOT NULL,
	[id_estudiante] [varchar](11) NOT NULL,
	[id_sol_general] [int] NOT NULL,
	[horas_solicitadas] [int] NULL,
	[horas_asignadas] [int] NULL,
	[activo] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_sol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[solicitud_estudiante]    Script Date: 15/6/2018 21:38:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[solicitud_estudiante](
	[id_sol] [int] IDENTITY(1,1) NOT NULL,
	[id_estudiante] [varchar](11) NOT NULL,
	[id_sol_general] [int] NOT NULL,
	[horas] [int] NULL,
	[activo] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_sol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[solicitud_general]    Script Date: 15/6/2018 21:38:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[solicitud_general](
	[id_sol_gen] [int] IDENTITY(1,1) NOT NULL,
	[cedula_est] [int] NULL,
	[prom_pond_gen] [float] NOT NULL,
	[prom_pond_sem] [float] NOT NULL,
	[creds_gen] [int] NOT NULL,
	[creds_sem] [int] NOT NULL,
	[cuenta_banco] [int] NOT NULL,
	[banco] [varchar](20) NOT NULL,
	[fecha_solicitud] [datetime] NOT NULL,
	[prom_pond_gen_img] [varbinary](max) NOT NULL,
	[prom_pond_sem_img] [varbinary](max) NOT NULL,
	[creds_gen_img] [varbinary](max) NOT NULL,
	[creds_sem_img] [varbinary](max) NOT NULL,
	[cuenta_banco_img] [varbinary](max) NOT NULL,
	[anios_TEC] [int] NOT NULL,
	[estado] [int] NOT NULL,
	[activo] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_sol_gen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[solicitud_tutoria]    Script Date: 15/6/2018 21:38:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[solicitud_tutoria](
	[id_sol] [int] IDENTITY(1,1) NOT NULL,
	[id_estudiante] [varchar](11) NOT NULL,
	[id_sol_general] [int] NOT NULL,
	[id_curso] [varchar](20) NOT NULL,
	[horas] [int] NULL,
	[nota_curso_tut] [int] NOT NULL,
	[id_prof_asistir] [int] NULL,
	[nota_curso_tut_img] [varbinary](max) NOT NULL,
	[activo] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_sol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[usuario]    Script Date: 15/6/2018 21:38:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usuario](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cedula] [varchar](9) NOT NULL,
	[correo_electronico] [varchar](100) NOT NULL,
	[contrasenna] [varchar](max) NOT NULL,
	[primer_nombre] [varchar](20) NOT NULL,
	[segundo_nombre] [varchar](20) NULL,
	[primer_apellido] [varchar](20) NOT NULL,
	[segundo_apellido] [varchar](20) NOT NULL,
 CONSTRAINT [usuario_pkey] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[cedula] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[correo_electronico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[rol]  WITH CHECK ADD  CONSTRAINT [rol_sistema_fkey] FOREIGN KEY([sistema])
REFERENCES [dbo].[sistema_informacion] ([id_sistema])
GO
ALTER TABLE [dbo].[rol] CHECK CONSTRAINT [rol_sistema_fkey]
GO
ALTER TABLE [dbo].[roles_por_usuario]  WITH CHECK ADD  CONSTRAINT [email_rol_p_usario_fkey] FOREIGN KEY([usuario])
REFERENCES [dbo].[usuario] ([id])
GO
ALTER TABLE [dbo].[roles_por_usuario] CHECK CONSTRAINT [email_rol_p_usario_fkey]
GO
ALTER TABLE [dbo].[roles_por_usuario]  WITH CHECK ADD  CONSTRAINT [rol_rol_p_usario_fkey] FOREIGN KEY([rol])
REFERENCES [dbo].[rol] ([id_rol])
GO
ALTER TABLE [dbo].[roles_por_usuario] CHECK CONSTRAINT [rol_rol_p_usario_fkey]
GO
ALTER TABLE [dbo].[solicitud_asistente]  WITH CHECK ADD  CONSTRAINT [SolAsis_x_Curso] FOREIGN KEY([id_curso])
REFERENCES [dbo].[curso] ([codigo_curso])
GO
ALTER TABLE [dbo].[solicitud_asistente] CHECK CONSTRAINT [SolAsis_x_Curso]
GO
ALTER TABLE [dbo].[solicitud_asistente]  WITH CHECK ADD  CONSTRAINT [SolAsis_x_Estudiante] FOREIGN KEY([id_estudiante])
REFERENCES [dbo].[estudiantes] ([carne])
GO
ALTER TABLE [dbo].[solicitud_asistente] CHECK CONSTRAINT [SolAsis_x_Estudiante]
GO
ALTER TABLE [dbo].[solicitud_asistente]  WITH CHECK ADD  CONSTRAINT [SolAsis_x_Profesor] FOREIGN KEY([id_prof_asistir])
REFERENCES [dbo].[usuario] ([id])
GO
ALTER TABLE [dbo].[solicitud_asistente] CHECK CONSTRAINT [SolAsis_x_Profesor]
GO
ALTER TABLE [dbo].[solicitud_asistente]  WITH CHECK ADD  CONSTRAINT [SolAsis_x_SolGeneral] FOREIGN KEY([id_sol_general])
REFERENCES [dbo].[solicitud_general] ([id_sol_gen])
GO
ALTER TABLE [dbo].[solicitud_asistente] CHECK CONSTRAINT [SolAsis_x_SolGeneral]
GO
ALTER TABLE [dbo].[solicitud_especial]  WITH CHECK ADD  CONSTRAINT [SolEsp_x_Estudiante] FOREIGN KEY([id_estudiante])
REFERENCES [dbo].[estudiantes] ([carne])
GO
ALTER TABLE [dbo].[solicitud_especial] CHECK CONSTRAINT [SolEsp_x_Estudiante]
GO
ALTER TABLE [dbo].[solicitud_especial]  WITH CHECK ADD  CONSTRAINT [SolEsp_x_SolGeneral] FOREIGN KEY([id_sol_general])
REFERENCES [dbo].[solicitud_general] ([id_sol_gen])
GO
ALTER TABLE [dbo].[solicitud_especial] CHECK CONSTRAINT [SolEsp_x_SolGeneral]
GO
ALTER TABLE [dbo].[solicitud_estudiante]  WITH CHECK ADD  CONSTRAINT [SolEst_x_Estudiante] FOREIGN KEY([id_estudiante])
REFERENCES [dbo].[estudiantes] ([carne])
GO
ALTER TABLE [dbo].[solicitud_estudiante] CHECK CONSTRAINT [SolEst_x_Estudiante]
GO
ALTER TABLE [dbo].[solicitud_estudiante]  WITH CHECK ADD  CONSTRAINT [SolEst_x_SolGeneral] FOREIGN KEY([id_sol_general])
REFERENCES [dbo].[solicitud_general] ([id_sol_gen])
GO
ALTER TABLE [dbo].[solicitud_estudiante] CHECK CONSTRAINT [SolEst_x_SolGeneral]
GO
ALTER TABLE [dbo].[solicitud_general]  WITH CHECK ADD  CONSTRAINT [SolGen_x_Estado] FOREIGN KEY([estado])
REFERENCES [dbo].[estados_solicitud] ([id_estado])
GO
ALTER TABLE [dbo].[solicitud_general] CHECK CONSTRAINT [SolGen_x_Estado]
GO
ALTER TABLE [dbo].[solicitud_tutoria]  WITH CHECK ADD  CONSTRAINT [SolTuto_x_Curso] FOREIGN KEY([id_curso])
REFERENCES [dbo].[curso] ([codigo_curso])
GO
ALTER TABLE [dbo].[solicitud_tutoria] CHECK CONSTRAINT [SolTuto_x_Curso]
GO
ALTER TABLE [dbo].[solicitud_tutoria]  WITH CHECK ADD  CONSTRAINT [SolTuto_x_Estudiante] FOREIGN KEY([id_estudiante])
REFERENCES [dbo].[estudiantes] ([carne])
GO
ALTER TABLE [dbo].[solicitud_tutoria] CHECK CONSTRAINT [SolTuto_x_Estudiante]
GO
ALTER TABLE [dbo].[solicitud_tutoria]  WITH CHECK ADD  CONSTRAINT [SolTuto_x_Profesor] FOREIGN KEY([id_prof_asistir])
REFERENCES [dbo].[usuario] ([id])
GO
ALTER TABLE [dbo].[solicitud_tutoria] CHECK CONSTRAINT [SolTuto_x_Profesor]
GO
ALTER TABLE [dbo].[solicitud_tutoria]  WITH CHECK ADD  CONSTRAINT [SolTuto_x_SolGeneral] FOREIGN KEY([id_sol_general])
REFERENCES [dbo].[solicitud_general] ([id_sol_gen])
GO
ALTER TABLE [dbo].[solicitud_tutoria] CHECK CONSTRAINT [SolTuto_x_SolGeneral]
GO
