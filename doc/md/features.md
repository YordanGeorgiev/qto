#  ISSUE TRACKER FEATURES, FUNCTIONALITIES AND CAPABILITIES
* [1. INTRODUCTION](#1-introduction)
  * [1.1. PURPOSE](#11-purpose)
  * [1.2. DOCUMENT STATUS](#12-document-status)
  * [1.3. AUDIENCE](#13-audience)
  * [1.4. MASTER STORAGE AND STORAGE FORMAT](#14-master-storage-and-storage-format)
  * [1.5. VERSION CONTROL](#15-version-control)
  * [1.6. PROCESS](#16-process)
* [2. UI FEATURES](#2-ui-features)
  * [2.1. SUPPORT FOR DIFFERENT PROJECTS](#21-support-for-different-projects)
    * [2.1.1. Change projects via url](#211-change-projects-via-url)
    * [2.1.2. Switch projects by the :to operator in the search-box](#212-switch-projects-by-the-to-operator-in-the-search-box)
    * [2.1.3. Switch items by using the :for operator in the search-box](#213-switch-items-by-using-the-for-operator-in-the-search-box)
  * [2.2. THE LIST PAGE](#22-the-list-page)
    * [2.2.1. Listing url syntax](#221-listing-url-syntax)
      * [2.2.1.1. Successful execution](#2211-successful-execution)
      * [2.2.1.2. Error handling for non-existent db](#2212-error-handling-for-non-existent-db)
      * [2.2.1.3. Error handling for non-existent table](#2213-error-handling-for-non-existent-table)
      * [2.2.1.4. Error handling for non-existent column](#2214-error-handling-for-non-existent-column)
    * [2.2.2. The "pick" url param](#222-the-"pick"-url-param)
    * [2.2.3. The "hide" url param](#223-the-"hide"-url-param)
    * [2.2.4. The "with=col-operator-value" filter](#224-the-"with=col-operator-value"-filter)
    * [2.2.5. The "where=col-operator-value" filter](#225-the-"where=col-operator-value"-filter)
    * [2.2.6. Filtering with "like"](#226-filtering-with-"like")
  * [2.3. LIST AS TABLE PAGE](#23-list-as-table-page)
    * [2.3.1. table sorting](#231-table-sorting)
    * [2.3.2. table quick filtering](#232-table-quick-filtering)
    * [2.3.3. set table paging size](#233-set-table-paging-size)
    * [2.3.4. paging - setting the table's page number](#234-paging--setting-the-table's-page-number)
  * [2.4. LIST LABELS PAGE](#24-list-labels-page)
  * [2.5. LIST AS ETABLE PAGE](#25-list-as-etable-page)
    * [2.5.1. table sorting](#251-table-sorting)
    * [2.5.2. Keyboard usability](#252-keyboard-usability)
      * [2.5.2.1. Navigability of the list page with the keyboard](#2521-navigability-of-the-list-page-with-the-keyboard)
      * [2.5.2.2. Focus the quick search box](#2522-focus-the-quick-search-box)
      * [2.5.2.3. Undo the edit on a cell](#2523-undo-the-edit-on-a-cell)
    * [2.5.3. New item creation ( CREATE )](#253-new-item-creation-(-create-))
      * [2.5.3.1. Successful execution](#2531-successful-execution)
      * [2.5.3.2. Error handling on db create error](#2532-error-handling-on-db-create-error)
    * [2.5.4. Single cell Inline-edit ( UPDATE )](#254-single-cell-inline-edit-(-update-))
      * [2.5.4.1. Table columns resizing](#2541-table-columns-resizing)
      * [2.5.4.2. Contents for the table's cells](#2542-contents-for-the-table's-cells)
      * [2.5.4.3. Successful execution](#2543-successful-execution)
      * [2.5.4.4. Error handling on db update error](#2544-error-handling-on-db-update-error)
      * [2.5.4.5. Nulls handling](#2545-nulls-handling)
    * [2.5.5. Item deletion ( DELETE )](#255-item-deletion-(-delete-))
      * [2.5.5.1. Successful execution](#2551-successful-execution)
      * [2.5.5.2. Error handling on delete error](#2552-error-handling-on-delete-error)
    * [2.5.6. List as print-table page](#256-list-as-print-table-page)
  * [2.6. THE VIEW-DOC PAGE](#26-the-view-doc-page)
    * [2.6.1. Error handling for the view-doc page](#261-error-handling-for-the-view-doc-page)
    * [2.6.2. Normal page load](#262-normal-page-load)
    * [2.6.3. The right click menu](#263-the-right-click-menu)
  * [2.7. THE EXPORT URL](#27-the-export-url)
    * [2.7.1. Export data to xls](#271-export-data-to-xls)
    * [2.7.2. Export data to md](#272-export-data-to-md)
* [3. DEVOPS FEATURES AND FUNCTIONALITIES](#3-devops-features-and-functionalities)
  * [3.1. TESTABILITY](#31-testability)
    * [3.1.1. Perl syntax check call](#311-perl-syntax-check-call)
    * [3.1.2. Unit tests call](#312-unit-tests-call)
    * [3.1.3. Integration tests call](#313-integration-tests-call)
    * [3.1.4. Bash tests call](#314-bash-tests-call)
  * [3.2. DOCUMENTATION](#32-documentation)
    * [3.2.1. Single shell call documentation generation - the generate-docs shell action](#321-single-shell-call-documentation-generation--the-generate-docs-shell-action)
    * [3.2.2. Full documentation set](#322-full-documentation-set)
    * [3.2.3. Documentation's file formats](#323-documentation's-file-formats)
  * [3.3. LOGGING](#33-logging)
    * [3.3.1. Bash logging](#331-bash-logging)
    * [3.3.2. Perl logging](#332-perl-logging)
  * [3.4. DEVELOPMENT EFFICIENCY INCREASING ACTIONS](#34-development-efficiency-increasing-actions)
    * [3.4.1. Support for different projects](#341-support-for-different-projects)
    * [3.4.2. The "morph-dir" action](#342-the-"morph-dir"-action)
    * [3.4.3. Perl code syntax check](#343-perl-code-syntax-check)
    * [3.4.4. Single call export of the md and pdf documentation files](#344-single-call-export-of-the-md-and-pdf-documentation-files)
* [4. SYSADMIN FEATURES AND FUNCTIONALITIES](#4-sysadmin-features-and-functionalities)
  * [4.1. ENFORCED DAILY BACKUPS BY "INCREASE-DATE" ACTION](#41-enforced-daily-backups-by-"increase-date"-action)
  * [4.2. POSTGRES DB BACKUP](#42-postgres-db-backup)
  * [4.3. THE "RUN-PGSQL-SCRIPTS" ACTION](#43-the-"run-pgsql-scripts"-action)
  * [4.4. THE "RUN-MYSQL-SCRIPTS" ACTION](#44-the-"run-mysql-scripts"-action)
    * [4.4.1. The "txt-to-db" action period handling ( deprecated)](#441-the-"txt-to-db"-action-period-handling-(-deprecated))
    * [4.4.2. The "txt-to-db" action ( deprecated)](#442-the-"txt-to-db"-action-(-deprecated))
    * [4.4.3. The "db-to-txt" action ( deprecated ) ](#443-the-"db-to-txt"-action-(-deprecated-)-)
    * [4.4.4. The "db-to-txt" action with pre-defined sorting attribute ( deprecated )](#444-the-"db-to-txt"-action-with-pre-defined-sorting-attribute-(-deprecated-))
    * [4.4.5. restart the morbo development server](#445-restart-the-morbo-development-server)
    * [4.4.6. restart the hypnotoad production server](#446-restart-the-hypnotoad-production-server)
* [5. ETL / DATA INTEGRATION FEATURES AND FUNCTIONALITIES](#5-etl-/-data-integration-features-and-functionalities)
  * [5.1. THE "DB-TO-XLS" ACTION AGAINST POSTGRES](#51-the-"db-to-xls"-action-against-postgres)
  * [5.2. THE "XLS-TO-DB" ACTION](#52-the-"xls-to-db"-action)
    * [5.2.1. The "xls-to-db" action without passing xls file](#521-the-"xls-to-db"-action-without-passing-xls-file)
    * [5.2.2. The "xls-to-db" action with nested-set mode against mysql](#522-the-"xls-to-db"-action-with-nested-set-mode-against-mysql)
  * [5.3. THE DB-TO-JSON SHELL ACTION](#53-the-db-to-json-shell-action)
  * [5.4. THE JSON-TO-DB SHELL ACTION](#54-the-json-to-db-shell-action)
* [6. BACK-END API FUNCTIONALITIES](#6-back-end-api-functionalities)
  * [6.1. CREATE WEB-ACTION](#61-create-web-action)
    * [6.1.1. Successful execution](#611-successful-execution)
    * [6.1.2. Error handling on non-existing db](#612-error-handling-on-non-existing-db)
    * [6.1.3. Error handling on non-existing table](#613-error-handling-on-non-existing-table)
    * [6.1.4. Error handling on non-existing attribute ](#614-error-handling-on-non-existing-attribute-)
    * [6.1.5. Error handling on wrong data-type](#615-error-handling-on-wrong-data-type)
  * [6.2. UPDATE WEB-ACTION](#62-update-web-action)
    * [6.2.1. Successful execution](#621-successful-execution)
    * [6.2.2. Error handling on non-existing db](#622-error-handling-on-non-existing-db)
    * [6.2.3. Error handling on non-existing table](#623-error-handling-on-non-existing-table)
    * [6.2.4. Error handling on non-existing attribute ](#624-error-handling-on-non-existing-attribute-)
    * [6.2.5. Error handling on wrong data-type](#625-error-handling-on-wrong-data-type)
    * [6.2.6. Automatic upate_time attribute update](#626-automatic-upate_time-attribute-update)
  * [6.3. DELETE WEB ACTION](#63-delete-web-action)
    * [6.3.1. Successful execution](#631-successful-execution)
    * [6.3.2. Error handling on non-existing db](#632-error-handling-on-non-existing-db)
    * [6.3.3. Error handling on non-existing table](#633-error-handling-on-non-existing-table)
  * [6.4. SELECT WEB ACTION](#64-select-web-action)
    * [6.4.1. successful execution](#641-successful-execution)
    * [6.4.2. apply multiple operators on the select properly](#642-apply-multiple-operators-on-the-select-properly)
    * [6.4.3. error handling for failed connect to db in the select web action](#643-error-handling-for-failed-connect-to-db-in-the-select-web-action)
    * [6.4.4. error handling for non-existent table in the select-tables web action](#644-error-handling-for-non-existent-table-in-the-select-tables-web-action)
    * [6.4.5. filter functionality in select table web action](#645-filter-functionality-in-select-table-web-action)
      * [6.4.5.1. successful execution](#6451-successful-execution)
      * [6.4.5.2. error handling for wrong filtering syntax by missed fltr-by or fltr-va url params](#6452-error-handling-for-wrong-filtering-syntax-by-missed-fltr-by-or-fltr-va-url-params)
      * [6.4.5.3. error handling for non-existent filter name](#6453-error-handling-for-non-existent-filter-name)
    * [6.4.6. Use pick url param functionality in select table web action](#646-use-pick-url-param-functionality-in-select-table-web-action)
      * [6.4.6.1. successful execution](#6461-successful-execution)
      * [6.4.6.2. error handling if a picked column does not exist](#6462-error-handling-if-a-picked-column-does-not-exist)
    * [6.4.7. Use filtering with the like operator in select table web action](#647-use-filtering-with-the-like-operator-in-select-table-web-action)
      * [6.4.7.1. successful execution for number types](#6471-successful-execution-for-number-types)
      * [6.4.7.2. successful execution for text types](#6472-successful-execution-for-text-types)
      * [6.4.7.3. error handling for wrong  syntax in the filtering by the like operator by missed like-by or like-val url params](#6473-error-handling-for-wrong-syntax-in-the-filtering-by-the-like-operator-by-missed-like-by-or-like-val-url-params)
      * [6.4.7.4. error handling for non-existent like table's attribute](#6474-error-handling-for-non-existent-like-table's-attribute)
    * [6.4.8. Filtering by using the "with" url param](#648-filtering-by-using-the-"with"-url-param)
      * [6.4.8.1. Successful execution](#6481-successful-execution)
      * [6.4.8.2. Error handling for non-existent column](#6482-error-handling-for-non-existent-column)
    * [6.4.9. the hide operator in the select web action](#649-the-hide-operator-in-the-select-web-action)
      * [6.4.9.1. successful execution for text types](#6491-successful-execution-for-text-types)
      * [6.4.9.2. error handling for inexistent column to hide](#6492-error-handling-for-inexistent-column-to-hide)
  * [6.5. SELECT-TABLES WEB ACTION](#65-select-tables-web-action)
    * [6.5.1. successful execution](#651-successful-execution)
    * [6.5.2. error handling for failed connect to db in the select-tables web action](#652-error-handling-for-failed-connect-to-db-in-the-select-tables-web-action)
  * [6.6. QUERY WEB ACTION](#66-query-web-action)
    * [6.6.1. successful execution](#661-successful-execution)
    * [6.6.2. error handling on non-provided for operator](#662-error-handling-on-non-provided-for-operator)
    * [6.6.3. error handling for empty for url parameter](#663-error-handling-for-empty-for-url-parameter)
* [7. SECURITY FEATURES AND FUNCTIONALITIES](#7-security-features-and-functionalities)
  * [7.1. FULLY OPEN MODE](#71-fully-open-mode)
  * [7.2. BASIC AUTHENTICATION MODE](#72-basic-authentication-mode)




    

## 1. INTRODUCTION


    

### 1.1. Purpose
The purpose of this document is to describe all the features, functionalities and capabilities provided by a properly installed, configured and operated instance of the issue-tracker application. 
This document is the CONTRACT between you as the potential, former or active user of an issue-tracker instance and the product owner of that instance. 

    

### 1.2. Document status
This document is updated constantly in every release of the issue-tracker. Each version however is considered to be a complete version regarding the issue-tracker version it situated in.

    

### 1.3. Audience
This document is aimed for everyone, who shall, will or even would like to interact with an issue-tracker application instance. 

    

### 1.4. Master storage and storage format
The master storage of this document is the master branch of the issue-tracker release you are interested in. The main storage format is Markdown. 

    

### 1.5. Version control
The contents of this document MUST be updated according to the EXISTING features, functionalities and capabilities of the issue-tracker version, in which this document residues.

    

### 1.6. Process
The issue-tracker provides a mean for tracking of this documentation contents to the source code per feature/functionality, thus should you find inconsistencies in the behavior of the application and the content of this document you should create a bug issue and assign it to the owner of your product instance.

    

## 2. UI FEATURES
This section describes the User Interface ( UI ) features of the issue-tracker application, which all ( for now ) are accessible from an internet browser accessing a running instance of the issue-tracker application. The following examples illustrate the concept:

    

### 2.1. Support for different projects
You could access multiple projects by accessing their project databases as the first URI path component provided that the web server has tcp access to those databases. 

    

#### 2.1.1. Change projects via url
The following 2 different databases are actually the tst and dev databases of the issue-tracker, but of course the database names could be any valid other database names:

http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/dev_issue_tracker/list/yearly_issues?as=grid&pick=id,status,name,description&page-size=5&page-num=1&where=status-eq-09-done

http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/tst_issue_tracker/list/yearly_issues?as=grid&pick=id,status,name,description&page-size=5&page-num=1&where=status-eq-09-done

Note the upper left corner of the page contains the name of your current project database. 

    # access the issue-tracker's project development database
    http://host-name:3000/dev_issue_tracker/list/monthly_issues
    
    # access the issue-tracker's project testing database
    http://host-name:3000/tst_issue_tracker/list/monthly_issues
    
    # access the aspark-starter project production database
    http://host-name:3000/prd_aspark_starter/list/monthly_issues

#### 2.1.2. Switch projects by the :to operator in the search-box
If you type the ":to &lt;&lt;database-name&gt;&gt;" you will get a drop down which will list the projects databases , to which your instance has access to, by chosing the database from the list and hitting enter you will be redirected to the same url by on the different database.

    

#### 2.1.3. Switch items by using the :for operator in the search-box
If you type the ":in &lt;&lt;item-name&gt;&gt;" you will get a drop down which will list the items , to which your instance has access to, by chosing the item from the list and hitting enter you will be redirected to the same url by on the different database.
You can combine both the ":in &lt;&lt;db&gt;&gt;" and ":for &lt;&lt;item&gt;&gt;" operators at once. 

    

### 2.2. The list page
The list page presents part or the whole content of a database by the means of UI controls - dynamic html table, forms etc. 
In the context of the issue-tracker's parley the "listing" is the ui list of control/(s) you get by using the following URL format:

    http://<<web-host>>:<<web-port>>/<<proj-db-name>>/list/<<item>>?as&<<ui-type>>&<<listing-params>>
    

#### 2.2.1. Listing url syntax
The common listing syntax components are as follows:
- web-host is the web-host the issue-tracker's web instances is accessible from
- web-port - the web port the instance is accessible from 
- proj-db-name is the name of the database of your project ( as the issue-tracker supports multiple projects , with multiple databases ... ) 
- list - is the name of the action to perform 
- item is the name of the item which ui controls you want to list ( could be issues,problems,questions, etc.
- ?&lt;&lt;params&gt;&gt; the additional url parameters used to control the look and behavior of the listing action, should the url params be omitted the full content of the item table with default ui look and behavior are displayed. 

    http://host-name:3000/dev_ysg_issues/list/monthly_issues?as=table&pick=id,status,prio,name,description&page-size=15&page-num=1&o=prio&with=status-ne-09-done
    

##### 2.2.1.1. Successful execution
You can use the pick=col1,col2,col3 url parameter to select for only desired attributes.
You could filter the result the same way the filters for the select page work ( see bellow ). 

    

##### 2.2.1.2. Error handling for non-existent db
If the db provided in the url pattern does not exist an error is shown in the top of the page in a visually distinctive manner, after which the msg fades out. Example url:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/non_existent/list/yearly_issues?as=table&pick=id,status,name,description&page-size=5&page-num=1&where=status-eq-09-done

    

##### 2.2.1.3. Error handling for non-existent table
If the table requested does not exist an error is shown in the top of the page in a visually distinctive manner, after which the msg fades out. Example:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/prd_issue_tracker/list/non_existent_table?as=table&pick=id,status,name,description&page-size=5&page-num=1&where=status-eq-09-done

    

##### 2.2.1.4. Error handling for non-existent column
If the column requested does not exist an error is shown in the top of the page in a visually distinctive manner, after which the msg fades out.
Example:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/prd_issue_tracker/list/yearly_issues?as=table&pick=NON_EXISTENT,status,name,description&page-size=5&page-num=1&where=status-eq-09-done

    

#### 2.2.2. The "pick" url param
You can use the pick=col1,col2,col3 url parameter to select for only desired attributes to be show in the ui control used for listing.
The following url demonstrates this syntax:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/prd_issue_tracker/list/yearly_issues?as=table&pick=id,status,name,description&page-size=5&page-num=1&where=status-eq-09-done

    

#### 2.2.3. The "hide" url param
If you do not specify any attribute to pick, you could hide specific attributes by using the "hide=col1,col2,col3" syntax.
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/prd_issue_tracker/list/yearly_issues?as=established=guid,description

    

#### 2.2.4. The "with=col-operator-value" filter
You can filter the result of the query by using the "with=col-operator-value". The following examples demonstrates, which operators are supported.
An error message is shown if you do not use existing operator. 
The following url demonstrates this syntax:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/prd_issue_tracker/list/yearly_issues?as=table&pick=id,status,prio,name,weight,start_time,stop_time&page-size=5&page-num=1&where=status-eq-09-done

    with=status-eq-09-done
    list all the items having the attribute "status" equal to the "09-done" string
    
    with=prio-lt-7
    list all the items having the attribute prio smaller than the number 7
    
    this is the list of all the operators supported
           'eq' => '='
         , 'ne' => '<>'
         , 'gt' => '>'
         , 'lt' => '<'
         , 'ge' => '>='
         , 'le' => '<='
         , 'like' => 'like'
    
    

#### 2.2.5. The "where=col-operator-value" filter
You can filter the result of the query by using the "where=col-operator-value", which works exactly as the with operator, thus the following examples demonstrates, which operators are supported.
An error message is shown if you do not use existing operator. 

    with=status-eq-09-done
    list all the items having the attribute "status" equal to the "09-done" string
    
    with=prio-lt-7
    list all the items having the attribute prio smaller than the number 7
    
    this is the list of all the operators supported
           'eq' => '='
         , 'ne' => '<>'
         , 'gt' => '>'
         , 'lt' => '<'
         , 'ge' => '>='
         , 'le' => '<='
         , 'like' => 'like'
    
    

#### 2.2.6. Filtering with "like"
The filtering with the like operator translates to the SQL "like" operator- the "like-by=&lt;&lt;attr&gt;&gt;&like-val=&lt;&lt;val&gt;&gt; filtering, where &lt;&lt;attr&gt;&gt; stands for the name of the attribute to use the like operator. 
Example:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/prd_issue_tracker/list/yearly_issues?as=table&pick=id,status,name,description&page-size=5&page-num=1&like-by=status&like-val=03

    # this example url will list all the monthly_issues items having the "bug" string in their "name" attribute:
    http://host-name:3000/dev_issue_tracker/list/monthly_issues?as=table&like-by=name&like-val=bug

### 2.3. List as table page
The list table page lists all the rows from any table in the app db in form of simple ui table , which is sortable by clicking with  .. 

    

#### 2.3.1. table sorting
The listed table is sortable by clicking on the columns OR by navigating with the tab key on the keyboard on a column and hitting Enter. 
The sorted column is visually shown as the active one on page load:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/prd_issue_tracker/list/yearly_issues?as=table&oa=prio&pick=id,status,prio,name,weight,start_time,stop_time&page-size=5&page-num=1&where=status-eq-09-done

    

#### 2.3.2. table quick filtering
You can filter the already presented part of the result set in the page by using the search textbox. This is only an ui type of filtering for the already loaded data. This type of filtering is different compared to the url parameters filtering by using the with url param syntax and it filters the already fetched from the db data-set, whereas the with=&lt;&lt;attribute&gt;&gt;&lt;&lt;operator&gt;&gt;&lt;&lt;value&gt;&gt; filtering does filter on the database side.
You could focus the quick search textbox by pressing the forward slash on your keyboard. 
The quick search box works instantaneously, thus hitting enter is not needed. 

    

#### 2.3.3. set table paging size
You can set the page size of the result set to be fetched from the database by using the "&page-size=&lt;&lt;page-size&gt;&gt;" url parameter or by clicking on the page sizes links right of the table search box. 

    

#### 2.3.4. paging - setting the table's page number
If the result-set requested is larger than the page size you can go to the next page number by using the "&page-num=&lt;&lt;page-num&gt;&gt;" url parameter. 
You could go to the next page number by clicking on the links just bellow the quick search textbox. The table control has UI for setting the table page number. 
The pager shows 10 pages at a "pager page" so getting to the end of hundreds of pages ( depending of course on your page size ) is comparably easy. 
You could quickly use the / char shortcut to focus to the quick search box and from there use the tab to quickly navigate to the desired page number. 

    

### 2.4. List labels page
The list labels page lists all the rows from any table in the app db in form of "labels" - rectangular forms containing all the selected attributes ( by default all ) and their values. 
Note that only the as=lbls url change triggers the different view of the same data:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/prd_issue_tracker/list/yearly_issues?as=lbls&pick=id,status,name,description&page-size=5&page-num=1&like-by=status&like-val=03

    

### 2.5. List as etable page
The list a table page has all the functionalities as the list as "table" page with the following additional features

    

#### 2.5.1. table sorting
The listed table is sortable by clicking on the columns OR by navigating with the tab key on the keyboard on a column and hitting Enter. 
The sorted column is visually shown as the active one on page load:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/prd_issue_tracker/list/yearly_issues?as=etable&oa=prio&pick=id,status,prio,name,weight,start_time,stop_time&page-size=5&page-num=1&where=status-eq-09-done

    

#### 2.5.2. Keyboard usability
You can quickly traverse the cells of the table via the tab key, which does go over the non-editable items too ( the id's ) , so that you could quickly scroll the table as scrolling when the editable is in focus does not work. 
The whole table is easily scrollable whenever the cursor is on non-editable part of the table ( the id's column ) and whenever the last rows must be edited the page is scrolled so that the rows are situated in the middle and not the bottom of the screen. 

    

##### 2.5.2.1. Navigability of the list page with the keyboard
The order of the list-as-grid page has been arranged so that the ui user cuold cycly trough the whole table with the tab easily. 

    

##### 2.5.2.2. Focus the quick search box
You could focus the quick search by typing / IF you are not editing a cell. Thus the paging on the next cell is quite handy - as you could easily jump onto the quick search and with couple of tabs navigate to the next page. 

    

##### 2.5.2.3. Undo the edit on a cell
If you were on a cell and types some text without leaving it, but you change your mind you could simply press the Esc key, which will restore the original content of the cell and you could proceed by tab to the next cell. 

    

#### 2.5.3. New item creation ( CREATE )
A new item could be added to the table in the ui and thus in the db table by clicking the plus button above the table ( which uses the google material design ui ). 
The new button has a fixed positon, thus available during scrolling as well from the same position. 
The new button changes it's appears when focused via the keyboard, and can be pressed when in focus by hitting enter with the keyboard. 
To practice new items' creations and deletions to get confortable on the app's behaviour please use first the development instances of the issue-tracker project: 
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/dev_issue_tracker/list/monthly_issues?as=grid&pick=id,status,prio,name,weight,start_time,stop_time&page-size=5&page-num=1

    

##### 2.5.3.1. Successful execution
After clicking the plus button the System adds the new row into the database table and presents it into the table ui AS THE FIRST ROW to emphasize the created row - that is the existing sort of the table is changed to the id column.
This behavior is not obvious if you have at the time of pressing the add-new button a valid search in the quick search box as the result set will most probably not show your new item as the filter is ongoing, this is rather bug, which for now is handled with the dimming of the add new button during an active search in the quick search box. 

    

##### 2.5.3.2. Error handling on db create error
If any error occurs while the creation an error msg is presented clearly with fading effect, which returns the error msg from the database. 
On invalid input the data is not created to the database and nothing is stored. 

    

#### 2.5.4. Single cell Inline-edit ( UPDATE )
The table can be edited inline so that the data is updated to the database. White space in the cells is preserved. 
To practice new items' creations updates and deletions to get confortable on the app's behaviour please use first the development instances of the issue-tracker project: 
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/dev_issue_tracker/list/monthly_issues?as=grid&pick=id,status,prio,name,weight,start_time,stop_time&page-size=5&page-num=1

    

##### 2.5.4.1. Table columns resizing
You can resize the columns of the tables to a max size of 500 pixels by dragging only one text area. Note however that the textarea will NOT be resized bigger than the maximum width of the current column … 
For the estetics of the table a certain default values for certain columns' cotents widths are assumed.

    

##### 2.5.4.2. Contents for the table's cells
The table's cells should accept any UTF-8 characters including html entities. The textarea's width should adjust automatically till the width of the widest cell in the table column. 

    

##### 2.5.4.3. Successful execution
If the single cell inline-edit is successful no msg is presented and the data is updated to the database storage.
If the updated cell was part of the currently sorted column the ui is automatically adjusted to the new sort order ( for example if a numeric sort was applied and the cell had value of 9 with 1..9 range and the smallest to greatest was currently active if the new update is 1 the item will appear in the top of the listing.

    

##### 2.5.4.4. Error handling on db update error
If any error occurs while updating an error msg is presented clearly with fading effect, which returns the error msg from the database. 
On invalid input the data is not updated to the database and the old value in the cell is restored.

    

##### 2.5.4.5. Nulls handling
Nulls handling is somewhat problematic in ui. For now the behavior by convention is to leave a nullable record in the database as null, whether the cell of the ui table is left empty ( white space chars are also considered empty)

    

#### 2.5.5. Item deletion ( DELETE )
You could delete items by clicking the delete button in the beginning of every item. 
To practice new items' creations and deletions to get confortable on the app's behaviour please use first the development instances of the issue-tracker project: 
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/dev_issue_tracker/list/monthly_issues?as=grid&pick=id,status,prio,name,weight,start_time,stop_time&page-size=5&page-num=1

    

##### 2.5.5.1. Successful execution
If the deletion is successful the item is removed both from the ui and from the database. 

    

##### 2.5.5.2. Error handling on delete error
If any error occurs while deleting the item an error msg is presented clearly with fading effect, which returns the error msg from the database. 
On invalid input the data is not updated to the database and the old value in the cell is restored.

    

#### 2.5.6. List as print-table page
The list as print-table page is aimed at producing quickly refined result-set from the database for a further copy paste or even print to paper. 
It has all the functionalities as the list as "table" page, without the filtering from the quick search box and without the ui for the pager and page-sizer -the url params for paging and page-sizing work, however. All the url params work as in the etable listing page. 
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/prd_issue_tracker/list/yearly_issues?as=print-table&pick=id,status,name,description&page-size=5&page-num=1&like-by=status&like-val=03

    

### 2.6. The view-doc page
The view page presents the data of a database table, having nested-set hierarchichal model partially or fully by the means of different controls

    

#### 2.6.1. Error handling for the view-doc page
Should there be an error a dynamic snackbar is presented with the error message. The snackbar hides itself by default after 3.9 seconds ( set by default , but it could be pinned to the page by the user to view it properly / send it furter). 
Whenever an error occurs the show right menu button does not occur and no document is presented

    <<web-host>>:<<web-port>>/<<database>>/view/<<table-name>>?as=doc

#### 2.6.2. Normal page load
When the page is loaded all the content of the document is presented / according to the urls params / which are applying the same filtering as in the list page , but on the hierarchichal data-set …
The rigt menu, containing the table of contents of the document can be opened and closed and scrolled separately


    <<web-host>>:<<web-port>>/<<database>>/view/<<table-name>>?as=doc

#### 2.6.3. The right click menu
You can perform actions on any item by right-cliking the titles either from the document or fro mthe table of contents below

    

### 2.7. The export url
The export url follows the same syntax naming conventions as the list page , but instead of presenting a list with the data it exports it in the specified with "as" url parameter format. 

    <<web-host>>:<<web-port>>/<<database>>/export/<<table-name>>?as=xls

#### 2.7.1. Export data to xls
To export data via the export url you could apply any of the listing parameters and replace the list web action with the export one and the as=&lt;&lt;control&gt; to the as=xls and the application will present you with a save file dialog with the desired data. 

    <<web-host>>:<<web-port>>/<<database>>/export/<<table-name>>?as=xls

#### 2.7.2. Export data to md
To export a document via the export url you could apply any of the listing parameters and replace the view web action with the export one and the as=&lt;&lt;control&gt; to the as=md and the application will present you with a save file dialog with a generated md document with the desired data

    <<web-host>>:<<web-port>>/<<database>>/export/<<table-name>>?as=xls

## 3. DEVOPS FEATURES AND FUNCTIONALITIES


    

### 3.1. Testability
The issue-tracker app has a good and improving all the time test coverage. You can all the tests in the application as follows:

    

#### 3.1.1. Perl syntax check call
You can check the perl syntax for each perl code file in the whole project by issuing the following shell call:

    bash src/bash/issue-tracker/issue-tracker.sh -a check-perl-syntax

#### 3.1.2. Unit tests call
You can run the unit tests of the application by issuing the following single shell call:

    bash src/bash/issue-tracker/issue-tracker.sh -a run-perl-unit-tests

#### 3.1.3. Integration tests call
You can run the integration tests of the application by issuing the following single shell call ( note that the integration tests will not start if you do not have pre-loaded the needed shell env vars for your project you want to operate on ). 

    bash src/bash/issue-tracker/issue-tracker.sh -a run-integration-tests

#### 3.1.4. Bash tests call
You can run all the bash functions in the tool by issuing the following command in the shell. 

    # if you set the previous 2 actions as those to be tested
    bash src/bash/issue-tracker/test-issue-tracker.sh
    
    2018-05-12 18:01:08      START test-issue-tracker test run report
    
    result  start-time  stop-time   action-name
       ok    18:01:09 18:01:19 run-perl-unit-tests
       ok    18:01:20 18:01:30 run-perl-integration-tests
    
    
    
    2018-05-12 18:01:30      STOP  test-issue-tracker test run report

### 3.2. Documentation
We consider up-to-date and complete documentation as being integral part of the application, thus each release must have the documentation updated to it's current set of features, functionalities and capabilities. 
You might argue that the amount of documentation is too big, yet the more you dive into the application the more you will justify it's existence by yourself. 

    

#### 3.2.1. Single shell call documentation generation - the generate-docs shell action
You can generate all the md and pdf docs by if you have a running instance of the isg-pub application accessible via single shell call by issuing the following command: 
The command will fail if there is a doc configured in the isg-pub database which has less than 100 lines. 

    bash src/bash/issue-tracker/issue-tracker.sh -a generate-docs

#### 3.2.2. Full documentation set
Every instance of the isssue-tracker application comes with up-to-date documentation set addressing the latest commit of the released version, namely the following documents:
 - Requirements
 - UserStories
 - Features and Functionalities
 - DevOps Guide
 - Installation and Configuration Guide

    find doc/md

#### 3.2.3. Documentation's file formats
The documentation set of the application is available at least in the following file formats:
 - md - ( the master documentation format )
 - pdf - for distribution

The following formats MIGHT be also optionally available :
 - xls ( extracts from the isg-pub database ) 
 - sql ( dumps from the isg-pub database ) 
 - json ( extracts from the isg-pub database )  

    find doc -type f | sort

### 3.3. Logging
Logging is implemented as follows:

    

#### 3.3.1. Bash logging
The issue-tracker.sh bash entry point loggs both to STDOUT and file. You cold easily defined your own log levels. 

    doLog "INFO an info msg"
    [INFO ] 2018.05.08-21:05:25 EEST [issue-tracker][@host-name] [29667] an info msg:

#### 3.3.2. Perl logging
The perl logger could be configured to log to file and std outputs. 

    doLog "INFO an info msg"
    [INFO ] 2018.05.08-21:05:25 EEST [issue-tracker][@host-name] [29667] an info msg:

### 3.4. Development efficiency increasing actions


    

#### 3.4.1. Support for different projects
The issue-tracker could be used against many different projects as soon as they have the needed file and dir structure , configuration file and dedicated db in the PostgreSQL. 
You could quickly fork a new project out of the issue-tracker instance by copying the 

    # pre-load the vars of an issue-tracker project
    doParseIniEnvVars /vagrant/csitea/cnf/projects/issue-tracker/issue-tracker-issues.dev.doc-pub-host.cnf

#### 3.4.2. The "morph-dir" action
You can recursively search and replace strings in both file and dir paths and their contents ( as soon as they non-binary , txt files ) by issuing the following commands:

    export to_srch=WriterTxtDaily
    export to_repl=WriterTxtTerm
    export dir_to_morph=`pwd`
    bash src/bash/issue-tracker/issue-tracker.sh -a morph-dir
    fg
    history | cut -c 8-
    

#### 3.4.3. Perl code syntax check
You can check the perl code syntax with the following command:

    bash src/bash/issue-tracker/issue-tracker.sh -a check-perl-syntax

#### 3.4.4. Single call export of the md and pdf documentation files
Single call export of the md and pdf documentation files

    

## 4. SYSADMIN FEATURES AND FUNCTIONALITIES
The term feature usually denotes an UI usability, but as the sysadmins of the issue-tracker system must be technical people accustomed to the black screen in this context feature simply means a well memorizable shell call to perform a single action on the System they must operate. 

    # pre-load the project variables
    doParseCnfEnvVars cnf/issue-tracker.dev.host-name.cnf
    
    # run the run-integration-tests
    bash src/bash/issue-tracker/issue-tracker.sh -a run-integration-tests

### 4.1. Enforced daily backups by "increase-date" action
The concept of daily backups in in-build in the functionalities of the issue-tracker application for all the projects data - that is you cannot operate the application without having daily backups, as every day a new working daily dir having the current day daily backup will be created!
The "increase-date" action copies the content of the latest daily data dir ( build by concentrating the mix_data_dir and the latest date string) with the current date in the file path. 
This IS the defacto way of making backup of the data ( including db dumps ) on daily basis, which could be quite easily made really robust for Unix admins with couple of cron scripts and symlinks ... 
The increase-date behaves for different projects in the same way, except of course using a different daily data dir root. 

    # load the env vars for a different proj: 
    clear; doParseCnfEnvVars /vagrant/var/csitea/cnf/projects/issue-tracker/ysg-issues.dev.host-name.cnf
    
    # make backup of the latest daily dir
    bash src/bash/issue-tracker/issue-tracker.sh -a increase-date

### 4.2. Postgres db backup
You can backup any project database by using the following calls:

    # pre-load the project variables
    doParseCnfEnvVars cnf/issue-tracker.dev.host-name.cnf
    # replace the second strin to the full path of the project file if needed 
    
    # backup the postgres db of the project 
    bash src/bash/issue-tracker/issue-tracker.sh -a backup-postgres-db

### 4.3. The "run-pgsql-scripts" action
You can create a preconfigured &lt;&lt;env&gt;&gt;_&lt;&lt;db_name&gt;&gt; postgres via a single shell call. The scripts will fail if any of the sql scripts have a syntax error - all the ddl events will be displayed in the STDOUT and stored in the shell log file for later audit.

    bash src/bash/issue-tracker/issue-tracker.sh -a run-pgsql-scripts

### 4.4. The "run-mysql-scripts" action
You can create a preconfigured &lt;&lt;env&gt;&gt;_&lt;&lt;db_name&gt;&gt; in mariadb  via a single shell call. The scripts will fail if any of the sql scripts have a syntax error - all the ddl events will be displayed in the STDOUT and stored in the shell log file for later audit

    

#### 4.4.1. The "txt-to-db" action period handling ( deprecated)
Issues txt files are stored in a daily folder with the following naming convention:
&lt;&lt;project&gt;&gt;.&lt;&lt;current_date&gt;&gt;.&lt;&lt;period&gt;&gt;.txt
The tool knows to correctly fetch the issues files for the configured period ( by export period=weekly ) and copy its data in to the &lt;&lt;period&gt;&gt;_issue table. 

    ysg-issues.2017-06-03.daily.txt
    ysg-issues.2017-06-03.monthly.txt
    ysg-issues.2017-06-03.weekly.txt
    ysg-issues.2017-06-03.yearly.txt

#### 4.4.2. The "txt-to-db" action ( deprecated)
You can load you issues from an "issues txt file" , having a specific syntax into a PosgtreSQL issue table, by issueing the shell.
This call with truncate the issue table from the db and convert all the issues data from the issues txt file into the issue table. 

    # pre-load the vars of an issue-tracker project
    doParseIniEnvVars /vagrant/csitea/cnf/projects/issue-tracker/issue-tracker-issues.dev.doc-pub-host.cnf
    
    # ensure there is no data in the issue table
    psql -d "$db_name" -c 'TRUNCATE TABLE issue ;'
    
    # run the txt-to-db action
    bash src/bash/issue-tracker/issue-tracker.sh -a txt-to-db
    
    # check the data by :
    psql -d "$db_name" -c 'SELECT issue_id , category , name FROM issue order by name'

#### 4.4.3. The "db-to-txt" action ( deprecated ) 
You can load your already stored in the issue table issues and load them into the same issues txt file

    # check the data by :
    psql -d "$db_name" -c '
    SELECT issue_id , start_time , stop_time , category , name FROM issue order by prio'
    
    # run the db-to-xls action
    bash src/bash/issue-tracker/issue-tracker.sh -a db-to-txt
    
    # check the updated data
    psql -d "$db_name" -c '
    SELECT issue_id , start_time , stop_time , category , name FROM issue order by start_time'

#### 4.4.4. The "db-to-txt" action with pre-defined sorting attribute ( deprecated )
You can load your already stored in the issue table issues and load them into the same issues txt file by using a pre-defined sorting attribute. 

    export issues_order_by_attribute=start_time
    
    bash src/bash/issue-tracker/issue-tracker.sh -a db-to-txt

#### 4.4.5. restart the morbo development server
You could restart the development morbo server by issuing the following syntax ( Note that each environment type starts within the pre-configured mojo_morbo_port if configured to do so):

    bash src/bash/issue-tracker/issue-tracker.sh -a mojo-morbo-stop ; bash src/bash/issue-tracker/issue-tracker.sh -a mojo-morbo-start

#### 4.4.6. restart the hypnotoad production server
You could restart the production hypnotoad server by issuing the following syntax:

    bash src/bash/issue-tracker/issue-tracker.sh -a mojo-hypnotoad-stop ; bash src/bash/issue-tracker/issue-tracker.sh -a mojo-hypnotoad-start

## 5. ETL / DATA INTEGRATION FEATURES AND FUNCTIONALITIES


    

### 5.1. The "db-to-xls" action against postgres
You can unload your already stored ANY xls table with unique id's and load them into a xls file. 

    # pre-load the vars of an issue-tracker project
    doParseIniEnvVars /vagrant/csitea/cnf/projects/issue-tracker/issue-tracker-issues.dev.doc-pub-host.cnf
    
    
    # check the data by :
    psql -d "$db_name" -c 'SELECT issue_id , start_time , stop_time , category , name FROM issue order by prio'
    
    # run the db-to-xls action
    bash src/bash/issue-tracker/issue-tracker.sh -a db-to-xls
    

### 5.2. The "xls-to-db" action
You can load the latest produced xls file ( note as long as your xls sheet headers match the columns in your db table ANY xls is compatible )
You can control whether or not the loadable table should be truncated by setting the do_truncate_tables environment variable to 1 or 0. 

    clear ; export tables=`curl -s -k http://$web_host:3000/$postgres_db_name/select-tables|jq -r '.| .dat| .[] | .table_name'|perl -ne 's/\s+/,/g;print'`;export do_truncate_tables=1 ; export rdbms_type=postgres ; export load_model=upsert ; perl src/perl/issue_tracker/script/issue_tracker.pl --tables $tables --do xls-to-db

#### 5.2.1. The "xls-to-db" action without passing xls file
if you do not provide a xls file the newest xls file from the mix data dir will be used

    clear ; export tables=`curl -s -k http://$web_host:3000/$postgres_db_name/select-tables|jq -r '.| .dat| .[] | .table_name'|perl -ne 's/\s+/,/g;print'`;export do_truncate_tables=1 ; export rdbms_type=postgres ; export load_model=upsert ; perl src/perl/issue_tracker/script/issue_tracker.pl --tables $tables --do xls-to-db

#### 5.2.2. The "xls-to-db" action with nested-set mode against mysql
You could run the xls-to-db action against mysql or mariadb rdbms so that the issue-tracker will arrange your table to be compatible with the nested-set hierarchy model. 

    export tables=Tests,ItemController,ItemModel,ItemView,ExportFile,UserStory,Requirement,DevOps,Feature,ReadMe,SystemGuide,Image,ExportFile; export do_truncate_tables=1 ; export rdbms_type=mysql ; export load_model=nested-set ; perl src/perl/issue_tracker/script/issue_tracker.pl --do xls-to-db --tables $tables

### 5.3. The db-to-json shell action
You could make a backup of all your postgres tables data by running the db-to-json shell action as follows:

    clear ; export tables=`curl -s -k http://$web_host:3000/$postgres_db_name/select-tables|jq -r '.| .dat| .[] | .table_name'|perl -ne 's/\s+/,/g;print'`;export do_truncate_tables=1 ; export rdbms_type=postgres ; perl src/perl/issue_tracker/script/issue_tracker.pl --do db-to-json --tables $tables

### 5.4. The json-to-db shell action
You could restore a previously created json files backup ( the json files are stored in the &lt;&lt;ProductInstanceDir&gt;&gt;/dat/json by default by issueing the following oneliner ( you need to have the web server up and running in order to fetch the list of tables too ) 

    clear ; export tables=`curl -s -k http://$web_host:3000/$postgres_db_name/select-tables|jq -r '.| .dat| .[] | .table_name'|perl -ne 's/\s+/,/g;print'`;export do_truncate_tables=1 ; export rdbms_type=postgres ; perl src/perl/issue_tracker/script/issue_tracker.pl --do json-to-db --tables $tables

## 6. BACK-END API FUNCTIONALITIES


    

### 6.1. create web-action
An http client could create  a new row into ANY table by passing a bigint as the id.

    <<web-host>>:<<web-port>>/<<database>>/create/<<table-name>>

#### 6.1.1. Successful execution
After 200 http returned code a new item is created in the database. Note that all non-null columns in the database MUST have default values, otherwise this call will always fail. This limitation is by design for now.

    <<web-host>>:<<web-port>>/<<database>>/create/<<table-name>>
    // example data
    { id: "3"}

#### 6.1.2. Error handling on non-existing db
If the db provided in the url pattern does not exist an error is shown. 

    

#### 6.1.3. Error handling on non-existing table
If the table provided in the url pattern does not exist an error is shown. 

    

#### 6.1.4. Error handling on non-existing attribute 
If the attribute(column) provided in the post data does not exist an error is shown. 

    

#### 6.1.5. Error handling on wrong data-type
Whenever a wrong data type is passed the back-end returns with the 400 http code and provides the error from the database.


    

### 6.2. update web-action
An http client could update ANY table with a single column name by provinng the column name and the column value

    <<web-host>>:<<web-port>>/<<database>>/update/<<table-name>>

#### 6.2.1. Successful execution
An http client could update ANY table with a single column name by provinng the column name and the column value

    <<web-host>>:<<web-port>>/<<database>>/update/<<table-name>>
    // example data
    {attribute: "description", id: "3", cnt: "the name attr should be updated to updated-name-3"}

#### 6.2.2. Error handling on non-existing db
If the db provided in the url pattern does not exist an error is shown. 

    

#### 6.2.3. Error handling on non-existing table
If the table provided in the url pattern does not exist an error is shown. 

    

#### 6.2.4. Error handling on non-existing attribute 
If the attribute(column) provided in the post data does not exist an error is shown. 

    

#### 6.2.5. Error handling on wrong data-type
Whenever a wrong data type is passed the back-end returns with the 400 http code and provides the error from the database.


    

#### 6.2.6. Automatic upate_time attribute update
Any item having the update_time attribute will get its value automatically based on the update time of the transaction. 

    

### 6.3. delete web action
An http client could create  a new row into ANY table by passing a bigint as the id.

    <<web-host>>:<<web-port>>/<<database>>/update/<<table-name>>

#### 6.3.1. Successful execution
Once the post call is executed the item is deleted from the db.

    <<web-host>>:<<web-port>>/<<database>>/update/<<table-name>>
    // example data
    {attribute: "description", id: "3", cnt: "the name attr should be updated to updated-name-3"}

#### 6.3.2. Error handling on non-existing db
If the db provided in the url pattern does not exist an error is shown. 

    

#### 6.3.3. Error handling on non-existing table
If the table provided in the url pattern does not exist an error is shown. 

    

### 6.4. select web action
An http-client could get the contents of ANY table of a database to which the issue-tracker has connectivity to ( ie not only the one configured in the application layer but also other databases in the same postgres instance)  by using the following syntax:

    <<web-host>>:<<web-port>>/<<database>>/select/<<table-name>>

#### 6.4.1. successful execution
An http-client could get the contents of ANY table of a database to which the issue-tracker has connectivity to by calling the following url:
&lt;&lt;web-host&gt;&gt;:&lt;&lt;web-port&gt;&gt;/&lt;&lt;database&gt;&gt;/select/&lt;&lt;table-name&gt;&gt;

    

#### 6.4.2. apply multiple operators on the select properly
All the operators bellow could be combined and the result set is the one "translated" with the AND operator in the back-end side. 

    

#### 6.4.3. error handling for failed connect to db in the select web action
If the http-client points to a db to which the app layer does not have a connection ( might be a non-existing one ) the proper response is generated. 


    // 20180503234141
    // http://192.168.56.120:3000/non_existent/select/daily_issues
    
    {
      "msg": "cannot connect to the non_existent database: FATAL:  database \"non_existent\" does not exist",
      "req": "GET http://192.168.56.120:3000/non_existent/select/daily_issues",
      "ret": 400
    }

#### 6.4.4. error handling for non-existent table in the select-tables web action
if a table does not exist a proper error msg containing response is generated.


    // 20180505205015
    // http://192.168.56.120:3000/dev_issue_tracker/select/non_existent
    
    {
      "msg": " the table non_existent does not exist in the dev_issue_tracker database ",
      "req": "GET http://192.168.56.120:3000/dev_issue_tracker/select/non_existent",
      "ret": 400
    }

#### 6.4.5. filter functionality in select table web action
The response cold be filtered by ANY attribute with any valid value. 


    // using the following syntax:
    <<web-host>>:<<web-port>>/<<database>>/select/<<table-name>>?fltr-by=<<filter-attribute-to-filter-by>>&fltr-val=<<filter-value-to-filter-by>>

##### 6.4.5.1. successful execution
The response of the select web action could be filtered by using the syntax bellow:
Those are eventual transated to a where clause in the db select part. 



    // 20180505204531
    // http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?fltr-by=prio&fltr-val=1
    
    {
      "dat": {
        "c89d3283-0a9f-4b8d-9dcc-84a63e64276b": {
          "actual_hours": null,
          "category": "issue-tracker-features",
          "description": "add the web select controller “\r\n - implementation code\r\n - tests \r\n - documentation additions for :\r\n-- requirements\r\n-- userstories\r\n-- tests \r\n-- features and functionalities",
          "guid": "c89d3283-0a9f-4b8d-9dcc-84a63e64276b",
          "id": 180402,
          "level": 2,
          "name": "add the web select controller",
          "owner": "ysg",
          "planned_hours": "3.00",
          "prio": 1,
          "seq": 1,
          "start_time": "2018-04-02 18:00",
          "status": "07-qas",
          "stop_time": null,
          "tags": "feature",
          "type": "feature",
          "update_time": "2018-05-04 23:18:45.104771"
        }
      },
      "msg": "SELECT OK for table: monthly_issues",
      "req": "GET http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?fltr-by=prio&fltr-val=1",
      "ret": 200
    }

##### 6.4.5.2. error handling for wrong filtering syntax by missed fltr-by or fltr-va url params
If the request does not have either one of the url params the following response is produced. 


    // 20180505204734
    // http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?fltr-by=prio
    
    {
      "msg": "mall-formed url params for filtering - valid syntax is ?fltr-by=<<attribute>>&fltr-val=<<filter-value>>",
      "req": "GET http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?fltr-by=prio",
      "ret": 400
    }

##### 6.4.5.3. error handling for non-existent filter name
If the syntax is correct but an non-existent filtering attribute is provided ( that is the table columns and the attribute name do not match ) the following error msg is returned: 


    // 20180506220030
    // http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?fltr-by=foo&fltr-val=sdklfj
    
    {
      "msg": "the foo column does not exist",
      "req": "GET http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?fltr-by=foo&fltr-val=sdklfj",
      "ret": 400
    }

#### 6.4.6. Use pick url param functionality in select table web action
Works for both a single colum and a comma separated select of columns. Obeys the following syntax:


    // using the following syntax:
    <<web-host>>:<<web-port>>/<<database>>/select/<<table-name>>?pick=col1,col2,col3

##### 6.4.6.1. successful execution
if the request contains the "pick" url parameter only the picked column values are selected. 


    // 20180506230955
    // http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?pick=name,prio
    
    {
      "dat": {
        "0daa3447-42f5-4792-aca2-bd1cb06e2a78": {
          "guid": "0daa3447-42f5-4792-aca2-bd1cb06e2a78",
          "name": "define REST API response structure",
          "prio": 3
        },
        "3c3aff5d-8246-4893-acc4-4853904f1d40": {
          "guid": "3c3aff5d-8246-4893-acc4-4853904f1d40",
          "name": "add the pick in url to select in db reader control flow for Select.pm controller",
          "prio": 3

##### 6.4.6.2. error handling if a picked column does not exist
if a picked column does not exist the following error is displayed. 


    // 20180506230926
    // http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?pick=non_existent_column
    
    {
      "msg": "the non_existent_column column does not exist",
      "req": "GET http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?pick=non_existent_column",
      "ret": 400
    }
      },
      "msg": "SELECT OK for table: monthly_issues",
      "req": "GET http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?pick=name%2Cprio",
      "ret": 200
    }

#### 6.4.7. Use filtering with the like operator in select table web action
The response cold be liked by ANY attribute with any valid value. 


    // using the following syntax:
    <<web-host>>:<<web-port>>/<<database>>/select/<<table-name>>?like-by=<<like-attribute-to-like-by>>&like-val=<<like-value-to-like-by>>

##### 6.4.7.1. successful execution for number types
The like operator could be used with numbers as well.

    // 20180508191656
    // http://192.168.56.120:3000/dev_issue_tracker/select/yearly_issues?like-by=prio&like-val=1&pick=name,prio
    
    {
      "dat": {
        "46533749-1c00-4688-9cdd-1cc276ca40ac": {
          "guid": "46533749-1c00-4688-9cdd-1cc276ca40ac",
          "name": "implement upsert in DbWriterPostgres",
          "prio": 21
        },  "msg": "SELECT OK for table: monthly_issues",
      "req": "GET http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?like-by=prio&like-val=1",
      "ret": 200
    }

##### 6.4.7.2. successful execution for text types
The response of the select web action could be likeed by using the syntax bellow:
Those are eventual transated to a where clause in the db select part. 



    // 20180505204531
    // http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?like-by=prio&like-val=1
    
    {
      "dat": {
        "c89d3283-0a9f-4b8d-9dcc-84a63e64276b": {
          "actual_hours": null,
          "category": "issue-tracker-features",
          "description": "add the web select controller “\r\n - implementation code\r\n - tests \r\n - documentation additions for :\r\n-- requirements\r\n-- userstories\r\n-- tests \r\n-- features and functionalities",
          "guid": "c89d3283-0a9f-4b8d-9dcc-84a63e64276b",
          "id": 180402,
          "level": 2,
          "name": "add the web select controller",
          "owner": "ysg",
          "planned_hours": "3.00",
          "prio": 1,
          "seq": 1,
          "start_time": "2018-04-02 18:00",
          "status": "07-qas",
          "stop_time": null,
          "tags": "feature",
          "type": "feature",
          "update_time": "2018-05-04 23:18:45.104771"
        }
      },
      "msg": "SELECT OK for table: monthly_issues",
      "req": "GET http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?like-by=prio&like-val=1",
      "ret": 200
    }

##### 6.4.7.3. error handling for wrong  syntax in the filtering by the like operator by missed like-by or like-val url params
If the request does not have either one of the url params the following response is produced. 


    // 20180505204734
    // http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?like-by=prio
    
    {
      "msg": "mall-formed url params for likeing - valid syntax is ?like-by=<<attribute>>&like-val=<<like-value>>",
      "req": "GET http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?like-by=prio",
      "ret": 400
    }

##### 6.4.7.4. error handling for non-existent like table's attribute
If the syntax is correct but an non-existent like operator's attribute is provided ( that is the table columns and the attriute name do not match ) the following error msg is returned: 


    // 20180506220030
    // http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?like-by=foo&like-val=sdklfj
    
    {
      "msg": "the foo column does not exist",
      "req": "GET http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?like-by=foo&like-val=sdklfj",
      "ret": 400
    }

#### 6.4.8. Filtering by using the "with" url param
You can filter the result of the query by using the "with=col-operator-value"

    // 20180605150216
    // http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?as=grid&with=prio-lt-6&o=prio&pick=name,prio&with=status-eq-02-todo
    
    {
       "dat": [
          {
             "guid": "55a06b10-7bbf-4298-a1ee-804bbfd12570",
             "name": "poc for data-load testing",
             "prio": 5
          }
       ],
       "msg": "",
       "req": "GET http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?as=grid",
       "ret": 200
    }

##### 6.4.8.1. Successful execution
The application selects only the rows matching the generated where &lt;&lt;column&gt;&gt; &lt;&lt;operator&gt;&gt; &lt;&lt;value&gt;&gt; , where the operator could be also the like operator ( set also if the value contains the % char ) 

    

##### 6.4.8.2. Error handling for non-existent column
If the column used does not exist an error is provided as follows:


    // 20180605150010
    // http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?as=grid&with=prio-lt-7&o=prio&pick=name,prio&with=foo-eq-02-todo
    
    {
       "msg": "the foo column does not exist",
       "req": "GET http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?as=grid",
       "ret": 400
    }

#### 6.4.9. the hide operator in the select web action
Whenever a hide=&lt;&lt;col-name&gt;&gt; operator is applied the values and the column names of the column to hide are not displayed in the result. Use command to as the separator for listing multiple columns to hide. 


    // using the following syntax:
    <<web-host>>:<<web-port>>/<<database>>/select/<<table-name>>?hide=guid,prio

##### 6.4.9.1. successful execution for text types
The response of the url query presents all but the hidden attribute values.


    // 20180511144541
    // http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?like-by=category&like-val=features&pick=name,prio,start_time,stop_time,category,status&o=stop_time&hide=guid
    
    {
      "dat": [
        {
          "category": "issue-tracker-features",
          "name": "improve integration testing",
          "prio": 5,
          "start_time": null,
          "status": "09-done",
          "stop_time": null
        }
      ],
      "msg": "",
      "req": "GET http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?like-by=category&like-val=features&pick=name%2Cprio%2Cstart_time%2Cstop_time%2Ccategory%2Cstatus&o=stop_time&hide=guid",
      "ret": 200
    }

##### 6.4.9.2. error handling for inexistent column to hide
If the column which values are requested to be hidden does not exist the proper error message is retrieved. 


    // 20180505204734
    // http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?like-by=prio
    
    {
      "msg": "mall-formed url params for likeing - valid syntax is ?like-by=<<attribute>>&like-val=<<like-value>>",
      "req": "GET http://192.168.56.120:3000/dev_issue_tracker/select/monthly_issues?like-by=prio",
      "ret": 400
    }

### 6.5. select-tables web action
An http-client could get the select of all the tables of a database to which the issue-tracker has connectivity to ( that is not only the one configured in the application layer )


    <<web-host>>:<<web-port>>/<<database>>/select-tables

#### 6.5.1. successful execution
An http-client could get the select of all the tables of a database to which the issue-tracker has connectivity to


    // 20180505205212
    // http://192.168.56.120:3000/dev_issue_tracker/select-tables
    
    {
      "dat": {
        "1": {
          "row_id": "1",
          "table_catalog": "dev_issue_tracker",
          "table_name": "confs",
          "table_schema": "public"
        },
        "2": {
          "row_id": "2",
          "table_catalog": "dev_issue_tracker",
          "table_name": "daily_issues",
          "table_schema": "public"
        },
        "3": {
          "row_id": "3",
          "table_catalog": "dev_issue_tracker",
          "table_name": "decadally_issues",
          "table_schema": "public"
        }
      },
      "msg": "SELECT tables-select OK ",
      "req": "GET http://192.168.56.120:3000/dev_issue_tracker/select-tables",
      "ret": 200
    }

#### 6.5.2. error handling for failed connect to db in the select-tables web action
If the http-client points to a db to which the app layer does not have a connection ( might be a non-existing one ) the proper response is generated. 


    // 20180503234141
    // http://192.168.56.120:3000/non_existent/select/daily_issues
    
    {
      "msg": "cannot connect to the non_existent database: FATAL:  database \"non_existent\" does not exist",
      "req": "GET http://192.168.56.120:3000/non_existent/select/daily_issues",
      "ret": 400
    }

### 6.6. Query web action
An http-client could query the name and description attributes for all the tables having those attributes by a keyword , which is translated to the sql like clause.

    <<web-host>>:<<web-port>>/<<database>>/select/<<table-name>>

#### 6.6.1. successful execution
An http-client could get the contents of ANY table of a database to which the issue-tracker has connectivity to by calling the following url:
&lt;&lt;web-host&gt;&gt;:&lt;&lt;web-port&gt;&gt;/&lt;&lt;database&gt;&gt;/query?for=&lt;&lt;phrase-to-srch-for&gt;&gt;
For example: 
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/dev_issue_tracker/query?for=meta-data

    // 20181105161448
    // http://192.168.56.120:3001/dev_issue_tracker/query?for=meta-data
    
    {
       "dat": [
          {
             "description": "The meta-data could be added to the met , as the data is set in the dat of the json ...\nBecause this will also enable the display of the warning msgs capability",
             "guid": "4deaead1-721e-4bee-93ce-22d7e01dd511",
             "id": 180806103105,
             "item": "monthly_issues",
             "name": "add fetching of the meta-data in the select web-action"
          },
          {
             "description": "Basically a good calendar control should be pretty easy to be integrated ... , but it would require \"infra\" for fetching the meta-data as well ...",
             "guid": "bf2206c2-0b12-415f-90a0-d008b0d6913a",
             "id": 180806102543,
             "item": "yearly_issues",
             "name": "add vue calendar on the dates "
          }
       ],
       "met": 0,
       "msg": "",
       "req": "GET http://192.168.56.120:3001/dev_issue_tracker/query",
       "ret": 0
    }

#### 6.6.2. error handling on non-provided for operator
If the for operator is not provided an error is returned:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/dev_issue_tracker/query

    // 20181105161651
    // http://192.168.56.120:3001/dev_issue_tracker/query
    
    {
       "met": "",
       "msg": "nothing to search for, the for url parameter is undefined the query route",
       "req": "GET http://192.168.56.120:3001/dev_issue_tracker/query",
       "ret": 400
    }

#### 6.6.3. error handling for empty for url parameter
If the for url parameter is empty  is not provided an error is returned:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/dev_issue_tracker/query?for=

    // 20180503234141
    // http://192.168.56.120:3000/non_existent/select/daily_issues
    
    {
      "msg": "cannot connect to the non_existent database: FATAL:  database \"non_existent\" does not exist",
      "req": "GET http://192.168.56.120:3000/non_existent/select/daily_issues",
      "ret": 400
    }

## 7. SECURITY FEATURES AND FUNCTIONALITIES


    

### 7.1. Fully open mode
Currently the default mode of any running issue-tracker application is "fully open", that is any user having access to the url of the application might perform any change from the ui. 

    

### 7.2. Basic authentication mode
A fully deployed and configured issue-tracker instance provides basic authentication mode for any project database it has access to allowing thus persons having the credentials of the system account used for the particular project database to have full read,write and delete access to the data of that instance, in a way preventing users not having access to those credentials to the application. 
It is worth noting that this basic authentication does not mean strict security requirements for business and personal data on the web.
For more info consult the BasicAuthPlus module docs  :
https://metacpan.org/pod/Mojolicious::Plugin::BasicAuthPlus#DESCRIPTION
 

    

