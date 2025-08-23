<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" doctype-system="about:legacy-compat" indent="yes"/>

    <xsl:variable name="currentPath">
        <xsl:value-of select="substring-before(substring-after(processing-instruction('xml-stylesheet'), 'href=&quot;'), '&quot;')"/>
    </xsl:variable>

    <xsl:template match="/page">
        <html lang="en">
        <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <title><xsl:value-of select="title"/></title>
            <link rel="stylesheet" href="style.css" />
            <xsl:if test="contains($currentPath, '../')">
                <link rel="stylesheet" href="../style.css" />
            </xsl:if>
            <link rel="preconnect" href="https://fonts.googleapis.com" />
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous" />
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&amp;family=Source+Code+Pro:wght@400;600&amp;display=swap" rel="stylesheet" />
        </head>
        <body>
            <header>
                <div class="header-content">
                    <xsl:copy-of select="headerContent/node()"/>
                </div>
                <nav>
                    <a href="/index.xml">
                        <xsl:if test="not(contains($currentPath, '../'))">
                            <xsl:attribute name="class">active</xsl:attribute>
                        </xsl:if>
                        Home
                    </a>
                    <a href="/posts/deep-dive-xslt.xml">
                        <xsl:if test="contains($currentPath, '../')">
                            <xsl:attribute name="class">active</xsl:attribute>
                        </xsl:if>
                        XSLT Deep Dive
                    </a>
                </nav>
            </header>

            <main>
                <xsl:copy-of select="mainContent/node()"/>
            </main>

            <footer>
                <xsl:copy-of select="footerContent/node()"/>
            </footer>

        </body>
        </html>
    </xsl:template>

</xsl:stylesheet>