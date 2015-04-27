<!---    sqlAnalyzeTables.cfm

AUTHOR				: tpryan
CREATED				: 9/20/2007 1:44:17 AM
DESCRIPTION			: Inspects the database tables and determines the structure for the rest of the application.
---->


<cftimer label="Analyzing Table Structure" type="inline">
<h2>Analyzing Table Structure</h2>

<cfinvoke component="#configObj.get('cfc','database')#" method="init" returnvariable="databaseObj">
	<cfinvokeargument name="configObj" value="#configObj#" />
</cfinvoke>


</cftimer>