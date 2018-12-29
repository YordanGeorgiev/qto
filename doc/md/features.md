#  ISSUE TRACKER FEATURES, FUNCTIONALITIES AND CAPABILITIES


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

#### 2.1.2. Switch projects by the :to operator in the search-box
If you type the ":to &lt;&lt;database-name&gt;&gt;" you will get a drop down which will list the projects databases , to which your instance has access to, by chosing the database from the list and hitting enter you will be redirected to the same url by on the different database.

#### 2.1.3. Switch items by using the :for operator in the search-box
If you type the ":in &lt;&lt;item-name&gt;&gt;" you will get a drop down which will list the items , to which your instance has access to, by chosing the item from the list and hitting enter you will be redirected to the same url by on the different database.
You can combine both the ":in &lt;&lt;db&gt;&gt;" and ":for &lt;&lt;item&gt;&gt;" operators at once. 

### 2.2. The list page
The list page presents part or the whole content of a database by the means of UI controls - dynamic html table, forms etc. 
In the context of the issue-tracker's parley the "listing" is the ui list of control/(s) you get by using the following URL format:

#### 2.2.1. Listing url syntax
The common listing syntax components are as follows:
- web-host is the web-host the issue-tracker's web instances is accessible from
- web-port - the web port the instance is accessible from 
- proj-db-name is the name of the database of your project ( as the issue-tracker supports multiple projects , with multiple databases ... ) 
- list - is the name of the action to perform 
- item is the name of the item which ui controls you want to list ( could be issues,problems,questions, etc.
- ?&lt;&lt;params&gt;&gt; the additional url parameters used to control the look and behavior of the listing action, should the url params be omitted the full content of the item table with default ui look and behavior are displayed. 

#### 2.2.2. Successful execution
You can use the pick=col1,col2,col3 url parameter to select for only desired attributes.
You could filter the result the same way the filters for the select page work ( see bellow ). 

#### 2.2.3. Error handling for non-existent db
If the db provided in the url pattern does not exist an error is shown in the top of the page in a visually distinctive manner, after which the msg fades out. Example url:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/non_existent/list/yearly_issues?as=table&pick=id,status,name,description&page-size=5&page-num=1&where=status-eq-09-done

#### 2.2.4. Error handling for non-existent table
If the table requested does not exist an error is shown in the top of the page in a visually distinctive manner, after which the msg fades out. Example:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/prd_issue_tracker/list/non_existent_table?as=table&pick=id,status,name,description&page-size=5&page-num=1&where=status-eq-09-done

#### 2.2.5. Error handling for non-existent column
If the column requested does not exist an error is shown in the top of the page in a visually distinctive manner, after which the msg fades out.
Example:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/prd_issue_tracker/list/yearly_issues?as=table&pick=NON_EXISTENT,status,name,description&page-size=5&page-num=1&where=status-eq-09-done

#### 2.2.6. The "pick" url param
You can use the pick=col1,col2,col3 url parameter to select for only desired attributes to be show in the ui control used for listing.
The following url demonstrates this syntax:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/prd_issue_tracker/list/yearly_issues?as=table&pick=id,status,name,description&page-size=5&page-num=1&where=status-eq-09-done

#### 2.2.7. The "hide" url param
If you do not specify any attribute to pick, you could hide specific attributes by using the "hide=col1,col2,col3" syntax.
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/prd_issue_tracker/list/yearly_issues?as=established=guid,description

#### 2.2.8. The "with=col-operator-value" filter
You can filter the result of the query by using the "with=col-operator-value". The following examples demonstrates, which operators are supported.
An error message is shown if you do not use existing operator. 
The following url demonstrates this syntax:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/prd_issue_tracker/list/yearly_issues?as=table&pick=id,status,prio,name,weight,start_time,stop_time&page-size=5&page-num=1&where=status-eq-09-done

#### 2.2.9. The "where=col-operator-value" filter
You can filter the result of the query by using the "where=col-operator-value", which works exactly as the with operator, thus the following examples demonstrates, which operators are supported.
An error message is shown if you do not use existing operator. 

#### 2.2.10. Filtering with "like"
The filtering with the like operator translates to the SQL "like" operator- the "like-by=&lt;&lt;attr&gt;&gt;&like-val=&lt;&lt;val&gt;&gt; filtering, where &lt;&lt;attr&gt;&gt; stands for the name of the attribute to use the like operator. 
Example:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/prd_issue_tracker/list/yearly_issues?as=table&pick=id,status,name,description&page-size=5&page-num=1&like-by=status&like-val=03

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

### 2.6. The view page
The view page presents the data of a database table, having nested-set hierarchichal model partially or fully by the means of different controls

#### 2.6.1. The view-doc page
The view page presents the data of a database table partially or fully by using a document like structure. The 

### 2.7. The export url
The export url follows the same syntax naming conventions as the list page , but instead of presenting a list with the data it exports it in the specified with "as" url parameter format. 

#### 2.7.1. Export data to xls
To export data via the export url you could apply any of the listing parameters and replace the list web action with the export one and the as=&lt;&lt;control&gt; to the as=xls and the application will present you with a save file dialog with the desired data. 

#### 2.7.2. Export data to md
To export a document via the export url you could apply any of the listing parameters and replace the view web action with the export one and the as=&lt;&lt;control&gt; to the as=md and the application will present you with a save file dialog with a generated md document with the desired data

## 3. DEVOPS FEATURES AND FUNCTIONALITIES


### 3.1. Testability
The issue-tracker app has a good and improving all the time test coverage. You can all the tests in the application as follows:

#### 3.1.1. Perl syntax check call
You can check the perl syntax for each perl code file in the whole project by issuing the following shell call:

#### 3.1.2. Unit tests call
You can run the unit tests of the application by issuing the following single shell call:

#### 3.1.3. Integration tests call
You can run the integration tests of the application by issuing the following single shell call ( note that the integration tests will not start if you do not have pre-loaded the needed shell env vars for your project you want to operate on ). 

#### 3.1.4. Bash tests call
You can run all the bash functions in the tool by issuing the following command in the shell. 

### 3.2. Documentation
We consider up-to-date and complete documentation as being integral part of the application, thus each release must have the documentation updated to it's current set of features, functionalities and capabilities. 
You might argue that the amount of documentation is too big, yet the more you dive into the application the more you will justify it's existence by yourself. 

#### 3.2.1. Single shell call documentation generation - the generate-docs shell action
You can generate all the md and pdf docs by if you have a running instance of the isg-pub application accessible via single shell call by issuing the following command: 
The command will fail if there is a doc configured in the isg-pub database which has less than 100 lines. 

#### 3.2.2. Full documentation set
Every instance of the isssue-tracker application comes with up-to-date documentation set addressing the latest commit of the released version, namely the following documents:
 - Requirements
 - UserStories
 - Features and Functionalities
 - DevOps Guide
 - Installation and Configuration Guide

#### 3.2.3. Documentation's file formats
The documentation set of the application is available at least in the following file formats:
 - md - ( the master documentation format )
 - pdf - for distribution

The following formats MIGHT be also optionally available :
 - xls ( extracts from the isg-pub database ) 
 - sql ( dumps from the isg-pub database ) 
 - json ( extracts from the isg-pub database )  

### 3.3. Logging
Logging is implemented as follows:

#### 3.3.1. Bash logging
The issue-tracker.sh bash entry point loggs both to STDOUT and file. You cold easily defined your own log levels. 

#### 3.3.2. Perl logging
The perl logger could be configured to log to file and std outputs. 

### 3.4. Development efficiency increasing actions


#### 3.4.1. Support for different projects
The issue-tracker could be used against many different projects as soon as they have the needed file and dir structure , configuration file and dedicated db in the PostgreSQL. 
You could quickly fork a new project out of the issue-tracker instance by copying the 

#### 3.4.2. The "morph-dir" action
You can recursively search and replace strings in both file and dir paths and their contents ( as soon as they non-binary , txt files ) by issuing the following commands:

#### 3.4.3. Perl code syntax check
You can check the perl code syntax with the following command:

#### 3.4.4. Single call export of the md and pdf documentation files
Single call export of the md and pdf documentation files

## 4. SYSADMIN FEATURES AND FUNCTIONALITIES
The term feature usually denotes an UI usability, but as the sysadmins of the issue-tracker system must be technical people accustomed to the black screen in this context feature simply means a well memorizable shell call to perform a single action on the System they must operate. 

### 4.1. Enforced daily backups by "increase-date" action
The concept of daily backups in in-build in the functionalities of the issue-tracker application for all the projects data - that is you cannot operate the application without having daily backups, as every day a new working daily dir having the current day daily backup will be created!
The "increase-date" action copies the content of the latest daily data dir ( build by concentrating the mix_data_dir and the latest date string) with the current date in the file path. 
This IS the defacto way of making backup of the data ( including db dumps ) on daily basis, which could be quite easily made really robust for Unix admins with couple of cron scripts and symlinks ... 
The increase-date behaves for different projects in the same way, except of course using a different daily data dir root. 

### 4.2. Postgres db backup
You can backup any project database by using the following calls:

### 4.3. The "run-pgsql-scripts" action
You can create a preconfigured &lt;&lt;env&gt;&gt;_&lt;&lt;db_name&gt;&gt; postgres via a single shell call. The scripts will fail if any of the sql scripts have a syntax error - all the ddl events will be displayed in the STDOUT and stored in the shell log file for later audit.

### 4.4. The "run-mysql-scripts" action
You can create a preconfigured &lt;&lt;env&gt;&gt;_&lt;&lt;db_name&gt;&gt; in mariadb  via a single shell call. The scripts will fail if any of the sql scripts have a syntax error - all the ddl events will be displayed in the STDOUT and stored in the shell log file for later audit

#### 4.4.1. The "txt-to-db" action period handling ( deprecated)
Issues txt files are stored in a daily folder with the following naming convention:
&lt;&lt;project&gt;&gt;.&lt;&lt;current_date&gt;&gt;.&lt;&lt;period&gt;&gt;.txt
The tool knows to correctly fetch the issues files for the configured period ( by export period=weekly ) and copy its data in to the &lt;&lt;period&gt;&gt;_issue table. 

#### 4.4.2. The "txt-to-db" action ( deprecated)
You can load you issues from an "issues txt file" , having a specific syntax into a PosgtreSQL issue table, by issueing the shell.
This call with truncate the issue table from the db and convert all the issues data from the issues txt file into the issue table. 

#### 4.4.3. The "db-to-txt" action ( deprecated ) 
You can load your already stored in the issue table issues and load them into the same issues txt file

#### 4.4.4. The "db-to-txt" action with pre-defined sorting attribute ( deprecated )
You can load your already stored in the issue table issues and load them into the same issues txt file by using a pre-defined sorting attribute. 

#### 4.4.5. restart the morbo development server
You could restart the development morbo server by issuing the following syntax ( Note that each environment type starts within the pre-configured mojo_morbo_port if configured to do so):

#### 4.4.6. restart the hypnotoad production server
You could restart the production hypnotoad server by issuing the following syntax:

## 5. ETL / DATA INTEGRATION FEATURES AND FUNCTIONALITIES


### 5.1. The "db-to-xls" action against postgres
You can unload your already stored ANY xls table with unique id's and load them into a xls file. 

### 5.2. The "xls-to-db" action
You can load the latest produced xls file ( note as long as your xls sheet headers match the columns in your db table ANY xls is compatible )
You can control whether or not the loadable table should be truncated by setting the do_truncate_tables environment variable to 1 or 0. 

#### 5.2.1. The "xls-to-db" action without passing xls file
if you do not provide a xls file the newest xls file from the mix data dir will be used

#### 5.2.2. The "xls-to-db" action with nested-set mode against mysql
You could run the xls-to-db action against mysql or mariadb rdbms so that the issue-tracker will arrange your table to be compatible with the nested-set hierarchy model. 

### 5.3. The db-to-json shell action
You could make a backup of all your postgres tables data by running the db-to-json shell action as follows:

### 5.4. The json-to-db shell action
You could restore a previously created json files backup ( the json files are stored in the &lt;&lt;ProductInstanceDir&gt;&gt;/dat/json by default by issueing the following oneliner ( you need to have the web server up and running in order to fetch the list of tables too ) 

## 6. BACK-END API FUNCTIONALITIES


### 6.1. create web-action
An http client could create  a new row into ANY table by passing a bigint as the id.

#### 6.1.1. Successful execution
After 200 http returned code a new item is created in the database. Note that all non-null columns in the database MUST have default values, otherwise this call will always fail. This limitation is by design for now.

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

#### 6.2.1. Successful execution
An http client could update ANY table with a single column name by provinng the column name and the column value

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

#### 6.3.1. Successful execution
Once the post call is executed the item is deleted from the db.

#### 6.3.2. Error handling on non-existing db
If the db provided in the url pattern does not exist an error is shown. 

#### 6.3.3. Error handling on non-existing table
If the table provided in the url pattern does not exist an error is shown. 

### 6.4. select web action
An http-client could get the contents of ANY table of a database to which the issue-tracker has connectivity to ( ie not only the one configured in the application layer but also other databases in the same postgres instance)  by using the following syntax:

#### 6.4.1. successful execution
An http-client could get the contents of ANY table of a database to which the issue-tracker has connectivity to by calling the following url:
&lt;&lt;web-host&gt;&gt;:&lt;&lt;web-port&gt;&gt;/&lt;&lt;database&gt;&gt;/select/&lt;&lt;table-name&gt;&gt;

#### 6.4.2. apply multiple operators on the select properly
All the operators bellow could be combined and the result set is the one "translated" with the AND operator in the back-end side. 

#### 6.4.3. error handling for failed connect to db in the select web action
If the http-client points to a db to which the app layer does not have a connection ( might be a non-existing one ) the proper response is generated. 


#### 6.4.4. error handling for non-existent table in the select-tables web action
if a table does not exist a proper error msg containing response is generated.


#### 6.4.5. filter functionality in select table web action
The response cold be filtered by ANY attribute with any valid value. 


##### 6.4.5.1. successful execution
The response of the select web action could be filtered by using the syntax bellow:
Those are eventual transated to a where clause in the db select part. 



##### 6.4.5.2. error handling for wrong filtering syntax by missed fltr-by or fltr-va url params
If the request does not have either one of the url params the following response is produced. 


##### 6.4.5.3. error handling for non-existent filter name
If the syntax is correct but an non-existent filtering attribute is provided ( that is the table columns and the attribute name do not match ) the following error msg is returned: 


#### 6.4.6. Use pick url param functionality in select table web action
Works for both a single colum and a comma separated select of columns. Obeys the following syntax:


##### 6.4.6.1. successful execution
if the request contains the "pick" url parameter only the picked column values are selected. 


##### 6.4.6.2. error handling if a picked column does not exist
if a picked column does not exist the following error is displayed. 


#### 6.4.7. Use filtering with the like operator in select table web action
The response cold be liked by ANY attribute with any valid value. 


##### 6.4.7.1. successful execution for number types
The like operator could be used with numbers as well.

##### 6.4.7.2. successful execution for text types
The response of the select web action could be likeed by using the syntax bellow:
Those are eventual transated to a where clause in the db select part. 



##### 6.4.7.3. error handling for wrong  syntax in the filtering by the like operator by missed like-by or like-val url params
If the request does not have either one of the url params the following response is produced. 


##### 6.4.7.4. error handling for non-existent like table's attribute
If the syntax is correct but an non-existent like operator's attribute is provided ( that is the table columns and the attriute name do not match ) the following error msg is returned: 


#### 6.4.8. Filtering by using the "with" url param
You can filter the result of the query by using the "with=col-operator-value"

##### 6.4.8.1. Successful execution
The application selects only the rows matching the generated where &lt;&lt;column&gt;&gt; &lt;&lt;operator&gt;&gt; &lt;&lt;value&gt;&gt; , where the operator could be also the like operator ( set also if the value contains the % char ) 

##### 6.4.8.2. Error handling for non-existent column
If the column used does not exist an error is provided as follows:


#### 6.4.9. the hide operator in the select web action
Whenever a hide=&lt;&lt;col-name&gt;&gt; operator is applied the values and the column names of the column to hide are not displayed in the result. Use command to as the separator for listing multiple columns to hide. 


##### 6.4.9.1. successful execution for text types
The response of the url query presents all but the hidden attribute values.


##### 6.4.9.2. error handling for inexistent column to hide
If the column which values are requested to be hidden does not exist the proper error message is retrieved. 


### 6.5. select-tables web action
An http-client could get the select of all the tables of a database to which the issue-tracker has connectivity to ( that is not only the one configured in the application layer )


#### 6.5.1. successful execution
An http-client could get the select of all the tables of a database to which the issue-tracker has connectivity to


#### 6.5.2. error handling for failed connect to db in the select-tables web action
If the http-client points to a db to which the app layer does not have a connection ( might be a non-existing one ) the proper response is generated. 


### 6.6. Query web action
An http-client could query the name and description attributes for all the tables having those attributes by a keyword , which is translated to the sql like clause.

#### 6.6.1. successful execution
An http-client could get the contents of ANY table of a database to which the issue-tracker has connectivity to by calling the following url:
&lt;&lt;web-host&gt;&gt;:&lt;&lt;web-port&gt;&gt;/&lt;&lt;database&gt;&gt;/query?for=&lt;&lt;phrase-to-srch-for&gt;&gt;
For example: 
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/dev_issue_tracker/query?for=meta-data

#### 6.6.2. error handling on non-provided for operator
If the for operator is not provided an error is returned:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/dev_issue_tracker/query

#### 6.6.3. error handling for empty for url parameter
If the for url parameter is empty  is not provided an error is returned:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/dev_issue_tracker/query?for=

## 7. SECURITY FEATURES AND FUNCTIONALITIES


### 7.1. Fully open mode
Currently the default mode of any running issue-tracker application is "fully open", that is any user having access to the url of the application might perform any change from the ui. 

### 7.2. Basic authentication mode
A fully deployed and configured issue-tracker instance provides basic authentication mode for any project database it has access to allowing thus persons having the credentials of the system account used for the particular project database to have full read,write and delete access to the data of that instance, in a way preventing users not having access to those credentials to the application. 
It is worth noting that this basic authentication does not mean strict security requirements for business and personal data on the web.
For more info consult the BasicAuthPlus module docs  :
https://metacpan.org/pod/Mojolicious::Plugin::BasicAuthPlus#DESCRIPTION
 

