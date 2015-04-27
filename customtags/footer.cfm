<!---   footer.cfm

CREATED				: Terrence Ryan
DESCRIPTION			: Custom tag that acts at footer for the application.
--->
<cfprocessingdirective suppresswhitespace="yes">
<p id="footer">
	<a href="http://squidhead.riaforge.org/">Squidhead</a> Application Generator
	<cfif structKeyExists(application, "version")><cfoutput>v#application.version#</cfoutput></cfif>
	by <a href="http://www.numtopia.com/terry">Terrence Ryan</a>
</p>
</body>
</html>
</cfprocessingdirective>
<cfexit method="exitTag" />