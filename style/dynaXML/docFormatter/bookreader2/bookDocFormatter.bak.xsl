<xsl:stylesheet version="2.0" 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xtf="http://cdlib.org/xtf"
   xmlns:session="java:org.cdlib.xtf.xslt.Session"
   xmlns:editURL="http://cdlib.org/xtf/editURL"
   xmlns:local="http://local"
   xmlns="http://www.w3.org/1999/xhtml"
   extension-element-prefixes="session"
   exclude-result-prefixes="#all">

   <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
   <!-- BookReader dynaXML Stylesheet                                          -->
   <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
   
   <!--
      Copyright (c) 2010, Regents of the University of California
      All rights reserved.
      
      Redistribution and use in source and binary forms, with or without 
      modification, are permitted provided that the following conditions are 
      met:
      
      - Redistributions of source code must retain the above copyright notice, 
      this list of conditions and the following disclaimer.
      - Redistributions in binary form must reproduce the above copyright 
      notice, this list of conditions and the following disclaimer in the 
      documentation and/or other materials provided with the distribution.
      - Neither the name of the University of California nor the names of its
      contributors may be used to endorse or promote products derived from 
      this software without specific prior written permission.
      
      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
      AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
      IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
      ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
      LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
      CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
      SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
      INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
      CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
      ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
      POSSIBILITY OF SUCH DAMAGE.
   -->
   
   <!-- 
      NOTE: This is a stab at providing XTF access to scanned books, using the
      Open Library BookReader.
   -->
   
   <!-- ====================================================================== -->
   <!-- Import Common Templates                                                -->
   <!-- ====================================================================== -->
  
   <xsl:import href="../common/docFormatterCommon.xsl"/>
   <xsl:import href="../../../xtfCommon/xtfCommon.xsl"/>
   
   <!-- ====================================================================== -->
   <!-- Output Format                                                          -->
   <!-- ====================================================================== -->
   
   <xsl:output 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
    encoding="UTF-8"
    exclude-result-prefixes="#all"
    indent="yes"
    omit-xml-declaration="yes" />

   <!-- ====================================================================== -->
   <!-- Strip Space                                                            -->
   <!-- ====================================================================== -->
  
   <!-- 
   <xsl:strip-space elements="*"/>
   -->
   
   <!-- ====================================================================== -->
   <!-- Included Stylesheets                                                   -->
   <!-- ====================================================================== -->
   
   <xsl:include href="search.xsl"/>
   
   <!-- ====================================================================== -->
   <!-- Define Keys                                                            -->
   <!-- ====================================================================== -->
   
   <xsl:key name="div-id" match="sec" use="@id"/>
   
   <!-- ====================================================================== -->
   <!-- Define Parameters                                                      -->
   <!-- ====================================================================== -->
   
   <xsl:param name="root.URL"/>
   <xsl:param name="doc.title" select="/xtf-converted-book/xtf:meta/display-title"/>
   <xsl:param name="servlet.dir"/>
   <!-- for docFormatterCommon.xsl -->
   <xsl:param name="css.path" select="'css/default/'"/>
   <xsl:param name="icon.path" select="'css/default/'"/>
   
   <!-- ====================================================================== -->
   <!-- Root Template                                                          -->
   <!-- ====================================================================== -->
   
   <xsl:template match="/">
      <xsl:call-template name="content"/>
	<!--<xsl:copy-of select="."/>-->
   </xsl:template>

   <!-- ====================================================================== -->
   <!-- Content Template                                                       -->
   <!-- ====================================================================== -->
   
<xsl:template name="content">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>

    <title>The University of Chicago Library</title>

    <script type="text/javascript" src="/script/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="/script/jquery-ui-1.8.5.custom.min.js"></script>
    <script type="text/javascript" src="/script/jquery.hotkeys.js"></script>
    <script type="text/javascript" src="/script/dragscrollable.js"></script>
    <script type="text/javascript" src="/script/jquery.ui.ipad.js"></script>
    <script type="text/javascript" src="/script/jquery.bt.min.js"></script>
    <script type="text/javascript" src="/script/BookReader.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/BookReader.css"/>
    <link rel="stylesheet" type="text/css" href="/css/BookReaderDemo.css"/>
</head>
<body>

<div id="header">
    <a class="homelink" href="http://www.lib.uchicago.edu/">The University of Chicago Library</a>
    <span class="arrow"> &gt; </span>
    <a href="/">Campus Publication</a>
    <span class="arrow"> &gt; </span>
    <xsl:value-of select="$doc.title"/>

    <form action="/xtf/view" id="booksearch" method="get" style="float: right;">
        <input id="textSrch" name="textSrch" type="search"/>
        <input name="docId" type="hidden">
		<xsl:attribute name="value">
			<xsl:value-of select="
				concat(
					'bookreader/',
					//sort-identifier[1],
					'/',
					//sort-identifier[1],
					'.bookreader.xml'
				)
			"/>
		</xsl:attribute>
	</input>
        <input type="hidden" value="1" name="hit.rank"/>
        <button id="btnSrch" name="btnSrch" type="submit">GO</button>
    </form>
</div>

<div id="BookReader">
<noscript>
    <p>This page requires JavaScript to be enabled. Please check that your
    browser supports JavaScript and that it is enabled in the browser settings.</p>
</noscript>
</div>

<div id="footer">
    <div id="footerleft">
        <button class="BRicon zoom_out" title="Zoom out"></button>
        <button class="BRicon zoom_in" title="Zoom out"></button>
    </div>
    <div id="footercenter">
        <button class="BRicon book_left" title="Previous"></button>
        <input id="pagenumber" type="text"/>
        <button class="BRicon book_right" title="Next"></button>
    </div>
    <div id="footerright">
        <button class="BRicon onepg" title="One-page view"></button>
        <button class="BRicon twopg" title="Two-page view"></button>
        <button class="BRicon thumb" title="Thumbnail view"></button>
    </div>
</div>

<script type="text/javascript" src="/script/BookReaderJSSimple.js"></script>

</body>
</html>
</xsl:template>
   
</xsl:stylesheet>
