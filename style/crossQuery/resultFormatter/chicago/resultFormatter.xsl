<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
 xmlns="http://www.w3.org/1999/xhtml"
 exclude-result-prefixes="#all"
 version="2.0">

<xsl:output method="xhtml" indent="no" 
 encoding="UTF-8" media-type="text/html; charset=UTF-8" 
 doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" 
 doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" 
 omit-xml-declaration="yes"
 exclude-result-prefixes="#all"/>

<xsl:template match="text()"/>

<xsl:template match="/">
<html>
<head>
</head>
<body>
<p>Database running.</p>
</body>
</html>
</xsl:template>

</xsl:stylesheet>
