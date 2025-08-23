<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" doctype-system="about:legacy-compat" indent="yes"/>

    <xsl:template match="/page">
        <html lang="en">
        <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <title><xsl:value-of select="title"/></title>
            <link rel="stylesheet" href="style.css" />
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
                    <a href="/index.xml">Home</a>
                    <a href="/posts/deep-dive-xslt.xml">XSLT Deep Dive</a>
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