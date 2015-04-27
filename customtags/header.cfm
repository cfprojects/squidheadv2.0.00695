<!---   header.cfm

CREATED				: Terrence Ryan
DESCRIPTION			: Custom Tag that acts as the default document header for the application.
--->
<cfprocessingdirective suppresswhitespace="yes">
<cfparam name="attributes.onLoad" type="string" default = "" />
<cfparam name="attributes.displayHeader" type="boolean" default = "TRUE" />
<cfparam name="attributes.displayToolbar" type="boolean" default = "TRUE" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Squidhead</title>
<cfoutput><link rel="stylesheet" href="#application.relativePath#/css/master.cfm" type="text/css"/>
<script language="JavaScript" src="#application.relativePath#/scripts/lib.js" type="text/javascript"></script></cfoutput>
</head>

<cfif len(attributes.onLoad) gt 0>
	<cfoutput><body onload="#attributes.onLoad#"></cfoutput>
<cfelse>
	<body>
</cfif>
<cfif attributes.displayheader>
<cfoutput><h1><img src="#application.relativePath#/img/title.gif" height="115" width="422" alt="Squidhead" title="title" />
<img src="#application.relativePath#/img/vblive.jpg" width="252" height="92" id="vb" /></h1></cfoutput>
</cfif>
<cfif attributes.displayToolbar>
<cfoutput>
<cf_navmain />
</cfoutput>
</cfif>
</cfprocessingdirective>
<cfexit method="exitTag" />