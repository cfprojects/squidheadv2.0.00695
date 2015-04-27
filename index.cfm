<!---    index.cfm

AUTHOR				: tpryan
CREATED				: 9/11/2007 10:02:33 PM
DESCRIPTION			: Main page of the Squdihead Application.
---->
<cfparam name="url.method" type="string" default="menu" />
<cfparam name="url.forceRefresh" type="boolean" default="FALSE" />
<cfparam name="url.appname" type="string" default="" />
<cfsetting requesttimeout="500" />


<cfimport taglib="customtags" prefix="pageElement" />

<!--- Ensure that random text on the url string don't cause issues. --->
<cfif not CompareNoCase(url.method, "run")>
	<cfif len(url.appName) lt 1 OR not FileExists(ExpandPath('.') & "/config/" & url.appName & ".cfm") >
		<cfset url.method= "appmissing" />
	</cfif>
</cfif>

<cfswitch expression="#url.method#">

	<!--- Menu --->
	<cfcase value="menu">

		<cfdirectory name="configDir" directory="#ExpandPath('.')#/config/" action="list" filter="*.cfm" />
		<cfquery dbtype="query" name="configDir">
			SELECT name
			FROM	configDir
			WHERE	name != 'sample.cfm'
			AND 	name != 'default.cfm'
			AND 	name != 'defaultFileLocations.cfm'
			AND 	name != 'defaultPreLoad.cfm'
			AND 	name != 'defaultPostLoad.cfm'
		</cfquery>

		<pageElement:header onLoad="alternate('configuration')">

			<cfif configDir.recordCount gt 0>

				<h2>Which application would you like to generate?</h2>

				<ul>
				<cfoutput query="configDir">
					<li><a href="#cgi.script_name#?method=run&amp;appName=#GetToken(name, 1, ".")#">#GetToken(name, 1, ".")#</a>
						<span class="option">(<a href="#cgi.script_name#?method=run&amp;appName=#GetToken(name, 1, ".")#&amp;forceRefresh=True" onclick="if (confirm('Are you sure? Proceeding will overwrite all files, not just dynamic ones. ')) { document.location.replace('#cgi.script_name#?method=run&amp;appName=#GetToken(name, 1, ".")#&amp;forceRefresh=True') }; return false">Force Refresh</a>)</span>
					</li>
				</cfoutput>
				</ul>

			<cfelse>
			<p>There are no applications currently configured. Go to the config folder, copy the sample, give it a meaningful name, and make changes to it.
				If you need help setting the configuration, there is a reference on the installation page.
			</p>

			</cfif>


		<pageElement:footer>
	</cfcase>
	<!--- Run --->
	<cfcase value="run">
		<cfflush interval="1" />

		<pageElement:header>
		<div class="logging">
		<cftimer label="Entire Process" type="inline">

			<!--- Configuration retrieval has to happen up here, because of pathing issues. --->
			<cftimer label="Getting Configuration" type="inline">
				<h2>Getting Configuration</h2>
				<cfinclude template="config/defaultPreLoad.cfm" />
				<cfinclude template="config/#url.appname#.cfm" />
				<cfinclude template="config/defaultPostLoad.cfm" />

				<!--- Push the various configs into the configObj --->
				<cfinvoke component="cfc.config" method="init" returnvariable="configObj">
					<cfinvokeargument name="configuration" value="#config#" />
					<cfinvokeargument name="version" value="#application.version#" />
				</cfinvoke>



				<cfset structDelete(variables, "config") />

			</cftimer>

			<!--- Create step tracker to keep track of all of the steps that have been run, for requiring them in other steps. --->
			<cfset stepTrackerObj = createObject("component", "cfc.stepTracker").init(configObj.get('application','steps')) />

			<!--- Loop through the steps of the application, as dictated by the application --->
			<!--- This allows for more flexibility of steps --->
			<cfloop array="#configObj.get('application','steps')#" index="step">
				<cfinclude template="steps/#step#.cfm" />
				<cfset stepTrackerObj.AddStep(step) />
			</cfloop>


		<h2>Done</h2>
		<!--- If they added url to the configuration, show it.  --->
		<cfif configObj.exists('application','url')>
			<cfoutput>
			<p>Results: <a href="#configObj.get('application','url')#">#configObj.get('application','url')#</a></p>

			<p>Test: <a href="#configObj.get('application','url')#/test/">#configObj.get('application','url')#test/</a></p>

			</cfoutput>
		</cfif>
		</cftimer>

		</div>


		<pageElement:footer>
	</cfcase>

	<!--- appMissing --->
	<cfcase value="appmissing">
		<pageElement:header>
		<p>There is no configuration file for the application you have tried to select</p>
		<pageElement:footer>
	</cfcase>
</cfswitch>