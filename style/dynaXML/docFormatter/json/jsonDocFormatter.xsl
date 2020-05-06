<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
 version="2.0"
 xmlns:json="http://json.org/"
 xmlns:xtf="http://cdlib.org/xtf"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
 extension-element-prefixes="json xs xtf">

<xsl:import href="xml-to-json.xsl"/>

<xsl:param name="skip-root" as="xs:boolean" select="true()"/>

<xsl:template match="/">
<xsl:variable name="xml-output">
	<ia><xsl:value-of select="/xtf-converted-book/xtf:meta/sort-identifier"/></ia>
	<q><xsl:value-of select="(/xtf-converted-book/xtf:snippets/xtf:snippet/xtf:hit/xtf:term)[1]"/></q>
	<indexed>true</indexed>
	<page_count><xsl:value-of select="count(/xtf-converted-book/leaf)"/></page_count>
	<leaf0_missing>false</leaf0_missing>
	<xsl:apply-templates select="/xtf-converted-book/leaf" mode="pages"/>
	<xsl:choose>
	<xsl:when test="/xtf-converted-book/leaf/line[xtf:hit]">
	<xsl:apply-templates select="/xtf-converted-book/leaf/line[xtf:hit]"/>
	</xsl:when>
	<xsl:otherwise>
		<matches json:force-array="true"></matches>
	</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:value-of select="json:generate($xml-output)"/>
</xsl:template>

<!-- matches -->
<xsl:template match="/xtf-converted-book/leaf/line[xtf:hit]">
	<matches 
	 json:force-array="true"
	 text="{
		concat(
			(xtf:hit/preceding-sibling::text())[1],
			'{{{',
			(xtf:hit/xtf:term)[1],
			'}}}',
			(xtf:hit/following-sibling::text())[1]
		)
	}">
	<xsl:apply-templates select="descendant::xtf:term"/>
	</matches>
</xsl:template>

<xsl:template match="xtf:term">
<xsl:variable name="spacingcountright" select="
	if (not(normalize-space(parent::xtf:hit/preceding-sibling::text()[1])='')) 
	then(
		(count(
			tokenize(
				(parent::xtf:hit/preceding-sibling::text())[1],
				'\s+'
			)
		) + 0) * 2
	) else 2
"/>
<xsl:variable name="spacingcountleft" select="$spacingcountright - 1"/>
<xsl:variable name="spacing" select="
tokenize(
	ancestor::line/@spacing,
	'\s+'
)
"/>
<xsl:variable name="spacingoffsetleft" select="
sum(
	for $s in 
		subsequence(
			$spacing,
			0,
			$spacingcountleft
			
		)
	return number($s)
)
"/>
<xsl:variable name="spacingoffsetright" select="
sum(
	for $s in 
		subsequence(
			$spacing,
			0,
			$spacingcountright
		)
	return number($s)
)
"/>
<par json:force-array="true"
 page="{ancestor::leaf/@leafNum}"
 page_width="{ancestor::leaf/cropBox/@x}"
 page_height="{ancestor::leaf/cropBox/@y}"
 b="{ancestor::line/@b}"
 t="{ancestor::line/@t}"
 r="{ancestor::line/@r}"
 l="{ancestor::line/@l}">
<boxes json:force-array="true">
<b><xsl:value-of select="ancestor::line/@b"/></b>
<t><xsl:value-of select="ancestor::line/@t"/></t>
<l><xsl:value-of select="ancestor::line/@l + $spacingoffsetleft"/></l>
<r><xsl:value-of select="ancestor::line/@l + $spacingoffsetright"/></r>
<page><xsl:value-of select="ancestor::leaf/@leafNum"/></page>
</boxes>
</par>
</xsl:template>

<xsl:template match="leaf" mode="pages">
	<pages
		x="{cropBox/@x}"
		y="{cropBox/@y}"
		imgFile="{@imgFile}"
		leafNum="{@leafNum}"
	/>
</xsl:template>

</xsl:stylesheet>
