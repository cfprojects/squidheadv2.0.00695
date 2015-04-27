<cfparam name="url.method" type="string" default="" />


<cfimport taglib="customtags" prefix="pageElement" />




<cfswitch expression="#url.method#">
	<cfcase value="createConfig">


		<cfset cfcPath = form.appdir & "/cfc" />
		<cfset cfcPath = Replace(cfcPath, "//", "/", "ALL") />
		<cfset cfcPath = ReplaceNoCase(cfcPath, expandPath("/"), "", "ALL") />
		<cfset cfcPath = ReplaceNoCase(cfcPath, "/", ".", "ALL") />
		<cfset cfcPath = ReplaceNoCase(cfcPath, "\", ".", "ALL") />

		<cfset squidheadpath = ExpandPath('.') & "/cfc" />
		<cfset squidheadpath = Replace(squidheadpath, "//", "/", "ALL") />
		<cfset squidheadpath = ReplaceNoCase(squidheadpath, expandPath("/"), "", "ALL") />
		<cfset squidheadpath = ReplaceNoCase(squidheadpath, "/", ".", "ALL") />
		<cfset squidheadpath = ReplaceNoCase(squidheadpath, "\", ".", "ALL") />


		<cfif FileExists("#expandPath('.')#/config/#form.appName#.cfm")>
			<pageElement:header>
				<h2>No You Don't!</h2>
				<p>That configuration file already exists. Don't go blaming me for overwriting your config. You'll have to delete that configuration file yourself.</p>
				<p><a href="configBuilder.cfm">Try Again</a></p>
			<pageElement:footer>
			<cfabort />
		</cfif>

		<cfsavecontent variable="configFileContents">
			<cfinclude template="includes/defaultConfig.cfm" />
		</cfsavecontent>


		<cfset configFileContents = Replace(configFileContents, "&lt;", "<", "ALL") />
		<cfset configFileContents = Replace(configFileContents, "&gt;", ">", "ALL") />

		<cffile action="write" file="#expandPath('.')#/config/#form.appName#.cfm" output="#configFileContents#" />

		<pageElement:header>
			<h2>Configuration Created</h2>
			<p>The configuration was created successfully.</p>
			<p><a href="index.cfm">Main Menu</a></p>
		<pageElement:footer>


	</cfcase>
	<cfdefaultcase>
		<cfset rootpath= ExpandPath('/') />
		<cfset urlPath= "http://" & cgi.server_name   />

		<cfoutput>
		<cfsavecontent variable="javascriptToInsert">
			<script type="text/javascript">

			function updatefields(){
			appname = document.getElementById('appname');
			appdir = document.getElementById('appdir');
			appurl = document.getElementById('appurl');


		appurl.value = "#urlPath#" + "/" + appname.value;
		appdir.value = "#Replace(rootpath, "\", "\\", "ALL")#" + appname.value;

			}

			</script>

		</cfsavecontent>
		</cfoutput>

		<cfhtmlhead text="#javascriptToInsert#" />

		<pageElement:header>

		<h2>Add Application</h2>

		<cfform action="#cgi.script_name#?method=createConfig" method="post">

			<fieldset>
				<legend>Application Details</legend>
				<label for="appname">Name:</label>
				<cfinput id="appname" name="appname" type="text" class="text" onchange="updatefields()" /><br />

				<label for="appdir">Directory:</label>
				<cfinput id="appdir" name="appdir" type="text" value="#rootpath#" class="text" /><br />

				<label for="appurl">URL:</label>
				<cfinput id="appurl" name="appurl" type="text" value="#urlPath#" class="text" /><br />
			</fieldset>

			<fieldset>
				<legend>Database Details</legend>

				<label for="type">Type:</label>
				<cfselect name="type" id="type" class="text">
					<option value="mssql">Microsoft Sql Server 2000/2005</option>
					<option value="mysql">MySql 5</option>
				</cfselect><br />


				<label for="datasource">Datasource:</label>
				<cfinput id="datasource" name="datasource" type="text" class="text" /><br />

				<label for="username">Username:</label>
				<cfinput id="username" name="username" type="text" value="" class="text" /><br />

				<label for="password">Password:</label>
				<cfinput id="password" name="password" type="password" value="" class="text" /><br />

				<label for="database">Database:</label>
				<cfinput id="database" name="database" type="text" value="" class="text" />(only required if type=mysql)<br />


			</fieldset>

			<cfinput type="submit" name="create" value="Create Config" />
		</cfform>

		<pageElement:footer>

	</cfdefaultcase>

</cfswitch>

