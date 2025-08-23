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
            <div id="loader">
                <div class="spinner"></div>
            </div>

            <header>
                <div class="header-content">
                    <xsl:copy-of select="headerContent/node()"/>
                </div>
                <nav>
                    <a href="/index.xml">
                        <xsl:if test="not(contains($currentPath, '../')) and not(@type)">
                            <xsl:attribute name="class">active</xsl:attribute>
                        </xsl:if>
                        Home
                    </a>
                    <a href="/posts/index.xml">
                        <xsl:if test="@type='post-index' or @type='post'">
                            <xsl:attribute name="class">active</xsl:attribute>
                        </xsl:if>
                        Posts
                    </a>
                    <a href="/about.xml">
                        <xsl:if test="@type='about'">
                            <xsl:attribute name="class">active</xsl:attribute>
                        </xsl:if>
                        About
                    </a>
                </nav>
            </header>

            <main>
                <xsl:choose>
                    <xsl:when test="@type='post-index'">
                        <xsl:apply-templates select="mainContent" mode="post-index"/>
                    </xsl:when>
                    <xsl:when test="@type='post'">
                        <xsl:apply-templates select="mainContent" mode="post"/>
                    </xsl:when>
                    <xsl:when test="@type='about'">
                        <xsl:apply-templates select="mainContent" mode="about"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:copy-of select="mainContent/node()"/>
                    </xsl:otherwise>
                </xsl:choose>
            </main>

            <footer>
                <xsl:copy-of select="footerContent/node()"/>
            </footer>

        </body>
        </html>
    </xsl:template>

    <!-- Post index template -->
    <xsl:template match="mainContent" mode="post-index">
        <xsl:copy-of select="section[@id='posts-list']/h2"/>
        <div class="posts-grid">
            <xsl:for-each select="section[@id='posts-list']/postsList/post">
                <xsl:sort select="date" order="descending"/>
                <article class="post-card">
                    <div class="post-card-header">
                        <h3><a href="{url}"><xsl:value-of select="title"/></a></h3>
                        <div class="post-meta">
                            <time><xsl:value-of select="date"/></time>
                            <span class="category"><xsl:value-of select="category"/></span>
                        </div>
                    </div>
                    <p class="post-description"><xsl:value-of select="description"/></p>
                    <div class="post-tags">
                        <xsl:for-each select="tags/tag">
                            <span class="tag"><xsl:value-of select="."/></span>
                        </xsl:for-each>
                    </div>
                </article>
            </xsl:for-each>
        </div>
    </xsl:template>

    <!-- Post template -->
    <xsl:template match="mainContent" mode="post">
        <xsl:copy-of select="article/div[@class='post-meta']"/>
        <xsl:apply-templates select="article/section"/>
        
        <!-- Process special content types -->
        <xsl:if test="article/exampleData">
            <xsl:apply-templates select="article/exampleData"/>
        </xsl:if>
        <xsl:if test="article/dataTable">
            <xsl:apply-templates select="article/dataTable"/>
        </xsl:if>
        <xsl:if test="article/taxonomy">
            <xsl:apply-templates select="article/taxonomy"/>
        </xsl:if>
        <xsl:if test="article/mixedContent">
            <xsl:apply-templates select="article/mixedContent"/>
        </xsl:if>
    </xsl:template>

    <!-- About page template -->
    <xsl:template match="mainContent" mode="about">
        <xsl:apply-templates select="section"/>
    </xsl:template>

    <!-- Special content processors -->
    <xsl:template match="exampleData">
        <div class="example-data">
            <h3>JavaScript Libraries Comparison</h3>
            <div class="libraries-grid">
                <xsl:for-each select="libraries/library">
                    <xsl:sort select="@popularity" order="descending" data-type="number"/>
                    <div class="library-card">
                        <h4><xsl:value-of select="@name"/></h4>
                        <p>Type: <xsl:value-of select="@type"/></p>
                        <p>Since: <xsl:value-of select="@year"/></p>
                        <div class="popularity">
                            <xsl:choose>
                                <xsl:when test="@popularity &gt;= 9">
                                    <span class="popularity-bar high" style="width: {@popularity * 10}%"></span>
                                </xsl:when>
                                <xsl:when test="@popularity &gt;= 7">
                                    <span class="popularity-bar medium" style="width: {@popularity * 10}%"></span>
                                </xsl:when>
                                <xsl:otherwise>
                                    <span class="popularity-bar low" style="width: {@popularity * 10}%"></span>
                                </xsl:otherwise>
                            </xsl:choose>
                            <span class="popularity-value"><xsl:value-of select="@popularity"/>/10</span>
                        </div>
                    </div>
                </xsl:for-each>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="dataTable">
        <div class="data-table-container">
            <xsl:for-each select="table">
                <table class="data-table">
                    <thead>
                        <tr>
                            <xsl:for-each select="headers/header">
                                <th><xsl:value-of select="."/></th>
                            </xsl:for-each>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each select="rows/row">
                            <tr>
                                <xsl:for-each select="cell">
                                    <td>
                                        <xsl:if test="@status">
                                            <xsl:attribute name="class">status-<xsl:value-of select="@status"/></xsl:attribute>
                                        </xsl:if>
                                        <xsl:value-of select="."/>
                                    </td>
                                </xsl:for-each>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
            </xsl:for-each>
        </div>
    </xsl:template>

    <xsl:template match="taxonomy">
        <div class="taxonomy-tree">
            <xsl:for-each select="category">
                <div class="taxonomy-category">
                    <h3><xsl:value-of select="@name"/></h3>
                    <xsl:for-each select="subcategory">
                        <div class="taxonomy-subcategory">
                            <h4><xsl:value-of select="@name"/></h4>
                            <ul class="taxonomy-items">
                                <xsl:for-each select="item">
                                    <li class="popularity-{@popularity}">
                                        <xsl:value-of select="."/>
                                        <span class="popularity-indicator"><xsl:value-of select="@popularity"/></span>
                                    </li>
                                </xsl:for-each>
                            </ul>
                        </div>
                    </xsl:for-each>
                </div>
            </xsl:for-each>
        </div>
    </xsl:template>

    <xsl:template match="mixedContent">
        <div class="mixed-content">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="mixedContent/paragraph">
        <p><xsl:apply-templates/></p>
    </xsl:template>

    <xsl:template match="emphasis">
        <em><xsl:value-of select="."/></em>
    </xsl:template>

    <xsl:template match="mixedContent/codeBlock">
        <pre><code class="language-{@language}"><xsl:value-of select="."/></code></pre>
    </xsl:template>

    <xsl:template match="mixedContent/list">
        <xsl:choose>
            <xsl:when test="@type='ordered'">
                <ol><xsl:apply-templates select="item"/></ol>
            </xsl:when>
            <xsl:otherwise>
                <ul><xsl:apply-templates select="item"/></ul>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="mixedContent/list/item">
        <li>
            <xsl:apply-templates/>
            <xsl:if test="sublist">
                <ul><xsl:apply-templates select="sublist/item"/></ul>
            </xsl:if>
        </li>
    </xsl:template>

    <xsl:template match="link">
        <a href="{@href}"><xsl:value-of select="."/></a>
    </xsl:template>

    <!-- About page special templates -->
    <xsl:template match="principlesList">
        <div class="principles-grid">
            <xsl:for-each select="principle">
                <div class="principle-card">
                    <div class="principle-icon"><xsl:value-of select="@icon"/></div>
                    <h3><xsl:value-of select="@title"/></h3>
                    <p><xsl:value-of select="."/></p>
                </div>
            </xsl:for-each>
        </div>
    </xsl:template>

    <xsl:template match="architectureComponents">
        <div class="architecture-components">
            <xsl:for-each select="component">
                <div class="component-card">
                    <h3><xsl:value-of select="@name"/></h3>
                    <p><xsl:value-of select="description"/></p>
                    <xsl:if test="examples">
                        <h4>Examples:</h4>
                        <ul>
                            <xsl:for-each select="examples/example">
                                <li><xsl:value-of select="."/></li>
                            </xsl:for-each>
                        </ul>
                    </xsl:if>
                    <xsl:if test="features">
                        <h4>Features:</h4>
                        <ul>
                            <xsl:for-each select="features/feature">
                                <li><xsl:value-of select="."/></li>
                            </xsl:for-each>
                        </ul>
                    </xsl:if>
                </div>
            </xsl:for-each>
        </div>
    </xsl:template>

    <xsl:template match="capabilitiesList">
        <div class="capabilities-list">
            <xsl:for-each select="capability">
                <div class="capability-section">
                    <h3><xsl:value-of select="@category"/></h3>
                    <ul>
                        <xsl:for-each select="item">
                            <li><xsl:value-of select="."/></li>
                        </xsl:for-each>
                    </ul>
                </div>
            </xsl:for-each>
        </div>
    </xsl:template>

    <!-- Generic section handler -->
    <xsl:template match="section">
        <section>
            <xsl:if test="@id">
                <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
            </xsl:if>
            <xsl:copy-of select="node()"/>
        </section>
    </xsl:template>

</xsl:stylesheet>