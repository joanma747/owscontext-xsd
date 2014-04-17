<?xml version="1.0" encoding="UTF-8"?>
<iso:schema
	xmlns:iso="http://purl.oclc.org/dsdl/schematron"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	schemaVersion="ISO19757-3">
    <iso:title>Schematron validation for OWS context</iso:title>
    <iso:ns prefix="atom" uri="http://www.w3.org/2005/Atom"/>   
    <iso:ns prefix="dc" uri="http://purl.org/dc/elements/1.1/"/>
    <iso:ns prefix="georss" uri="http://www.georss.org/georss"/>
    <iso:ns prefix="gml" uri="http://www.opengis.net/gml"/>
    <iso:ns prefix="owc" uri="http://www.opengis.net/owc/1.0"/>
	<iso:include href="atom_feed.sch#atom"/>
    <iso:pattern name="OWSContext validation" id="owc">
        <!-- Context rules from OGC 12-084: -->
		<iso:rule context="/">
			  <iso:assert test="atom:feed">Root element shall be 'feed'.</iso:assert>
		</iso:rule>
        <iso:rule context="atom:feed">
            <iso:assert test="@xml:lang">attribute 'xml:lang' is mandatory for the OWS context 'feed' root element.</iso:assert>
 			<iso:assert test="atom:link[@href='http://www.opengis.net/spec/owc-atom/1.0/req/core' and @rel='profile']">A OWS Context document shall have one 'atom:link' element in the 'feed' element, with an attribute rel="profile" an attribute href="http://www.opengis.net/spec/owc-atom/1.0/req/core".</iso:assert>
            <iso:assert test="count(dc:publisher)&lt;2">Only one element 'dc:publisher' is allowed in a OWSContext 'feed'</iso:assert>
            <iso:assert test="count(georss:where)&lt;2">Only one element 'georss:where' (feed areaOfInterest) is allowed in a OWSContext 'feed'</iso:assert>
            <iso:assert test="count(dc:date)&lt;2">Only one element 'dc:date' (feed timeIntervalOfInterest) is allowed in a OWSContext 'feed'</iso:assert>
            <!-- No restricions on atom:link[@rel='via'] -->
            <!-- No restricions on atom:category[@term] -->
            
            <!-- Report some interesteing thinks -->
			<iso:report test="atom:entry and count(atom:entry/atom:category[@scheme='http://www.opengis.net/spec/owc/active' and @term='false'])=count(atom:entry)">NOTE: All entries are declared inactive. the document is still valid but clients can behave in a way that users cannot easily understand</iso:report>
			<iso:report test="not(atom:entry)">NOTE: There are no entries in this feed. The document is still valid but clients can behave in a way that users cannot easily understand.</iso:report>
            <iso:report test="atom:icon">The 'feed' has an attribute 'icon' that has no meaning in OWS Context. Geospatial clients will ignore it.</iso:report>
            <iso:report test="atom:logo">The 'feed' has an attribute 'logo' that has no meaning in OWS Context. Geospatial clients will ignore it.</iso:report>
			<iso:report test="atom:link[@rel!='via' and @rel!='profile']">NOTE: There are 'link' elements with an attribute 'rel' that has a value that is not 'via'. They will not be considered links to metadata documents.</iso:report>
            <iso:report test="atom:subtitle and atom:updated and atom:author and dc:publisher and atom:generator and atom:rights and georss:where and dc:date and atom:link[@rel='via'] and atom:category[not(@scheme='http://www.opengis.net/spec/owc/specReference')]/@term and atom:entry">GOOD PRACTICE: This OWSContext feed contains all defined elements in the 'feed' element. Thanks for making a complete use of OWSContext standard</iso:report>
        </iso:rule>
        <iso:rule context="atom:entry">
            <iso:assert test="parent::atom:feed">An 'entry' shall be a child of 'feed'.</iso:assert>
			<iso:assert test="not(atom:AlternateContent) or count(atom:content)=1">The entry with id="<iso:value-of select="atom:id" />" can only have an element AlternateContent if a 'content' element is present.</iso:assert>
            <iso:assert test="count(dc:publisher)&lt;2">The entry with id="<iso:value-of select="atom:id" />" can only have one element 'dc:publisher'.</iso:assert>
            <iso:assert test="count(dc:creator)&lt;2">The entry with id="<iso:value-of select="atom:id" />" can only have one element 'creator'.</iso:assert>
            <iso:assert test="count(georss:where)&lt;2">The entry with id="<iso:value-of select="atom:id" />" can only have one element 'georss:where'.</iso:assert>
            <iso:assert test="count(dc:date)&lt;2">The entry with id="<iso:value-of select="atom:id" />" can only have one element 'owc:timeIntervalOfInterest'.</iso:assert>
            <!-- No restricions on atom:preview -->
            <!-- No restricions on atom:link[@rel="enclosure"] --> 
			<iso:assert test="count(atom:content)=1">The entry with id="<iso:value-of select="atom:id" />" shall have one element 'atom:content' to provide a generic description of the content in a format understandable by mass market generic atom readers (type="html" is recommended)).</iso:assert>
			<iso:assert test="count(atom:category[@scheme='http://www.opengis.net/spec/owc/active'])&lt;2 and (count(atom:category[@scheme='http://www.opengis.net/spec/owc/active']/@term)=0 or atom:category[@scheme='http://www.opengis.net/spec/owc/active']/@term='true' or atom:category[@scheme='http://www.opengis.net/spec/owc/active']/@term='false')">The entry with id="<iso:value-of select="atom:id" />" can only have one 'category' with scheme "http://www.opengis.net/spec/owc/active" and the only trems allowed are "true" or "false".</iso:assert>
            <iso:report test="atom:link[@rel!='via' and @rel='enclosure' and @rel='icon']">NOTE: There are 'link' elements with an attribute 'rel' that has a value that is different of "icon", "enclosure" or "via" in the entry with id="<iso:value-of select="atom:id" />". They will not be considered neither a 'preview', a link to 'contentByRef', nor a link to a 'metadata' documents.</iso:report>
            <iso:report test="atom:published">NOTE: The entry with id="<iso:value-of select="atom:id" />" has an attribute 'published' that has no meaning in OWS Context. Geospatial clients will ignore it.</iso:report>
            <iso:report test="not(atom:link[@rel='enclosure']) and not (atom:content)">NOTE: The entry with id="<iso:value-of select="atom:id" />" is without content ('link' with rel 'enclosure', or 'content'). The document is still valid but most geospatial clients might ignore this entry.</iso:report>
            <iso:report test="atom:summary and atom:updated and atom:author and dc:publisher and dc:creator and atom:rights and georss:where and dc:date and atom:link[@rel='icon'] and atom:link[@rel='via'] and atom:category/@term">GOOD PRACTICE: In this OWSContext the entry with id="<iso:value-of select="atom:id" />" has all the defined chield elements. Thanks for making a complete use of OWSContext standard</iso:report>
        </iso:rule>        
        <iso:rule context="atom:feed/georss:where">
			<iso:report test="count(gml:Point)&gt;1 or count(gml:LineString)&gt;1">Content of 'georss:where' in 'feed' does not represent an 'areaOfInterest' because a 'gml:Point' or a gml:LineString' does not close an area. OWS context clients will ignore it.</iso:report>
        </iso:rule>
        <iso:rule context="atom:entry/georss:where">
			<iso:report test="count(gml:Point)&gt;1 or count(gml:LineString)&gt;1">Content of 'georss:where' in the entry with id="<iso:value-of select="../atom:id" />" does not represent an 'geospatialExtent' because a 'gml:Point' or a gml:LineString' does not close an area. OWS context clients will ignore it.</iso:report>
        </iso:rule>
        <iso:rule context="owc:operation">
			<iso:assert test="@method!='GET' or count(owc:request)=0">An GET 'owc:operation' shall have 'href' but shall not have a 'request' element in the entry with id="<iso:value-of select="../../atom:id" />".</iso:assert>
			<iso:assert test="not(@method) or (@method!='POST' and @method!='PUT') or count(owc:request)>0">An PUT or POST 'owc:operation' shall have 'href' and a 'request' element in the entry with id="<iso:value-of select="../../atom:id" />".</iso:assert>
		</iso:rule>
        <iso:rule context="owc:offering">
			<iso:assert test="parent::atom:entry">An 'owc:offering' shall be a child of 'entry'.</iso:assert>
			<iso:assert test="@code!='http://www.opengis.net/spec/owc/1.0/conf/atom/wfs' or (count(owc:operation[@code='GetCapabilities'])=1 and count(owc:operation[@code='GetFeature'])=1)">An offering in the entry with id="<iso:value-of select="../atom:id" /> with code http://www.opengis.net/spec/owc/1.0/conf/atom/wfs" shall define a GetCapabilities and a GetFeature operation.</iso:assert>
			<iso:assert test="@code!='http://www.opengis.net/spec/owc/1.0/conf/atom/wfs' or count(owc:content)=0">An offering in the entry with id="<iso:value-of select="../atom:id" /> with code http://www.opengis.net/spec/owc/1.0/conf/atom/wfs" shall not include inline content.</iso:assert>
			<iso:assert test="@code!='http://www.opengis.net/spec/owc/1.0/conf/atom/wcs' or (count(owc:operation[@code='GetCapabilities'])=1 and count(owc:operation[@code='GetCoverage'])=1)">An offering in the entry with id="<iso:value-of select="../atom:id" /> with code http://www.opengis.net/spec/owc/1.0/conf/atom/wcs" shall define a GetCapabilities and a GetCoverage operation.</iso:assert>
			<iso:assert test="@code!='http://www.opengis.net/spec/owc/1.0/conf/atom/wcs' or count(owc:content)=0">An offering in the entry with id="<iso:value-of select="../atom:id" /> with code http://www.opengis.net/spec/owc/1.0/conf/atom/wcs" shall not include inline content.</iso:assert>
			<iso:assert test="@code!='http://www.opengis.net/spec/owc/1.0/conf/atom/wms' or (count(owc:operation[@code='GetCapabilities'])=1 and count(owc:operation[@code='GetMap'])=1)">An offering in the entry with id="<iso:value-of select="../atom:id" /> with code http://www.opengis.net/spec/owc/1.0/conf/atom/wms" shall define a GetCapabilities and a GetMap operation.</iso:assert>
			<iso:assert test="@code!='http://www.opengis.net/spec/owc/1.0/conf/atom/wms' or count(owc:content)=0">An offering in the entry with id="<iso:value-of select="../atom:id" /> with code http://www.opengis.net/spec/owc/1.0/conf/atom/wms" shall not include inline content.</iso:assert>
			<iso:assert test="@code!='http://www.opengis.net/spec/owc/1.0/conf/atom/wmts' or (count(owc:operation[@code='GetCapabilities'])=1 and count(owc:operation[@code='GetTile'])>0)">An offering in the entry with id="<iso:value-of select="../atom:id" /> with code http://www.opengis.net/spec/owc/1.0/conf/atom/wmts" shall define a GetCapabilities and some GetTile operations.</iso:assert>
			<iso:assert test="@code!='http://www.opengis.net/spec/owc/1.0/conf/atom/wmts' or count(owc:content)=0">An offering in the entry with id="<iso:value-of select="../atom:id" /> with code http://www.opengis.net/spec/owc/1.0/conf/atom/wmts" shall not include inline content.</iso:assert>
			<iso:assert test="@code!='http://www.opengis.net/spec/owc/1.0/conf/atom/csw' or (count(owc:operation[@code='GetCapabilities'])=1 and count(owc:operation[@code='GetRecords'])=1)">An offering in the entry with id="<iso:value-of select="../atom:id" /> with code http://www.opengis.net/spec/owc/1.0/conf/atom/csw" shall define a GetCapabilities and a GetRecords operation.</iso:assert>
			<iso:assert test="@code!='http://www.opengis.net/spec/owc/1.0/conf/atom/csw' or count(owc:content)=0">An offering in the entry with id="<iso:value-of select="../atom:id" /> with code http://www.opengis.net/spec/owc/1.0/conf/atom/csw" shall not include inline content.</iso:assert>
		</iso:rule>
        <iso:rule context="owc:display">
			<iso:assert test="parent::atom:feed">An 'owc:display' shall be a child of 'feed'.</iso:assert>
		</iso:rule>		
    </iso:pattern>
</iso:schema>