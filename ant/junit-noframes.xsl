<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:string="xalan://java.lang.String">

    <!-- Output setup -->
    <xsl:output method="html" indent="yes" encoding="UTF-8"
                doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" />
    <xsl:decimal-format decimal-separator="." grouping-separator="," />

    <!-- Parameters -->
    <xsl:param name="PROJECT_NAME"/>
    <xsl:param name="TITLE"><xsl:value-of select="concat('Unit Test Results: ', $PROJECT_NAME)"/></xsl:param>

    <!-- Core Template: Matches the root testsuites element -->
    <xsl:template match="testsuites">
        <html>
            <head>
                <title><xsl:value-of select="$TITLE"/></title>
                <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

                <style type="text/css">
                    <!-- Modern Font and Body Styling -->
                    body {
                    font-family: 'Inter', 'Segoe UI', 'Helvetica Neue', Arial, sans-serif;
                    font-size: 15px;
                    color: #333333;
                    background-color: #f4f7f6; <!-- Very light, modern background -->
                    line-height: 1.6;
                    padding: 20px;
                    }

                    <!-- Container for Centering -->
                    .container {
                    max-width: 1200px;
                    margin: 0 auto;
                    padding: 20px;
                    background-color: white;
                    border-radius: 8px;
                    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
                    }

                    <!-- Headings -->
                    h1 {
                    font-size: 28px;
                    margin: 0 0 15px 0;
                    color: #1a1a1a;
                    font-weight: 600;
                    }
                    h2 {
                    font-size: 20px;
                    font-weight: 500;
                    margin-top: 2em;
                    margin-bottom: 0.8em;
                    padding-bottom: 5px;
                    border-bottom: 1px solid #e0e0e0;
                    color: #1a1a1a;
                    }
                    h3 {
                    font-size: 18px;
                    font-weight: 600;
                    margin-bottom: 1em;
                    margin-top: 1.5em;
                    color: #333333;
                    }

                    <!-- Tables (All Details and Summary) -->
                    table {
                    width: 100%;
                    margin-bottom: 1.5em;
                    border-collapse: separate;
                    border-spacing: 0 8px; <!-- Vertical spacing between rows -->
                    }

                    table.details tr th, table.summary tr th{
                    font-weight: 600;
                    text-align: left;
                    background-color: #e9ecef; <!-- Light gray header -->
                    color: #333333;
                    padding: 10px 15px;
                    border: none;
                    font-size: 14px;
                    }

                    table.details tr td, table.summary tr td{
                    background-color: #ffffff; <!-- Pure white content row -->
                    padding: 10px 15px;
                    border: none;
                    font-size: 14px;
                    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05); <!-- Subtle row separator -->
                    vertical-align: middle;
                    }

                    <!-- Status Colors (Based on Bootstrap success/danger/warning) -->
                    <!-- Note: Class name "Error" and "Failure" match the existing XSL logic -->
                    .Error td {
                    color: #dc3545; <!-- Muted Red -->
                    background-color: #fcebeb; <!-- Very light red background -->
                    font-weight: 500;
                    }
                    .Failure td {
                    color: #ffc107; <!-- Muted Amber -->
                    background-color: #fff9e6; <!-- Very light yellow background -->
                    font-weight: 500;
                    }
                    <!-- If a package/suite has no errors/failures, make it look successful -->
                    table.details tr:not([class]) td,
                    table.summary tr:not([class]) td {
                    color: #28a745; <!-- Muted Green -->
                    }

                    <!-- Monospace for Method Names -->
                    .test-name {
                    font-family: 'Consolas', 'Menlo', 'Monaco', 'Courier New', monospace;
                    font-size: 14px;
                    color: #009688; <!-- Blue for code links -->
                    font-weight: 500;
                    }

                    <!-- Exception and Code Blocks -->
                    code {
                    display: block;
                    padding: 15px;
                    margin-top: 10px;
                    background-color: #f8f9fa; <!-- Light gray block -->
                    border: 1px solid #e9ecef;
                    border-radius: 4px;
                    white-space: pre-wrap;
                    font-family: 'Consolas', 'Menlo', 'Monaco', monospace;
                    font-size: 13px;
                    color: #555;
                    }

                    <!-- Properties Link -->
                    .Properties {
                    text-align: right;
                    margin-top: -15px;
                    font-size: 14px;
                    }
                    .Properties a {
                    color: #007bff;
                    text-decoration: none;
                    }
                    .Properties a:hover {
                    text-decoration: underline;
                    }

                    <!-- Hyperlinks in general -->
                    a {
                    color: #007bff;
                    text-decoration: none;
                    }
                    a:hover {
                    text-decoration: underline;
                    }

                </style>

                <!-- JavaScript for Properties Pop-up -->
                <script type="text/javascript" language="JavaScript">
                    var TestCases = new Array();
                    var cur;
                    <xsl:for-each select="./testsuite">
                        <xsl:apply-templates select="properties"/>
                    </xsl:for-each>
                </script>

                <script type="text/javascript" language="JavaScript"><![CDATA[
        function displayProperties (name) {
          var win = window.open('','JUnitSystemProperties','scrollbars=1,resizable=1,width=700,height=500');
          var doc = win.document;
          doc.open();

          // Modernized CSS for the pop-up window
          doc.write("<html><head><title>Properties of " + name + "</title>");
          doc.write("<style>");
          doc.write("body {font-family: 'Segoe UI', Arial, sans-serif; font-size: 14px; color:#333333; padding: 20px;}");
          doc.write("table {width: 100%; border-collapse: separate; border-spacing: 0 1px; }");
          doc.write("table.properties th { text-align:left; background-color:#e9ecef; padding: 8px 12px; font-weight: 600; border: none;}");
          doc.write("table.properties td { background-color: white; padding: 8px 12px; border: 1px solid #f0f0f0; border-left: none; border-right: none;}");
          doc.write("h3 { margin-bottom: 0.5em; font-size: 18px; font-weight: 600; color: #1a1a1a;}");
          doc.write("a { color: #007bff; text-decoration: none; }");
          doc.write("</style>");
          doc.write("</head><body>");

          doc.write("<h3>Properties of " + name + "</h3>");
          doc.write("<div align=\"right\"><a href=\"javascript:window.close();\">Close [X]</a></div>");
          doc.write("<table class='properties'>");
          doc.write("<tr><th>Property Name</th><th>Value</th></tr>");
          for (prop in TestCases[name]) {
            doc.write("<tr><th>" + prop + "</th><td>" + TestCases[name][prop] + "</td></tr>");
          }
          doc.write("</table>");
          doc.write("</body></html>");
          doc.close();
          win.focus();
        }
      ]]>
                </script>
            </head>
            <body>
                <div class="container">
                    <a name="top"></a>
                    <xsl:call-template name="pageHeader"/>

                    <!-- Summary part -->
                    <xsl:call-template name="summary"/>

                    <!-- Package List part -->
                    <xsl:call-template name="packagelist"/>

                    <!-- For each package create its part -->
                    <xsl:call-template name="packages"/>

                    <!-- For each class create the part -->
                    <xsl:call-template name="classes"/>
                </div>
            </body>
        </html>
    </xsl:template>

    <!-- Page Header Template -->
    <xsl:template name="pageHeader">
        <h1><xsl:value-of select="$TITLE"/></h1>
        <table width="100%" style="font-size: 13px; color: #555;">
            <tr>
                <td align="left"></td>
                <td align="right">Report generated using XSLT for <a href='https://www.junit.org'>JUnit</a> and <a href='https://ant.apache.org/ant'>Ant</a>.</td>
            </tr>
        </table>
        <hr style="border: 0; height: 1px; background-color: #ddd; margin: 15px 0;"/>
    </xsl:template>

    <!-- Summary Template -->
    <xsl:template name="summary">
        <h2>Summary</h2>
        <xsl:variable name="testCount" select="sum(testsuite/@tests)"/>
        <xsl:variable name="errorCount" select="sum(testsuite/@errors)"/>
        <xsl:variable name="failureCount" select="sum(testsuite/@failures)"/>
        <xsl:variable name="skippedCount" select="sum(testsuite/@skipped)" />
        <xsl:variable name="timeCount" select="sum(testsuite/@time)"/>
        <xsl:variable name="successRate" select="($testCount - $failureCount - $errorCount) div $testCount"/>

        <table class="summary" border="0" cellpadding="0" cellspacing="0">
            <tr valign="top">
                <th>Tests</th>
                <th>Failures</th>
                <th>Errors</th>
                <th>Skipped</th>
                <th>Success Rate</th>
                <th nowrap="nowrap">Total Time(s)</th>
            </tr>
            <tr valign="top">
                <xsl:attribute name="class">
                    <xsl:choose>
                        <xsl:when test="$failureCount &gt; 0">Failure</xsl:when>
                        <xsl:when test="$errorCount &gt; 0">Error</xsl:when>
                    </xsl:choose>
                </xsl:attribute>
                <td><xsl:value-of select="$testCount"/></td>
                <td><xsl:value-of select="$failureCount"/></td>
                <td><xsl:value-of select="$errorCount"/></td>
                <td><xsl:value-of select="$skippedCount" /></td>
                <td>
                    <xsl:call-template name="display-percent">
                        <xsl:with-param name="value" select="$successRate"/>
                    </xsl:call-template>
                </td>
                <td>
                    <xsl:call-template name="display-time">
                        <xsl:with-param name="value" select="$timeCount"/>
                    </xsl:call-template>
                </td>
            </tr>
        </table>
        <table border="0" width="100%" style="font-size: 13px; color: #555; margin-top: 10px;">
            <tr>
                <td style="text-align: justify;">
                    Note: <i>failures</i> are anticipated and checked for with assertions while <i>errors</i> are unanticipated.
                </td>
            </tr>
        </table>
    </xsl:template>

    <!-- Package List Template (Index) -->
    <xsl:template name="packagelist">
        <h2>Packages</h2>
        <p style="font-size: 13px; color: #555; margin-bottom: 20px;">
            Note: package statistics are not computed recursively, they only sum up all of its testsuites numbers.
        </p>
        <table class="details" border="0" cellpadding="0" cellspacing="0">
            <xsl:call-template name="testsuite.test.header"/>

            <!-- list all packages recursively -->
            <xsl:for-each select="/testsuites/testsuite[not(./@package = preceding-sibling::testsuite/@package)]">
                <xsl:sort select="@package"/>
                <xsl:variable name="testsuites-in-package" select="/testsuites/testsuite[./@package = current()/@package]"/>
                <xsl:variable name="testCount" select="sum($testsuites-in-package/@tests)"/>
                <xsl:variable name="errorCount" select="sum($testsuites-in-package/@errors)"/>
                <xsl:variable name="failureCount" select="sum($testsuites-in-package/@failures)"/>
                <xsl:variable name="skippedCount" select="sum($testsuites-in-package/@skipped)" />
                <xsl:variable name="timeCount" select="sum($testsuites-in-package/@time)"/>

                <!-- write a summary for the package -->
                <tr valign="top">
                    <!-- set a nice color depending if there is an error/failure -->
                    <xsl:attribute name="class">
                        <xsl:choose>
                            <xsl:when test="$failureCount &gt; 0">Failure</xsl:when>
                            <xsl:when test="$errorCount &gt; 0">Error</xsl:when>
                        </xsl:choose>
                    </xsl:attribute>
                    <td>
                        <xsl:choose>
                            <xsl:when test="@package != ''">
                                <a href="#{@package}"><xsl:value-of select="@package"/></a>
                            </xsl:when>
                            <xsl:otherwise>
                                <a href="#default-package">default</a>
                            </xsl:otherwise>
                        </xsl:choose>
                    </td>
                    <td><xsl:value-of select="$testCount"/></td>
                    <td><xsl:value-of select="$errorCount"/></td>
                    <td><xsl:value-of select="$failureCount"/></td>
                    <td><xsl:value-of select="$skippedCount" /></td>
                    <td>
                        <xsl:call-template name="display-time">
                            <xsl:with-param name="value" select="$timeCount"/>
                        </xsl:call-template>
                    </td>
                    <td><xsl:value-of select="$testsuites-in-package[1]/@timestamp"/></td>
                    <td><xsl:value-of select="$testsuites-in-package[1]/@hostname"/></td>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>


    <!-- Package Report Details -->
    <xsl:template name="packages">
        <xsl:for-each select="/testsuites/testsuite[not(./@package = preceding-sibling::testsuite/@package)]">
            <xsl:sort select="@package"/>
            <xsl:choose>
                <xsl:when test="@package != ''">
                    <a name="{@package}"/>
                </xsl:when>
                <xsl:otherwise>
                    <a name="default-package"/>
                </xsl:otherwise>
            </xsl:choose>
            <h3>Package <xsl:choose><xsl:when test="@package != ''"><xsl:value-of select="@package"/></xsl:when><xsl:otherwise>default</xsl:otherwise></xsl:choose></h3>

            <table class="details" border="0" cellpadding="0" cellspacing="0">
                <xsl:call-template name="testsuite.test.header"/>

                <!-- match the testsuites of this package -->
                <xsl:apply-templates select="/testsuites/testsuite[./@package = current()/@package]" mode="print.test"/>
            </table>
            <div style="text-align: right; margin-bottom: 25px;">
                <a href="#top">Back to top &#x25B2;</a>
            </div>
        </xsl:for-each>
    </xsl:template>

    <!-- Class/Testcase Report Details -->
    <xsl:template name="classes">
        <xsl:for-each select="testsuite">
            <xsl:sort select="@name"/>
            <!-- create an anchor to this class name -->
            <a name="{@name}"></a>
            <h3>TestCase <xsl:value-of select="@name"/></h3>

            <table class="details" border="0" cellpadding="0" cellspacing="0">
                <xsl:call-template name="testcase.test.header"/>
                <!--
                test can even not be started at all (failure to load the class)
                so report the error directly
                -->
                <xsl:if test="./error">
                    <tr class="Error">
                        <td colspan="4"><xsl:apply-templates select="./error"/></td>
                    </tr>
                </xsl:if>
                <xsl:apply-templates select="./testcase" mode="print.test"/>
            </table>
            <div class="Properties">
                <a>
                    <xsl:attribute name="href">javascript:displayProperties('<xsl:value-of select="@package"/>.<xsl:value-of select="@name"/>');</xsl:attribute>
                    System Properties &#187;
                </a>
            </div>

            <div style="text-align: right; margin-bottom: 25px;">
                <a href="#top">Back to top &#x25B2;</a>
            </div>
        </xsl:for-each>
    </xsl:template>

    <!-- Write properties into a JavaScript data structure. -->
    <xsl:template match="properties">
        cur = TestCases['<xsl:value-of select="../@package"/>.<xsl:value-of select="../@name"/>'] = new Array();
        <xsl:for-each select="property">
            <xsl:sort select="@name"/>
            cur['<xsl:value-of select="@name"/>'] = '<xsl:call-template name="JS-escape"><xsl:with-param name="string" select="@value"/></xsl:call-template>';
        </xsl:for-each>
    </xsl:template>

    <!-- Class/Suite Header -->
    <xsl:template name="testsuite.test.header">
        <tr valign="top">
            <th width="50%">Name</th>
            <th>Tests</th>
            <th>Errors</th>
            <th>Failures</th>
            <th>Skipped</th>
            <th nowrap="nowrap">Time(s)</th>
            <th nowrap="nowrap">Timestamp</th>
            <th>Host</th>
        </tr>
    </xsl:template>

    <!-- Testcase Header -->
    <xsl:template name="testcase.test.header">
        <tr valign="top">
            <th width="40%">Test Name</th>
            <th width="10%">Status</th>
            <th width="40%">Detail / Exception Type</th>
            <th nowrap="nowrap">Time(s)</th>
        </tr>
    </xsl:template>

    <!-- Class/Suite Information Row -->
    <xsl:template match="testsuite" mode="print.test">
        <tr valign="top">
            <!-- set a nice color depending if there is an error/failure -->
            <xsl:attribute name="class">
                <xsl:choose>
                    <xsl:when test="@failures[.&gt; 0]">Failure</xsl:when>
                    <xsl:when test="@errors[.&gt; 0]">Error</xsl:when>
                </xsl:choose>
            </xsl:attribute>

            <!-- print testsuite information -->
            <td><a href="#{@name}"><xsl:value-of select="@name"/></a></td>
            <td><xsl:value-of select="@tests"/></td>
            <td><xsl:value-of select="@errors"/></td>
            <td><xsl:value-of select="@failures"/></td>
            <td><xsl:value-of select="@skipped" /></td>
            <td>
                <xsl:call-template name="display-time">
                    <xsl:with-param name="value" select="@time"/>
                </xsl:call-template>
            </td>
            <td><xsl:apply-templates select="@timestamp"/></td>
            <td><xsl:apply-templates select="@hostname"/></td>
        </tr>
    </xsl:template>

    <!-- Testcase Information Row -->
    <xsl:template match="testcase" mode="print.test">
        <tr valign="top">
            <xsl:attribute name="class">
                <xsl:choose>
                    <xsl:when test="failure">Failure</xsl:when>
                    <xsl:when test="error">Error</xsl:when>
                </xsl:choose>
            </xsl:attribute>
            <!-- Test Name (Monospace) -->
            <td><span class="test-name"><xsl:value-of select="@name"/></span></td>

            <xsl:choose>
                <xsl:when test="failure">
                    <td style="font-weight: bold;">Failure</td>
                    <td><xsl:apply-templates select="failure"/></td>
                </xsl:when>
                <xsl:when test="error">
                    <td style="font-weight: bold;">Error</td>
                    <td><xsl:apply-templates select="error"/></td>
                </xsl:when>
                <xsl:when test="skipped">
                    <td>Skipped</td>
                    <td><xsl:apply-templates select="skipped"/></td>
                </xsl:when>
                <xsl:otherwise>
                    <td class="StatusSuccess">Success</td>
                    <td></td>
                </xsl:otherwise>
            </xsl:choose>
            <td>
                <xsl:call-template name="display-time">
                    <xsl:with-param name="value" select="@time"/>
                </xsl:call-template>
            </td>
        </tr>
    </xsl:template>

    <!-- Failure/Error/Skipped Details -->
    <xsl:template match="failure">
        <xsl:call-template name="display-failures"/>
    </xsl:template>

    <xsl:template match="error">
        <xsl:call-template name="display-failures"/>
    </xsl:template>

    <xsl:template match="skipped">
        <xsl:call-template name="display-failures"/>
    </xsl:template>

    <!-- Style for the error, failure and skipped in the testcase template -->
    <xsl:template name="display-failures">
        <span style="font-weight: 600;">
            <xsl:choose>
                <xsl:when test="not(@message)">
                    N/A (No Message)
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="@message"/>
                </xsl:otherwise>
            </xsl:choose>
        </span>
        <!-- display the stacktrace -->
        <code>
            <xsl:call-template name="br-replace">
                <xsl:with-param name="word" select="."/>
            </xsl:call-template>
        </code>
    </xsl:template>

    <!-- Escape JavaScript strings for property values -->
    <xsl:template name="JS-escape">
        <xsl:param name="string"/>
        <xsl:param name="tmp1" select="string:replaceAll(string:new(string($string)),'\\','\\\\')"/>
        <xsl:param name="tmp2" select="string:replaceAll(string:new(string($tmp1)),&quot;'&quot;,&quot;\\&apos;&quot;)"/>
        <xsl:param name="tmp3" select="string:replaceAll(string:new(string($tmp2)),&quot;&#10;&quot;,'\\n')"/>
        <xsl:param name="tmp4" select="string:replaceAll(string:new(string($tmp3)),&quot;&#13;&quot;,'\\r')"/>
        <xsl:value-of select="$tmp4"/>
    </xsl:template>


    <!-- Template to replace carriage returns with <br/> tags in stack traces -->
    <xsl:template name="br-replace">
        <xsl:param name="word"/>
        <xsl:param name="splitlimit">32</xsl:param>
        <xsl:variable name="secondhalfstartindex" select="(string-length($word)+(string-length($word) mod 2)) div 2"/>
        <xsl:variable name="secondhalfword" select="substring($word, $secondhalfstartindex)"/>
        <!-- When word is very big, a recursive replace is very heap/stack expensive, so subdivide on line break after middle of string -->
        <xsl:choose>
            <xsl:when test="(string-length($word) > $splitlimit) and (contains($secondhalfword, '&#xa;'))">
                <xsl:variable name="secondhalfend" select="substring-after($secondhalfword, '&#xa;')"/>
                <xsl:variable name="firsthalflen" select="string-length($word) - string-length($secondhalfword)"/>
                <xsl:variable name="firsthalfword" select="substring($word, 1, $firsthalflen)"/>
                <xsl:variable name="firsthalfend" select="substring-before($secondhalfword, '&#xa;')"/>
                <xsl:call-template name="br-replace">
                    <xsl:with-param name="word" select="concat($firsthalfword,$firsthalfend)"/>
                </xsl:call-template>
                <br/>
                <xsl:call-template name="br-replace">
                    <xsl:with-param name="word" select="$secondhalfend"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="contains($word, '&#xa;')">
                <xsl:value-of select="substring-before($word, '&#xa;')"/>
                <br/>
                <xsl:call-template name="br-replace">
                    <xsl:with-param name="word" select="substring-after($word, '&#xa;')"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$word"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Formatting Templates -->
    <xsl:template name="display-time">
        <xsl:param name="value"/>
        <xsl:value-of select="format-number($value,'0.000')"/>
    </xsl:template>

    <xsl:template name="display-percent">
        <xsl:param name="value"/>
        <xsl:value-of select="format-number($value,'0.00%')"/>
    </xsl:template>

</xsl:stylesheet>
