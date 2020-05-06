<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xtf="http://cdlib.org/xtf" version="2.0" exclude-result-prefixes="#all">
   
<xsl:output method="xml" 
 indent="yes" 
 encoding="UTF-8"/>
   
<xsl:template match="element()">
	<xsl:copy>
		<xsl:apply-templates select="@*,node()"/>
	</xsl:copy>
</xsl:template>

<xsl:template match="attribute()|text()|comment()|processing-instruction()">
	<xsl:copy/>
</xsl:template>
   
</xsl:stylesheet>
