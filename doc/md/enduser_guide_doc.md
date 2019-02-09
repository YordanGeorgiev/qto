#  ENDUSER GUIDE
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
    * [2.2.7. table sorting](#227-table-sorting)
    * [2.2.8. table quick filtering](#228-table-quick-filtering)
    * [2.2.9. set table paging size](#229-set-table-paging-size)
    * [2.2.10. paging - setting the table's page number](#2210-paging--setting-the-table's-page-number)
    * [2.2.11. table sorting](#2211-table-sorting)
    * [2.2.12. Keyboard usability](#2212-keyboard-usability)
      * [2.2.12.1. Navigability of the list page with the keyboard](#22121-navigability-of-the-list-page-with-the-keyboard)
      * [2.2.12.2. Focus the quick search box](#22122-focus-the-quick-search-box)
      * [2.2.12.3. Undo the edit on a cell](#22123-undo-the-edit-on-a-cell)
    * [2.2.13. New item creation ( CREATE )](#2213-new-item-creation-(-create-))
      * [2.2.13.1. Successful execution](#22131-successful-execution)
      * [2.2.13.2. Error handling on db create error](#22132-error-handling-on-db-create-error)
    * [2.2.14. Single cell Inline-edit ( UPDATE )](#2214-single-cell-inline-edit-(-update-))
      * [2.2.14.1. Table columns resizing](#22141-table-columns-resizing)
      * [2.2.14.2. Contents for the table's cells](#22142-contents-for-the-table's-cells)
      * [2.2.14.3. Successful execution](#22143-successful-execution)
      * [2.2.14.4. Error handling on db update error](#22144-error-handling-on-db-update-error)
      * [2.2.14.5. Nulls handling](#22145-nulls-handling)
    * [2.2.15. Item deletion ( DELETE )](#2215-item-deletion-(-delete-))
      * [2.2.15.1. Successful execution](#22151-successful-execution)
      * [2.2.15.2. Error handling on delete error](#22152-error-handling-on-delete-error)
    * [2.2.16. List as print-table page](#2216-list-as-print-table-page)
  * [2.3. THE VIEW-DOC PAGE](#23-the-view-doc-page)
    * [2.3.1. Error handling for the view-doc page](#231-error-handling-for-the-view-doc-page)
    * [2.3.2. Successful page load](#232-successful-page-load)
    * [2.3.3. The right click menu](#233-the-right-click-menu)
  * [2.4. THE EXPORT URL](#24-the-export-url)
    * [2.4.1. Export data to xls](#241-export-data-to-xls)
    * [2.4.2. Export data to md](#242-export-data-to-md)




    

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

http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/qto/list/yearly_issues?as=grid&pick=id,status,name,description&page-size=5&page-num=1&where=status-eq-09-done

http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/tst_issue_tracker/list/yearly_issues?as=grid&pick=id,status,name,description&page-size=5&page-num=1&where=status-eq-09-done

Note the upper left corner of the page contains the name of your current project database. 

    # access the issue-tracker's project development database
    http://host-name:3000/qto/list/monthly_issues
    
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
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/qto/list/non_existent_table?as=table&pick=id,status,name,description&page-size=5&page-num=1&where=status-eq-09-done

    

##### 2.2.1.4. Error handling for non-existent column
If the column requested does not exist an error is shown in the top of the page in a visually distinctive manner, after which the msg fades out.
Example:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/qto/list/yearly_issues?as=table&pick=NON_EXISTENT,status,name,description&page-size=5&page-num=1&where=status-eq-09-done

    

#### 2.2.2. The "pick" url param
You can use the pick=col1,col2,col3 url parameter to select for only desired attributes to be show in the ui control used for listing.
The following url demonstrates this syntax:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/qto/list/yearly_issues?as=table&pick=id,status,name,description&page-size=5&page-num=1&where=status-eq-09-done

    

#### 2.2.3. The "hide" url param
If you do not specify any attribute to pick, you could hide specific attributes by using the "hide=col1,col2,col3" syntax.
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/qto/list/yearly_issues?as=established=guid,description

    

#### 2.2.4. The "with=col-operator-value" filter
You can filter the result of the query by using the "with=col-operator-value". The following examples demonstrates, which operators are supported.
An error message is shown if you do not use existing operator. 
The following url demonstrates this syntax:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/qto/list/yearly_issues?as=table&pick=id,status,prio,name,weight,start_time,stop_time&page-size=5&page-num=1&where=status-eq-09-done

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
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/qto/list/yearly_issues?as=table&pick=id,status,name,description&page-size=5&page-num=1&like-by=status&like-val=03

    # this example url will list all the monthly_issues items having the "bug" string in their "name" attribute:
    http://host-name:3000/qto/list/monthly_issues?as=table&like-by=name&like-val=bug

#### 2.2.7. table sorting
The listed table is sortable by clicking on the columns OR by navigating with the tab key on the keyboard on a column and hitting Enter. 
The sorted column is visually shown as the active one on page load:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/qto/list/yearly_issues?as=table&oa=prio&pick=id,status,prio,name,weight,start_time,stop_time&page-size=5&page-num=1&where=status-eq-09-done

    

#### 2.2.8. table quick filtering
You can filter the already presented part of the result set in the page by using the search textbox. This is only an ui type of filtering for the already loaded data. This type of filtering is different compared to the url parameters filtering by using the with url param syntax and it filters the already fetched from the db data-set, whereas the with=&lt;&lt;attribute&gt;&gt;&lt;&lt;operator&gt;&gt;&lt;&lt;value&gt;&gt; filtering does filter on the database side.
You could focus the quick search textbox by pressing the forward slash on your keyboard. 
The quick search box works instantaneously, thus hitting enter is not needed. 

    

#### 2.2.9. set table paging size
You can set the page size of the result set to be fetched from the database by using the "&page-size=&lt;&lt;page-size&gt;&gt;" url parameter or by clicking on the page sizes links right of the table search box. 

    

#### 2.2.10. paging - setting the table's page number
If the result-set requested is larger than the page size you can go to the next page number by using the "&page-num=&lt;&lt;page-num&gt;&gt;" url parameter. 
You could go to the next page number by clicking on the links just bellow the quick search textbox. The table control has UI for setting the table page number. 
The pager shows 10 pages at a "pager page" so getting to the end of hundreds of pages ( depending of course on your page size ) is comparably easy. 
You could quickly use the / char shortcut to focus to the quick search box and from there use the tab to quickly navigate to the desired page number. 

    

#### 2.2.11. table sorting
The listed table is sortable by clicking on the columns OR by navigating with the tab key on the keyboard on a column and hitting Enter. 
The sorted column is visually shown as the active one on page load:
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/qto/list/yearly_issues?as=etable&oa=prio&pick=id,status,prio,name,weight,start_time,stop_time&page-size=5&page-num=1&where=status-eq-09-done

    

#### 2.2.12. Keyboard usability
You can quickly traverse the cells of the table via the tab key, which does go over the non-editable items too ( the id's ) , so that you could quickly scroll the table as scrolling when the editable is in focus does not work. 
The whole table is easily scrollable whenever the cursor is on non-editable part of the table ( the id's column ) and whenever the last rows must be edited the page is scrolled so that the rows are situated in the middle and not the bottom of the screen. 

    

##### 2.2.12.1. Navigability of the list page with the keyboard
The order of the list-as-grid page has been arranged so that the ui user cuold cycly trough the whole table with the tab easily. 

    

##### 2.2.12.2. Focus the quick search box
You could focus the quick search by typing / IF you are not editing a cell. Thus the paging on the next cell is quite handy - as you could easily jump onto the quick search and with couple of tabs navigate to the next page. 

    

##### 2.2.12.3. Undo the edit on a cell
If you were on a cell and types some text without leaving it, but you change your mind you could simply press the Esc key, which will restore the original content of the cell and you could proceed by tab to the next cell. 

    

#### 2.2.13. New item creation ( CREATE )
A new item could be added to the table in the ui and thus in the db table by clicking the plus button above the table ( which uses the google material design ui ). 
The new button has a fixed positon, thus available during scrolling as well from the same position. 
The new button changes it's appears when focused via the keyboard, and can be pressed when in focus by hitting enter with the keyboard. 
To practice new items' creations and deletions to get confortable on the app's behaviour please use first the development instances of the issue-tracker project: 
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/qto/list/monthly_issues?as=grid&pick=id,status,prio,name,weight,start_time,stop_time&page-size=5&page-num=1

    

##### 2.2.13.1. Successful execution
After clicking the plus button the System adds the new row into the database table and presents it into the table ui AS THE FIRST ROW to emphasize the created row - that is the existing sort of the table is changed to the id column.
This behavior is not obvious if you have at the time of pressing the add-new button a valid search in the quick search box as the result set will most probably not show your new item as the filter is ongoing, this is rather bug, which for now is handled with the dimming of the add new button during an active search in the quick search box. 

    

##### 2.2.13.2. Error handling on db create error
If any error occurs while the creation an error msg is presented clearly with fading effect, which returns the error msg from the database. 
On invalid input the data is not created to the database and nothing is stored. 

    

#### 2.2.14. Single cell Inline-edit ( UPDATE )
The table can be edited inline so that the data is updated to the database. White space in the cells is preserved. 
To practice new items' creations updates and deletions to get confortable on the app's behaviour please use first the development instances of the issue-tracker project: 
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/qto/list/monthly_issues?as=grid&pick=id,status,prio,name,weight,start_time,stop_time&page-size=5&page-num=1

    

##### 2.2.14.1. Table columns resizing
You can resize the columns of the tables to a max size of 500 pixels by dragging only one text area. Note however that the textarea will NOT be resized bigger than the maximum width of the current column … 
For the estetics of the table a certain default values for certain columns' cotents widths are assumed.

    

##### 2.2.14.2. Contents for the table's cells
The table's cells should accept any UTF-8 characters including html entities. The textarea's width should adjust automatically till the width of the widest cell in the table column. 

    

##### 2.2.14.3. Successful execution
If the single cell inline-edit is successful no msg is presented and the data is updated to the database storage.
If the updated cell was part of the currently sorted column the ui is automatically adjusted to the new sort order ( for example if a numeric sort was applied and the cell had value of 9 with 1..9 range and the smallest to greatest was currently active if the new update is 1 the item will appear in the top of the listing.

    

##### 2.2.14.4. Error handling on db update error
If any error occurs while updating an error msg is presented clearly with fading effect, which returns the error msg from the database. 
On invalid input the data is not updated to the database and the old value in the cell is restored.

    

##### 2.2.14.5. Nulls handling
Nulls handling is somewhat problematic in ui. For now the behavior by convention is to leave a nullable record in the database as null, whether the cell of the ui table is left empty ( white space chars are also considered empty)

    

#### 2.2.15. Item deletion ( DELETE )
You could delete items by clicking the delete button in the beginning of every item. 
To practice new items' creations and deletions to get confortable on the app's behaviour please use first the development instances of the issue-tracker project: 
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/qto/list/monthly_issues?as=grid&pick=id,status,prio,name,weight,start_time,stop_time&page-size=5&page-num=1

    

##### 2.2.15.1. Successful execution
If the deletion is successful the item is removed both from the ui and from the database. 

    

##### 2.2.15.2. Error handling on delete error
If any error occurs while deleting the item an error msg is presented clearly with fading effect, which returns the error msg from the database. 
On invalid input the data is not updated to the database and the old value in the cell is restored.

    

#### 2.2.16. List as print-table page
The list as print-table page is aimed at producing quickly refined result-set from the database for a further copy paste or even print to paper. 
It has all the functionalities as the list as "table" page, without the filtering from the quick search box and without the ui for the pager and page-sizer -the url params for paging and page-sizing work, however. All the url params work as in the etable listing page. 
http://ec2-34-243-97-157.eu-west-1.compute.amazonaws.com:8080/qto/list/yearly_issues?as=print-table&pick=id,status,name,description&page-size=5&page-num=1&like-by=status&like-val=03

    

### 2.3. The view-doc page
The view page presents a hierarchical document with up-to 7 levels in the hierarchy in a clean and easily navigable format.
The page has the following 3 main type of elements:
 - headers - clicking on them scrolls the page to the header
 - descriptions - the content for each header
 - images - images to the descriptions
 - right menu - contains table of contents with navigable headers

    

#### 2.3.1. Error handling for the view-doc page
Should there be an error a dynamic snackbar is presented with the error message. The snackbar hides itself by default after 3.9 seconds ( set by default , but it could be pinned to the page by the user to view it properly / send it furter). 
Whenever an error occurs the show right menu button does not occur and no document is presented

    <<web-host>>:<<web-port>>/<<database>>/view/<<table-name>>?as=doc

#### 2.3.2. Successful page load
When the page is loaded all the content of the document is presented / according to the urls params / which are applying the same filtering as in the list page , but on the hierarchichal data-set …
The rigt menu, containing the table of contents of the document can be opened and closed and scrolled separately


    <<web-host>>:<<web-port>>/<<database>>/view/<<table-name>>?as=doc

#### 2.3.3. The right click menu
You can perform actions on any item by right-cliking the titles either from the document or fro mthe table of contents below

    

### 2.4. The export url
The export url follows the same syntax naming conventions as the list page , but instead of presenting a list with the data it exports it in the specified with "as" url parameter format. 

    <<web-host>>:<<web-port>>/<<database>>/export/<<table-name>>?as=xls

#### 2.4.1. Export data to xls
To export data via the export url you could apply any of the listing parameters and replace the list web action with the export one and the as=&lt;&lt;control&gt; to the as=xls and the application will present you with a save file dialog with the desired data. 

    <<web-host>>:<<web-port>>/<<database>>/export/<<table-name>>?as=xls

#### 2.4.2. Export data to md
To export a document via the export url you could apply any of the listing parameters and replace the view web action with the export one and the as=&lt;&lt;control&gt; to the as=md and the application will present you with a save file dialog with a generated md document with the desired data

    <<web-host>>:<<web-port>>/<<database>>/export/<<table-name>>?as=xls

