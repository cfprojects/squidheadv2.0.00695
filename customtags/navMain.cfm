<!---    navMain.cfm

AUTHOR				: tpryan
CREATED				: 9/18/2007 11:15:11 AM
DESCRIPTION			: Encapsulates main navigation.
---->

<cfprocessingdirective suppresswhitespace="yes">
<cfoutput><ul id="toolbar">
	<li><a href="#application.relativePath#">Main</a></li>



	<cfif FindNoCase("configbuilder", cgi.script_name)>
		<li>Add Application</li>
	<cfelse>
		<li><a href="#application.relativePath#/configBuilder.cfm" title="Add Application">Add Application</a></li>
	</cfif>

	<cfif FindNoCase("/docs/", cgi.script_name)>
		<li>Documentation</li>
	<cfelse>
		<li><a href="#application.relativePath#/docs/index.cfm" title="Documentation">Documentation</a></li>
	</cfif>

</ul></cfoutput>

</cfprocessingdirective>
<!--- In case you call as a tag  --->
<cfexit method="exittag" />