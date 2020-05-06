<xsl:stylesheet
 exclude-result-prefixes="#all"
 version="2.0"
 xmlns:html="http://www.w3.org/1999/xhtml"
 xmlns:xtf="http://cdlib.org/xtf"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output 
 doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" 
 doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes"
 encoding="UTF-8"
 exclude-result-prefixes="#all"
 method="xml"
 omit-xml-declaration="yes"/>

<xsl:template match="/">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head></head>
<body>
<xsl:apply-templates/>
</body>
</html>
</xsl:template>

<xsl:template match="*">
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="text()">
<xsl:value-of select="translate(., '&#xA;', ' ')"/>
</xsl:template>

<xsl:template match="xtf:meta"/>

</xsl:stylesheet>
