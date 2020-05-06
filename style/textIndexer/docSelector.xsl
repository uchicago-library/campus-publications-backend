<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<!-- Index document selection stylesheet                                    -->
<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
   xmlns:FileUtils="java:org.cdlib.xtf.xslt.FileUtils"
   extension-element-prefixes="FileUtils"
   exclude-result-prefixes="#all">

<!-- ====================================================================== -->
<!-- Templates                                                              -->
<!-- ====================================================================== -->

   <xsl:template match="directory">
      <indexFiles>
        <xsl:apply-templates/>
      </indexFiles>
   </xsl:template>
   
   <xsl:template match="file[matches(@fileName, 'mvol-[0-9]{4}-[0-9]{4}-[0-9A-Z]{4}(-[0-9]{2})?\.xml')]">
      <indexFile fileName="{@fileName}" preFilter="style/textIndexer/passthru/passthruPreFilter.xsl"/>
   </xsl:template>

</xsl:stylesheet>
