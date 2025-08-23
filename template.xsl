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
            <script type="importmap">
              {
                "imports": {
                  "highlight.js": "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/es/highlight.min.js",
                  "highlight.js/lib/languages/xml": "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/es/languages/xml.min.js",
                  "highlight.js/lib/languages/css": "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/es/languages/css.min.js",
                  "highlight.js/lib/languages/bash": "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/es/languages/bash.min.js"
                }
              }
            </script>
            <link id="hljs-light-theme" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/styles/github.min.css" media="(prefers-color-scheme: light)" />
            <link id="hljs-dark-theme" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/styles/github-dark.min.css" media="(prefers-color-scheme: dark)" disabled="true" />
        </head>
        <body>
            <header>
                <div class="header-content">
                    <xsl:copy-of select="headerContent/node()"/>
                </div>
                <button id="theme-toggle" aria-label="Toggle dark mode">
                     <img src="toggle-icon.png" alt="Theme toggle icon"/>
                </button>
            </header>

            <main>
                <xsl:copy-of select="mainContent/node()"/>
            </main>

            <footer>
                <xsl:copy-of select="footerContent/node()"/>
            </footer>

            <script type="module" src="script.js"></script>
        </body>
        </html>
    </xsl:template>

</xsl:stylesheet>