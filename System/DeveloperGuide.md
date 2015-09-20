Introduction
============

This document is intended as a guide for developers who wish use the Open Charge Map API or to build the Open Charge Map (OCM) components and contribute to development. Open Charge Map is a project to create, maintain and enable an Open Data (<http://opendefinition.org/>) registry of electric vehicle charging locations globally.

The Open Charge Map system currently consists of:

-   A small backend database (MS SQL Server) augmented by a MongoDB NoSQL data store for data caching.

-   A web based API (for apps and sites to consume and update the data): C\#, ASP.Net, Entity Framework

-   An HTML5 based app (hosted on website, embedded in 3<sup>rd</sup> party sites and packaged as a mobile app on multiple app stores): HTML5, JavaScript/TypeScript, Apache Cordova

-   An ASP.Net MVC based website used for browser based access to the information for end-users (read and write) as well as admin tools.: C\#, ASP.Net MVC, Entity Framework, JavaScript.

-   Import Tools: C\#, OCM API.

-   Translation of UI elements to different language is achieved with a JSON formation resource file translated using WebTranslateIt : <https://webtranslateit.com/en/projects/6978-Open-Charge-Map>

Using the Open Charge Map API
=============================

You can use the OCM HTTP based API to request (and optionally update) EV charging equipment locations and related information. The OCM API currently returns both “Open Data” and other imported data which as licensing restrictions (related to redistributing and copyright). To request only Open Data (where an Open Data license applies to the original data source or the data originates from Open Charge Map contributors) you should include the parameter “opendata=true”. In the future we will be removing all non-open data from the system. For more information on the API and embeddable components please see: [http://openchargemap.org/site/develop\#api](http://openchargemap.org/site/develop%23api)

Contributing to Open Charge Map
===============================

If you would like to discuss how you can contribute please comment on our Google+ community: <https://plus.google.com/u/0/communities/112113799071360649945>

Improving Data
--------------

For the most part the easiest and best way to contribute to improvement of the OCM data set is to use the website or app to submit additions, edits, comments/check-ins or photos. If you have a specific interest in data clean-up please contact us to discuss different approaches. We are always interested in ideas for how best to measure and improve data quality.

Translating UI Elements
-----------------------

To contribute UI translations for any language please join our WebTranslateIt project: <https://webtranslateit.com/en/projects/6978-Open-Charge-Map>

This system provides a mature translation tool which is ideally suited to our project. Completed translations are periodically pulled down to our source code (<https://github.com/openchargemap/ocm-system/tree/master/Localisation>).

Contributing to System Development
----------------------------------

To contribute changes please create your own fork of our ocm-system repository (using the GitHub fork option) then clone it locally to do your work, then submit a pull request for merging to our master repository. You should discuss any major changes before starting work.

Sponsoring Development
----------------------

It is possible to directly sponsor relevant development, services and data clean-up etc. depending on your requirements, to do so please contact us (<http://openchargemap.org/site/about/contact>) or discuss on our Google+ community (<https://plus.google.com/u/0/communities/112113799071360649945>).

Developing the Open Charge Map system
=====================================

Source Code
-----------

The source code repositories for the Open Charge Map system components are hosted at <https://github.com/openchargemap/>

<https://guides.github.com/activities/contributing-to-open-source/#contributing>

We recommend using GitHub for Windows to clone the repository to your local development machine if you are unfamiliar with the GIT version control system command line.

Development System Setup
------------------------

### OCM Website & API Development Configuration

-   PC with Windows 7 or Higher

-   Visual Studio 2015 Express (Web)

-   NodeJS

-   MongoDB

#### Getting started with the Website and API development

-   Install Github For Windows and get a Github username

-   Fork the ocm-system repository on GitHub (this give you your own copy to work on)

-   Clone your fork of the ocm-system repository to your local computer.

-   Install Visual Studio 2015 (Community Editor is free)

-   Install SQL Express 2014 and restore database clone from file in <https://github.com/openchargemap/ocm-docs/raw/master/Database/Clone/OCM_Clone_Backup.zip> as “OCM\_Live”

-   Open OCM.Net.sln within Visual Studio and attempt build and run of Website “OCM.MVC”. If all is OK then you’re ready to start making changes.

### App Development Configuration

Our web/mobile app uses HTML and TypeScript (Javascript).

-   PC with Windows 7 or higher, or Mac with Mac OS X Yosemite or higher

-   Code editor (e.g. Visual Studio Code)

-   NodeJS

-   TypeScript

Server Configuration:
---------------------

-   SQL Express 2014

-   MongoDB configured as a service

-   NodeJS

-   MS Web Deploy

-   Endpoints:

    -   api.openchargemap.io:80

    -   www/openchargemap.org:80

-   IIS Hosted Apps:

    -   / (redirect to /site)

    -   MVC Site (/site)

    -   /app

    -   /api (redirect to api.openchargemap.io)

    -   /forum (old)

Implementation of Translations in UI
====================================

HTML elements with the attribute “data-localize” are matched against the language specific resource dictionary at run-time using the matching resource key.

E.g.: &lt;h1 data-localize=”ocm.general.sectionTitle”&gt;My Title&lt;/h1&gt;

The file OCM\_UI\_LocalisationResources.en is the master language resource file with example values given in English. Each language has a corresponding file generated via the WebTranslateIt project.

Dropdown lists can be translated by mapping their values to individual resource keys in the format “value\_&lt;list item value&gt;”, under a parent resource key.

Long text runs with mixed HTML content can be translated by marking up HTML tags with data-localize-id attributes, unique to the section being translated:

&lt;p data-localize=”ocm.infoText.example”&gt; If you operate a website and would like to include a charging location map, you can &lt;a href=”http://openchargemap.org/site/develop/” data-localize-id=”link-api”&gt;embed a map on your own website&lt;/a&gt;&lt;/p&gt;

The corresponding resource key section might look like:

"example": “If you operate a website and would like to include a charging location map, you can {link-api:embed a map on your own website}.”

System Architecture
-------------------
