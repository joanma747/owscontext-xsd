<?xml version="1.0" encoding="UTF-8"?>
<iso:schema
	xmlns:iso="http://purl.oclc.org/dsdl/schematron"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	schemaVersion="ISO19757-3" >
    <iso:title>Schematron validation for atom</iso:title>
    <iso:ns prefix="atom" uri="http://www.w3.org/2005/Atom"/>   
    <iso:pattern name="atom validation" id="atom">
        <!-- ATOM rules from RFC4287: -->    
		<iso:rule context="/">
			  <iso:assert test="atom:feed">Root element shall be 'feed'.</iso:assert>
		</iso:rule>
        <iso:rule context="atom:feed">
            <!-- ATOM rules from RFC4287: -->
            <iso:assert test="count(atom:icon)&lt;2">ATOM rule: Only one element 'icon' is allowed in a 'feed'</iso:assert>
            <iso:assert test="count(atom:logo)&lt;2">ATOM rule: Only one element 'logo' is allowed in a 'feed'</iso:assert>
            <iso:assert test="count(atom:id)=1">ATOM rule: Element 'id' is mandatory for a 'feed'. Only one 'id' is allowed</iso:assert>
            <iso:assert test="count(atom:title)=1">ATOM rule: Element 'title' is mandatory for a 'feed'. Only one 'title' is allowed</iso:assert>
            <iso:assert test="count(atom:subtitle)&lt;2">ATOM rule: Only one element 'subtitle' is allowed in a OWSContext 'feed'</iso:assert>
            <iso:assert test="count(atom:updated)=1">ATOM rule: Only one element 'updated' is allowed in a OWSContext 'feed'</iso:assert>
            <iso:assert test="count(atom:generator)&lt;2">ATOM rule: Only one element 'generator' is allowed in a 'feed'</iso:assert>
            <iso:assert test="count(atom:rights)&lt;2">ATOM rule: Only one element 'rights' is allowed in a 'feed'</iso:assert>
			<iso:assert test="atom:author or not(atom:entry[not(atom:author)])">ATOM rule: An atom:feed must have an atom:author unless all of its atom:entry children have an atom:author.</iso:assert>
        </iso:rule>
        <iso:rule context="atom:entry">
            <!-- ATOM rules from RFC4287: -->
            <iso:assert test="atom:link[@rel='alternate'] or atom:link[not(@rel)] or atom:content">ATOM rule: The entry with id="<iso:value-of select="atom:id" />" must have at least one atom:link element with a rel attribute of 'alternate' or an atom:content.</iso:assert>
            <iso:assert test="atom:author or ../atom:author or atom:source/atom:author">ATOM rule: The entry with id="<iso:value-of select="atom:id" />" must have an atom:author if its feed does not.</iso:assert>
            <iso:assert test="count(atom:published)&lt;2">ATOM rule: The entry with id="<iso:value-of select="atom:id" />" can only have one element 'published'.</iso:assert>
            <iso:assert test="count(atom:source)&lt;2">ATOM rule: The entry with id="<iso:value-of select="atom:id" />" can only have one element 'source'.</iso:assert>
            <iso:assert test="not(atom:content) or (atom:content[@src] and not(atom:content[text()])) or not(atom:content[@src])">ATOM rule: If the 'src' attribute is present, 'content' be empty in entry with id="<iso:value-of select="atom:id" />".</iso:assert>
            <iso:assert test="not(atom:content) or not(atom:content[@src]) or atom:summary">ATOM rule: In entry with id="<iso:value-of select="atom:id" />", 'summary' is mandatory if the entry contains a 'content' that has a 'src' attribute.</iso:assert>
            <iso:assert test="not(atom:content) or not(atom:content[@type]) or not(contains(atom:content/@type,'/')) or substring(atom:content/@type,1,5)='text/' or (string-length(atom:content/@type)&gt;5 and (substring(atom:content/@type,string-length(atom:content/@type)-3,4)='/xml' or substring(atom:content/@type,string-length(atom:content/@type)-3,4)='+xml')) or atom:summary">ATOM rule: In entry with id="<iso:value-of select="atom:id" />", 'summary' is mandatory if the entry contains content that is encoded in Base64; i.e., the 'type' attribute of the 'content' is a MIME media type, but is not an XML media type, does not begin with "text/", and does not end with "/xml" or "+xml".</iso:assert>
			<iso:assert test="count(atom:content)&lt;2">ATOM rule: The entry with id="<iso:value-of select="atom:id" />" can only have one element 'content'. In OWS Context you can use 'AlternateContent' for more 'content'</iso:assert>
            <iso:assert test="count(atom:id)=1">ATOM rule: Element 'id' is mandatory for an 'entry'. Only one 'id' is allowed</iso:assert>
            <iso:assert test="count(atom:title)=1">ATOM rule: Element 'title' is mandatory for an 'entry'. Only one 'title' is allowed in the entry with id="<iso:value-of select="atom:id" />".</iso:assert>
            <iso:assert test="count(atom:updated)=1">ATOM rule: Element 'updated' is mandatory for an 'entry'. Only one 'updated' is allowed in the entry with id="<iso:value-of select="atom:id" />".</iso:assert>
            <iso:assert test="count(atom:summary)&lt;2">ATOM rule: The entry with id="<iso:value-of select="atom:id" />" can only have one element '.</iso:assert>
            <iso:assert test="count(atom:rights)&lt;2">ATOM rule: The entry with id="<iso:value-of select="atom:id" />" can only have one element 'rights'.</iso:assert>
            <iso:report test="atom:link[@rel='enclosure'] and not(atom:link[@rel='enclosure']/@length)">ATOM NOTE: A 'length' attribute is recommended for an contentByRef (atom:link with 'rel' attribute = "enclosure"] ) in the entry with id="<iso:value-of select="atom:id" />".</iso:report>
			<iso:report test="atom:link[@rel='enclosure'] and not(atom:link[@rel='enclosure']/@type)">ATOM NOTE: A 'type' attribute is recommended for an contentByRef (atom:link with 'rel' attribute = "enclosure"] ) in the entry with id="<iso:value-of select="atom:id" />".</iso:report>           
        </iso:rule>        
        <iso:rule context="atom:feed/atom:author">
            <iso:assert test="count(atom:name)=1">ATOM rule: Element 'name' is mandatory in the 'author' of the 'feed'. Only one 'name' is allowed.</iso:assert>
            <iso:assert test="count(atom:uri)&lt;2">ATOM rule: Only one element 'uri' is allowed in a 'feed'</iso:assert>
            <iso:assert test="count(atom:email)&lt;2">ATOM rule: Only one element 'email' is allowed in a 'feed'</iso:assert>
        </iso:rule>
        <iso:rule context="atom:entry/atom:author">
            <iso:assert test="count(atom:name)=1">ATOM rule: Element 'name' is mandatory in the 'author' in the entry with id="<iso:value-of select="../atom:id" />". Only one 'name' is allowed.</iso:assert>
            <iso:assert test="count(atom:uri)&lt;2">ATOM rule: Only one element 'uri' is allowed in the entry with id="<iso:value-of select="../atom:id" />.</iso:assert>
            <iso:assert test="count(atom:email)&lt;2">ATOM rule: Only one element 'email' is allowed in the entry with id="<iso:value-of select="../atom:id" />.</iso:assert>
        </iso:rule>
    </iso:pattern>
</iso:schema>