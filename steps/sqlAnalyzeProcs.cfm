<!---    sqlAnalyzeProcs.cfm

AUTHOR				: tpryan
CREATED				: 9/20/2007 1:45:19 AM
DESCRIPTION			: This step reads in all of the stored procs in the database for use by other steps.
---->
<cfset stepTrackerObj.require("sqlAnalyzeTables") />

<cftimer label="Analyzing Stored Procedures" type="inline">
<h2>Analyzing Stored Procedures</h2>

<cfset databaseObj.inspectProcedures() />

<cfset procedureArray = databaseObj.getProcedureArray() />

<cfif not structKeyExists(variables, "tableArray")>
	<cfset tableArray = databaseObj.getTableArray() />
</cfif>

<cfif ArrayLen(procedureArray) lt 1>
	<cfsavecontent variable="details">
	In order to create an applicaiton, there must be stored procedures in the underlying database.
	If you are running in scripting mdoe, runs the generated script on the database before running Squidhead Again.
	</cfsavecontent>

	<cfthrow type="Squidhead" message="There are no stored procedures." detail="#details#" />
</cfif>

</cftimer>