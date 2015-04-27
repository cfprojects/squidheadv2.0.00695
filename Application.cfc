<!---
Copyright 2007 Terrence Ryan
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
--->

<!---    Application.cfc

CREATED				: Terrence Ryan
DESCRIPTION			: Application framework file.
--->
<cfcomponent>



	<cfsetting showdebugoutput="no" />
	<cfset This.name= "squidhead#ReplaceList(ExpandPath('.'),'\,/,:','_,_,')#" />
	<cfset This.customtagpaths = "#ExpandPath('.')#/customtags/"/>
	<cfset this.mappings["/squidhead2"] = getDirectoryFromPath(getCurrentTemplatePath())>
	<cfset this.mappings["/squidhead"] = getDirectoryFromPath(getCurrentTemplatePath())>

	<cferror type="exception" template="error_exception.cfm" exception="any" />
	<cferror type="request" template="error_request.cfm" exception="any" />



	<!--- onApplicationStart --->
	<cffunction name="onApplicationStart" output="false">
		<cfinclude template="includes/buildNum.cfm" />

		<cfset application.version = "2.0." & NumberFormat(application.buildnum, "00000") />
		<cfset application.relativePath = findRelativeRoot() />

		<cfset application.utilityObj = createObject("component", "cfc.utility") />


		<cfimage action="read" source="#getDirectoryFromPath(getCurrentTemplatePath())#/img/vb.jpg" name="vb" />

		<cfset fontDetails = StructNew() />

		<cfif FindNoCase("Vista", server.os.name)>
			<cfset fontDetails.font = "Calibri" />
			<cfset fontDetails.size  = 30 />
		<cfelseif FindNoCase("windows", server.os.name)>
			<cfset fontDetails.font = "Arial" />
			<cfset fontDetails.size  = 27 />
		<cfelseif FindNoCase("unix", server.os.name)>
			<cfset fontDetails.font = "Bitstream Vera Sans" />
			<cfset fontDetails.size  = 23 />	
		<cfelse>
			<cfset fontDetails.font = "Helvetica" />
			<cfset fontDetails.size  = 27 />
		</cfif>

		<cfset ImageSetAntialiasing(vb,'on') />
		<cfset ImageSetDrawingColor(vb, "##ffac59") />
		<cfset ImageDrawText(vb, "Version " & application.version, 10, 55, fontDetails)/>

		<cfimage action="write" source="#vb#" destination="#getDirectoryFromPath(getCurrentTemplatePath())#/img/vblive.jpg" overwrite="TRUE" />



	</cffunction>

	<!--- onRequestStart --->
	<cffunction name="onRequestStart">
		<cfparam name="url.resetApp" type="boolean" default="TRUE" />
		<cfif url.resetApp>
			<cfinvoke method="onApplicationStart" />
		</cfif>

	</cffunction>

	<cffunction access="public" name="findRelativeRoot" output="false" returntype="string" hint="Determines the relative root of a page. " >
		<cfreturn "/" & Replace(ReplaceNoCase(getDirectoryFromPath(getCurrentTemplatePath()), ExpandPath("/"), "", "ALL"), "\", "/", "ALL") />
	</cffunction>

</cfcomponent>