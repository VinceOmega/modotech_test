
<!---
<cftransaction>

	<cftry>

		<cfset intClients 	= queryNew('')>
		<cfset intEntries 	= queryNew('')>
		<cfset intProjects 	= queryNew('')>
		<cfset intUsers 	= queryNew('')>
		<cfset inserts 		= queryNew('')>

		<cfquery datasource="ModoInt" name="intClients">
			CREATE TABLE [dbo].[INTClients](
				[ClientNumber] [int] IDENTITY(1,1) NOT NULL,
				[Name] [varchar](255) NULL,
			 CONSTRAINT [PK_INTClients] PRIMARY KEY CLUSTERED 
			(
				[ClientNumber] ASC
			)) ON [PRIMARY]
		</cfquery>

		<cfquery datasource="ModoInt" name="intEntries">
			CREATE TABLE [dbo].[INTEntries](
				[EntryNumber] [bigint] IDENTITY(1,1) NOT NULL,
				[UserNumber] [int] NOT NULL,
				[ClientNumber] [int] NOT NULL,
				[ProjectNumber] [int] NOT NULL,
				[WorkDate] [datetime] NULL,
				[HoursWorked] [decimal](9, 2) NULL,
				[Notes] [varchar](max) NULL,
				[DateCreated] [datetime] NULL,
				[DateModified] [datetime] NULL,
			 CONSTRAINT [PK_INTEntries] PRIMARY KEY CLUSTERED 
			(
				[EntryNumber] ASC
			)) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
			GO

			ALTER TABLE [dbo].[INTEntries] ADD  CONSTRAINT [DF_INTEntries_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
			GO
		</cfquery>

		<cfquery datasource="ModoInt" name="intProjects">
			CREATE TABLE [dbo].[INTProjects](
				[ProjectNumber] [int] IDENTITY(1,1) NOT NULL,
				[DisplayName] [varchar](255) NULL,
				[ClientNumber] [int] NULL,
			 CONSTRAINT [PK_INTProjects] PRIMARY KEY CLUSTERED 
			(
				[ProjectNumber] ASC
			)) ON [PRIMARY]
			GO

			ALTER TABLE [dbo].[INTProjects] ADD  CONSTRAINT [DF_INTProjects_ClientNumber]  DEFAULT ((0)) FOR [ClientNumber]
			GO
		</cfquery>

		<cfquery datasource="ModoInt" name="intUsers">
			CREATE TABLE [dbo].[INTUsers](
				[UserNumber] [int] IDENTITY(1,1) NOT NULL,
				[DisplayName] [varchar](255) NULL,
				[Supervisor] [int] NULL,
			 CONSTRAINT [PK_INTUsers] PRIMARY KEY CLUSTERED 
			(
				[UserNumber] ASC
			)) ON [PRIMARY]
			GO

			ALTER TABLE [dbo].[INTUsers] ADD  CONSTRAINT [DF_INTUsers_Supervisor]  DEFAULT ((0)) FOR [Supervisor]
			GO
		</cfquery>

		<cfquery datasource="ModoInt" name="inserts">
			Set Identity_Insert INTClients on

			Insert into INTClients(
			ClientNumber,Name)
			Values (1,'Modotech')

			Insert into INTClients(
			ClientNumber,Name)
			Values (2,'ACME')

			Insert into INTClients(
			ClientNumber,Name)
			Values (3,'WidgCo')

			Insert into INTClients(
			ClientNumber,Name)
			Values (4,'ISO')

			Insert into INTClients(
			ClientNumber,Name)
			Values (5,'IIX')

			Insert into INTClients(
			ClientNumber,Name)
			Values (6,'Transunion')

			Set Identity_Insert INTClients off



			Set Identity_Insert INTEntries on

			Insert into INTEntries(
			EntryNumber,UserNumber,ClientNumber,ProjectNumber,WorkDate,HoursWorked,Notes,DateCreated,DateModified)
			Values (1,3,1,12,'10/01/2017',4.00,'Design Interview Project','10/02/2017 09:28:27.000',Null)

			Insert into INTEntries(
			EntryNumber,UserNumber,ClientNumber,ProjectNumber,WorkDate,HoursWorked,Notes,DateCreated,DateModified)
			Values (2,3,3,3,'10/01/2017',2.00,'Work on general Support project for this company','10/02/2017 09:29:24.000',Null)

			Set Identity_Insert INTEntries off



			Set Identity_Insert INTProjects on

			Insert into INTProjects(
			ProjectNumber,DisplayName,ClientNumber)
			Values (1,'Non-Bill',0)

			Insert into INTProjects(
			ProjectNumber,DisplayName,ClientNumber)
			Values (2,'Base System Changes',0)

			Insert into INTProjects(
			ProjectNumber,DisplayName,ClientNumber)
			Values (3,'IIX Integration',5)

			Insert into INTProjects(
			ProjectNumber,DisplayName,ClientNumber)
			Values (4,'IIX APlus Report',5)

			Insert into INTProjects(
			ProjectNumber,DisplayName,ClientNumber)
			Values (5,'Billing Entries',1)

			Insert into INTProjects(
			ProjectNumber,DisplayName,ClientNumber)
			Values (6,'Conference Call',0)

			Insert into INTProjects(
			ProjectNumber,DisplayName,ClientNumber)
			Values (7,'Status Meeting',1)

			Insert into INTProjects(
			ProjectNumber,DisplayName,ClientNumber)
			Values (8,'Bomb Design',2)

			Insert into INTProjects(
			ProjectNumber,DisplayName,ClientNumber)
			Values (9,'Crate Packing',2)

			Insert into INTProjects(
			ProjectNumber,DisplayName,ClientNumber)
			Values (10,'Fidget Spinning',3)

			Insert into INTProjects(
			ProjectNumber,DisplayName,ClientNumber)
			Values (11,'Support Work',0)

			Insert into INTProjects(
			ProjectNumber,DisplayName,ClientNumber)
			Values (12,'Interview Process',1)

			Set Identity_Insert INTProjects off



			Set Identity_Insert INTUsers on

			Insert into INTUsers(
			UserNumber,DisplayName,Supervisor)
			Values (1,'Chris',0)

			Insert into INTUsers(
			UserNumber,DisplayName,Supervisor)
			Values (2,'Rob',0)

			Insert into INTUsers(
			UserNumber,DisplayName,Supervisor)
			Values (3,'Matthew',1)

			Insert into INTUsers(
			UserNumber,DisplayName,Supervisor)
			Values (4,'Anita',1)

			Insert into INTUsers(
			UserNumber,DisplayName,Supervisor)
			Values (5,'Bill',3)

			Insert into INTUsers(
			UserNumber,DisplayName,Supervisor)
			Values (6,'Ed',3)

			Insert into INTUsers(
			UserNumber,DisplayName,Supervisor)
			Values (7,'Kelly',4)

			Insert into INTUsers(
			UserNumber,DisplayName,Supervisor)
			Values (8,'Dave',4)

			Insert into INTUsers(
			UserNumber,DisplayName,Supervisor)
			Values (9,'Kathleen',4)

			Set Identity_Insert INTUsers off

		</cfquery>

		<cftransaction action="commit"/>

		<cfcatch type="any">

			<cftransaction action="rollback"/>

			<cfdump var="#cfcatch#">

		</cfcatch>

	</cftry>

</cftransaction>
--->

<cfset intClientsDisplay 	= queryNew('')>
<cfset intEntriesDisplay 	= queryNew('')>
<cfset intProjectsDisplay	= queryNew('')>
<cfset intUsersDisplay 		= queryNew('')>

<cfquery datasource="ModoInt" name="intClientsDisplay">
	select *
	from intClients
</cfquery>

<cfquery datasource="ModoInt" name="intEntriesDisplay">
	select *
	from intEntries
</cfquery>

<cfquery datasource="ModoInt" name="intProjectsDisplay">
	select *
	from intProjects
</cfquery>

<cfquery datasource="ModoInt" name="intUsersDisplay">
	select *
	from intUsers
</cfquery>

<cfdump var="#intClientsDisplay#" 	label="Clients - intClients">
<cfdump var="#intEntriesDisplay#" 	label="Enteries - intEntries">
<cfdump var="#intProjectsDisplay#" 	label="Projects - intProjects">
<cfdump var="#intUsersDisplay#" 	label="User - intUsers">


