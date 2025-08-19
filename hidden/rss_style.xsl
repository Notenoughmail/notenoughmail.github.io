---
layout: none
---
<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:atom="http://www.w3.org/2005/Atom">
    <xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes" />
    <xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml" lang="en">
            <head>
                <title><xsl:value-of select="rss/channel/title" /></title>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8"></meta>
                <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"></meta>
                <link rel="stylesheet" href="/assets/css/just-the-docs-default.css" />
                <link rel="stylesheet" href="/assets/css/just-the-docs-head-nav.css" id="jtd-head-nav-stylesheet" />
                <style id="jtd-nav-activation">
                .site-nav ul li a {
                  background-image: none;
                }
                </style>
                <style>
                span.post-date i {
                    float: right;
                }
                @media (min-width: 50rem) {
                    .main {
                        max-width: 40rem;
                    }
                }
                .main-content ul > li.post-item::before {
                    content: ">";
                }
                </style>
                <script src="/assets/js/vendor/lunr.min.js"></script>
                <script src="/assets/js/just-the-docs.js"></script>
                <link rel="icon" href="/assets/favicon.ico" type="image/x-icon" />
                {% include head_custom.html %}
            </head>
            <body>
                <div class="side-bar">
                    <div class="site-header" role="banner">
                        <a href="/" class="site-title lh-tight">{% include title.html %}</a>
                        {% comment %}
                        Typicaly, there would be a menu button here for mobile, but the xml doesn't play nice with the svg
                        {% endcomment %} 
                    </div>
                    <nav id="site-nav" class="site-nav" aria-label="Main">
                        <ul class="nav-list">
                            {% assign topPages = site.pages | where: "top", "true" | sort: "title" %}
                            {% for page in topPages %}
                                <li class="nav-list-item"><a class="nav-list-link" href="{{ page.url }}">{{ page.title | xml_escape }}</a></li>
                            {% endfor %}
                        </ul>
                    </nav>
                    {% include nav_footer_custom.html %}
                </div>
                <div class="main" id="top">
                    <div class="main-header" id="main-headr">{% include components/aux_nav.html %}</div>
                    <div class="main-content-wrap"><div id="main-content" class="main-content">
                        <main>
                            <h1 class="page-title"><xsl:value-of select="/rss/channel/title" /></h1>
                            <div>
                                <p><xsl:value-of select="/rss/channel/description" /></p>
                                <ul>
                                    <xsl:for-each select="/rss/channel/item">
                                        <li class="post-item">
                                            <a class="post-title" href="{guid}"><span><xsl:value-of select="title" /></span></a>
                                            <span class="post-date"><i><xsl:value-of select="simpleDate" /></i></span>
                                        </li>
                                    </xsl:for-each>
                                </ul>
                                <p><xsl:value-of select="/rss/channel/bottom" /></p>
                            </div>
                            <i>This page is made possible by XSLT!</i>
                        </main>
                        {% include components/footer.html %}
                    </div></div>
                    {% include components/search_footer.html %}
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>