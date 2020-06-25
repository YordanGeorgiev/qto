#  QTO DEVOPS GUIDE
* [1. INTRODUCTION](#1-introduction)
* [2. GUIDING PRINCIPLE'S](#2-guiding-principle's)
  * [2.1. USE COMMON SENSE](#21-use-common-sense)
  * [2.2. PERSONAL RESPONSIBILITY](#22-personal-responsibility)
  * [2.3. ATTEMPT FOR 100% TEST COVERAGE TO ACHIEVE RELIABILITY](#23-attempt-for-100%-test-coverage-to-achieve-reliability)
  * [2.4. IT SHOULD JUST WORK](#24-it-should-just-work)
  * [2.5. NAMING CONVENTIONS](#25-naming-conventions)
  * [2.6. BE FRIENDLY TO ALL](#26-be-friendly-to-all)
  * [2.7. AIM FOR SIMPLICITY](#27-aim-for-simplicity)
  * [2.8. DO NOT ALLOW BROKEN WINDOWS](#28-do-not-allow-broken-windows)
  * [2.9. DO NOT ADD A COMMIT WITHOUT PASSING ALL THE REGRESSION TESTS](#29-do-not-add-a-commit-without-passing-all-the-regression-tests)
* [3. WAY OF WORKING AND PROCESSES IN THE QTO PROGRAM](#3-way-of-working-and-processes-in-the-qto-program)
  * [3.1. VERBAL COMMUNICATION, PHONE & VIDEO CONFERENCING](#31-verbal-communication-phone-&-video-conferencing)
  * [3.2. CHAT / IRC](#32-chat-/-irc)
  * [3.3. DEFINITION OF DONE](#33-definition-of-done)
  * [3.4. E-MAIL COMMUNICATION](#34-e-mail-communication)
  * [3.5. CONTINUOUS IMPROVEMENT BY ISSUES MANAGEMENT](#35-continuous-improvement-by-issues-management)
* [4. ETL OPERATIONS](#4-etl-operations)
  * [4.1. DB DATA BACKUP AND RESTORE](#41-db-data-backup-and-restore)
  * [4.2. RUN INCREASE-DATE ACTION](#42-run-increase-date-action)
  * [4.3. LOAD XLS ISSUES TO DB AND FROM DB](#43-load-xls-issues-to-db-and-from-db)
  * [4.4. DIRS NAMING CONVENTIONS](#44-dirs-naming-conventions)
* [5. NAMING CONVENTIONS](#5-naming-conventions)
  * [5.1. PRODUCT INSTANCE DIRECTORIES](#51-product-instance-directories)
  * [5.2. ROOT DIRS NAMING CONVENTIONS](#52-root-dirs-naming-conventions)
  * [5.3. DABASE NAMING CONVENTIONS](#53-dabase-naming-conventions)
* [6. SOURCE CODE MANAGEMENT](#6-source-code-management)
  * [6.1. CONFIGURE AND USE GIT ALWAYS BY USING SSH IDENTITIES](#61-configure-and-use-git-always-by-using-ssh-identities)
  * [6.2. AIM FOR TRACEABILITY BETWEEN USER-STORIES, REQUIREMENTS, FEATURES AND FUNCTIONALITIES](#62-aim-for-traceability-between-user-stories-requirements-features-and-functionalities)
  * [6.3. ZERO TOLERANCE FOR BUGS, ESPECIALLY CRASHES](#63-zero-tolerance-for-bugs-especially-crashes)
  * [6.4. ALWAYS START WITH A TEST UNIT CREATION](#64-always-start-with-a-test-unit-creation)
  * [6.5. BRANCH FOR THE CURRENT COMMON RELEASABLE BRANCH - FOR EXAMPLE V0.8.4](#65-branch-for-the-current-common-releasable-branch--for-example-v084)
  * [6.6. SYNCING CHANGES WITH THE ORIGINAL REPO](#66-syncing-changes-with-the-original-repo)
  * [6.7. INTEGRATION TESTING IN THE TST BRANCH](#67-integration-testing-in-the-tst-branch)
  * [6.8. PRODUCTION IN THE PRD BRANCH](#68-production-in-the-prd-branch)
  * [6.9. DEPLOYMENT TO THE CLOUD](#69-deployment-to-the-cloud)
  * [6.10. MASTER BRANCH - THE SINGLE TRUTH FOR CURRENT STABLE VERSION OF THE SOFTWARE](#610-master-branch--the-single-truth-for-current-stable-version-of-the-software)
* [7. SOURCE CODE STYLING](#7-source-code-styling)
  * [7.1. SPACES AND NOT TABS](#71-spaces-and-not-tabs)
  * [7.2. PERL SOURCE CODE STYLING](#72-perl-source-code-styling)
    * [7.2.1. Spacing after variable asignments](#721-spacing-after-variable-asignments)
    * [7.2.2. Set 3 spaces for a tab](#722-set-3-spaces-for-a-tab)
    * [7.2.3. Empty lines](#723-empty-lines)
* [8. TESTING](#8-testing)
  * [8.1. RUNNING UNIT TESTS](#81-running-unit-tests)
  * [8.2. CHECKING THE PERL SYNTAX](#82-checking-the-perl-syntax)
  * [8.3. RUNNING FUNCTIONAL TESTS](#83-running-functional-tests)
  * [8.4. RUNNING INTEGRATION TESTS](#84-running-integration-tests)
  * [8.5. USER-STORY CREATION](#85-user-story-creation)
* [9. FEATURE IMPLEMENTATION WORKFLOW](#9-feature-implementation-workflow)
  * [9.1. PROBLEM REGISTRATION](#91-problem-registration)
  * [9.2. REQUIREMENTS CREATION](#92-requirements-creation)
  * [9.3. ISSUE CREATION](#93-issue-creation)
  * [9.4. FEATURE BRANCH CREATION](#94-feature-branch-creation)
  * [9.5. CREATE A TEST-ENTRY POINT](#95-create-a-test-entry-point)
  * [9.6. IMPLEMENTATION OF PROOF OF CONCEPT ( OPTIONAL )](#96-implementation-of-proof-of-concept-(-optional-))
  * [9.7. PROTOTYPE IMPLEMENTATION ( OPTIONAL )](#97-prototype-implementation-(-optional-))
  * [9.8. UNIT AND / OR INTEGRATION TEST CREATION](#98-unit-and-/-or-integration-test-creation)
  * [9.9. IMPLEMENTATION ](#99-implementation-)
  * [9.10. DEPLOYMENT AND TEST TO THE TEST ENVIRONMENT](#910-deployment-and-test-to-the-test-environment)
  * [9.11. DEPLOYMENT AND TEST TO THE PRODUCTION ENVIRONMENT](#911-deployment-and-test-to-the-production-environment)
  * [9.12. QUALITY ASSURANCE ITERATION](#912-quality-assurance-iteration)
  * [9.13. DOD CHECK-LIST WALKTHROUGH](#913-dod-check-list-walkthrough)
  * [9.14. THE FEATURE OR FUNCTIONALITY CURRENT DESCRIPTION IS ADDED IN THE DOCS](#914-the-feature-or-functionality-current-description-is-added-in-the-docs)
    * [9.14.1. Regenerate the md docs](#9141-regenerate-the-md-docs)
    * [9.14.2. Regenerate the pdf docs](#9142-regenerate-the-pdf-docs)
    * [9.14.3. Regenerate the msft docs](#9143-regenerate-the-msft-docs)
  * [9.15. THE RELATED REQUIREMENT IS ADDED IN THE REQUIREMENTS DOCUMENT](#915-the-related-requirement-is-added-in-the-requirements-document)
  * [9.16. AT LEAST 2 TIMES PASSED FUNCTIONAL AND JS TESTS RUN ](#916-at-least-2-times-passed-functional-and-js-tests-run-)
  * [9.17. AT LEAST 2 TIMES PASSED INTEGRATION TESTS  IN EACH ENVIRONMENT INSTANCE](#917-at-least-2-times-passed-integration-tests-in-each-environment-instance)
  * [9.18. DEPLOYMENT TO THE TEST ENVIRONMENT](#918-deployment-to-the-test-environment)
  * [9.19. CHECK THAT ALL THE FILES IN THE DEPLOYMENT PACKAGE ARE THE SAME AS THOSE IN THE LATEST COMMIT OF THE DEV GIT BRANCH. ](#919-check-that-all-the-files-in-the-deployment-package-are-the-same-as-those-in-the-latest-commit-of-the-dev-git-branch-)
  * [9.20. RESTART THE APPLICATION LAYER](#920-restart-the-application-layer)
* [10. DEVBOX SETUP ( OPTIONAL )](#10-devbox-setup-(-optional-))
  * [10.1. THE TMUX TERMINAL MULTIPLEXER](#101-the-tmux-terminal-multiplexer)
  * [10.2. THE VIM IDE](#102-the-vim-ide)
* [11. DEBUGGING](#11-debugging)
  * [11.1. ENABLE DEBUGGING IN MOJOLICIOUS](#111-enable-debugging-in-mojolicious)
  * [11.2. ENABLE DEBUGGING IN DBI](#112-enable-debugging-in-dbi)
  * [11.3. DEBUGGING IN THE UI](#113-debugging-in-the-ui)
  * [11.4. DEBUGGING CSS](#114-debugging-css)
* [12. SECURITY](#12-security)
  * [12.1. AUTHENTICATION](#121-authentication)
    * [12.1.1. JWT based native authentication](#1211-jwt-based-native-authentication)
    * [12.1.2. Session based native authentication](#1212-session-based-native-authentication)
    * [12.1.3. RBAC based native authentication](#1213-rbac-based-native-authentication)
  * [12.2. AUTHORISATION](#122-authorisation)
    * [12.2.1. Generic role-based access control list based authorisation](#1221-generic-role-based-access-control-list-based-authorisation)
* [13. KNOWN ISSUES AND WORKAROUNDS](#13-known-issues-and-workarounds)
  * [13.1. THE RBAC BASED NATIVE AUTHORISATION](#131-the-rbac-based-native-authorisation)
  * [13.2. ALL TESTS FAIL WITH THE 302 ERROR](#132-all-tests-fail-with-the-302-error)
  * [13.3. MORBO IS STUCK](#133-morbo-is-stuck)
    * [13.3.1. Probable root cause](#1331-probable-root-cause)
    * [13.3.2. Kill processes](#1332-kill-processes)
    * [13.3.3. Problem description](#1333-problem-description)
  * [13.4. THE PAGE LOOKS BROKEN - PROBABLY THE NEW CSS IS NOT RE-LOADED](#134-the-page-looks-broken--probably-the-new-css-is-not-reloaded)
  * [13.5. THE VUE UI DOES NOT UPDATE PROPERLY ](#135-the-vue-ui-does-not-update-properly-)
  * [13.6. NGINX FAILS WITH 502 BAD GATEWAY ERROR AND PROBABLY CRASHES THE SITE](#136-nginx-fails-with-502-bad-gateway-error-and-probably-crashes-the-site)
  * [13.7. WHY HAVING ALL THE HASSLE WITH THIS DIRECTORY STRUCTURE - IS OVERKILL ?!!](#137-why-having-all-the-hassle-with-this-directory-structure--is-overkill-)
  * [13.8. THE NEW ENTRIES IN DROPBOX FK TABLES CANNOT BE SEEN](#138-the-new-entries-in-dropbox-fk-tables-cannot-be-seen)
* [14. FAQ](#14-faq)




    

## 1. INTRODUCTION


    

## 2. GUIDING PRINCIPLE'S
This section might seem too philosophical for a start, yet all the development in the qto has ATTEMPTED to follow the principles described below. If you skip this section now you might later on wander many times why something works and it is implemented as it is ... and not "the right way". 
Of course you are free to not follow these principles, the less you follow them the smaller the possibility to pull features from your instance(s) - you could even use the existing functionality to create a totally different fork with different name and start developing your own toll with name X - the authors give you the means to do that with this tool ... , but if you want to use and contribute to THIS tool than you better help defined those leading principles and follow them. 

    

### 2.1. Use common sense
Use common sense when applying all those principles. Of course they are not engraved in stone and you should be flexible enough for the actual situation, problem, issue etc.

    

### 2.2. Personal responsibility
Any given instance of the qto should have ONE and only ONE person which is responsible at the end for the functioning of THE instance - so think carefully before attempting to take ownership of an instance. The author(s) of the code are not responsible for the operation, bugs or whatever happens to a new instance. As a responsible owner of an instance you could create, share and assign issues to the authors of the source code, yet there is no Service Level Agreement, only openly stated attempt to assist when possible.
Qto is design to make version updates fully vertically integrated and as automated as possible, yet YOU will be responsible for increasing the versions, taking backups, applying database migrations and so on ... 

    

### 2.3. Attempt for 100% test coverage to achieve reliability
The more you increase your test coverage the greater the confidence that the code will work as expected. 
Do not write a single function without first implementing the testing call for that function - this has been proven really, really difficult, yet the more features are added the less the time wasted in troubleshooting of bugs and unexpected behaviour when proper testing is implemented. 
Testing ensures the consistency and future expandability of the functionalities. Our velocity increases with the WORKING features and functionalities added over time. ANYTHING, which is not working, or not even sure about how it should be working MUST be [fixed](fixed/deleted.) 

    

### 2.4. It should just work
Any instance of the QTO should simply work as promised - no less, no more. 
Any instance is the combination of code, configurations, binaries in the System and data - that is the instance you are using should just work for the set of functionalities promised. 

    

### 2.5. Naming conventions
All the names used in the code and the configurations MUST BE human readable and expandable - that is name the objects from the greater realm to the smaller - for example &lt;&lt;env&gt;&gt;_&lt;&lt;db_name&gt;&gt; , because the concept of operational IT environments ( dev , test , qas , prd ) is broader than the concept of a application databases . 
Before you start a new concept for example code for a new run-time spent some time first for some initial planning:
 - how many objects are there going to be after 10 years !!
 - how about searching through those objects - how easy will it be 
 - are you naming data, configuration, binary or source code objects ?

    

### 2.6. Be friendly to all
Especially to technical personnel, as you cannot achieve user-friendliness for the end-users unless your developers and technical personnel are happy while interacting with your artefacts. 

    

### 2.7. Aim for simplicity
Things should be as simple as possible, but not simpler - if Einstein said it it makes sense - having lost so much time in endless loops of IT complexity - the older we get the more it gets more rational. 

    

### 2.8. Do not allow broken windows
A broken windows is any peace of code or documentation, which is hanging around not included in the integration tests suite and not matching the most up-to-date standards for work deliverables. Either bring it up to the standard level or get rid of it. 
As soon as you find a bug, write a test for it, if you can't create the needed testing setup invest in time developing the needed skills.

    

### 2.9. Do not add a commit without passing ALL the regression tests
Even in your personal branch. Really. Because after the application has surpassed the mark of having 200 000 lines of code the complexity added to a "broken machine" WILL NOT justify the breaking of an existing feature. If you do not consider the feature / functionality tested as important than feel free to REMOVE it ( both implementations AND tests ) in that very same commit.

    

## 3. WAY OF WORKING AND PROCESSES IN THE QTO PROGRAM
A project represents a single, focused endeavour, whereas a program might be even a collection of projects, with ongoing activities and not a clear, definite, SINGLE outcome. 
Qto is more of a program with not strictly defined end-product and less of a project, so whenever you see the "qto project" think more for a "definite milestone of the qto program".
This section describes the way of working within a team working on the qto program. 
The work on the qto project is conducted by using the Scrum methodology, thus the Scrum

    

### 3.1. Verbal communication, phone & video conferencing
Time is money. Let's assume that a meeting of 7 IT Consultants charging 100 $ per hour should have meeting for 1.5 hours - that is an investment from the paying organisation point of view for 1050 $. Let's assume that 2 guys are late 5min, 1 guy 10min and during that time 1 guy tells about the wonderful trip he had during the weekend and the latest sport events ... so the meetings ACTUALLY starts after the first 20 min ( about 1/3 of the investment is lost already).  

    

### 3.2. Chat / IRC
Should you want a quicker respond than 2 hours use a chat tool. Do not expect people to answer you straight away, it takes 5 to 20 min to reach the most productive flow state, thus not answering your question might be the more productive option from the point of view of the organisation.

    

### 3.3. Definition of Done
Each issue must have a tangible artifact. An issue without tangible artifact is a thought thrown in the air.
The DoD must be iterated and updated during each Sprint Review. 

    

### 3.4. E-mail communication
Do not use e-mail communication for code style, testing, developing etc. Issues which could be achieved with the code review interface of the source code management system. 
Before writing an e-mail think first could you find a way to avoid writing it at all. 
Do not expect answer of your e-mail within 2 hours. 
Use e-mail when you have to get an written evidence on agreed matters, which might cause later on discussions. 

    

### 3.5. Continuous improvement by issues management
At the end of the month you should move the completed issues to the yearly_issues table as follows:


    

## 4. ETL OPERATIONS


    

### 4.1. Db data backup and restore
Check maintenance_guide_doc-23

    

### 4.2. Run increase-date action
You track the issues of your projects by storing them into xls files in "daily" proj_txt dirs. 
Each time the day changes by running the increase-date action you will be able to clone the data of the previous date and start working on the current date.

    bash src/bash/qto/qto.sh -a increase-date

### 4.3. Load xls issues to db and from db
To load xls issues to db run the following one-liner:

    bash src/bash/qto/qto.sh -a xls-to-db
    
    

### 4.4. Dirs naming conventions
The dir structure should be logical and a person navigating to a dir should almost understand what is to be find in there by its name. 

    

## 5. NAMING CONVENTIONS


    

### 5.1. Product instance directories


    

### 5.2. Root Dirs naming conventions
The root dirs and named as follows:
bin - contains the produced binaries for the project
cnf - for the configuration
dat - for the data of the app
lib - for any external libraries used
src - for the source code of the actual projects and subprojects

    

### 5.3. Dabase naming conventions
Each database must start with its environment prefix - dev, tst or prd. And yes this is so fundamentally in-built into QTO that changing this naming convention will definitely destroy your application.

    

## 6. SOURCE CODE MANAGEMENT
The QTO is a derivative of the wrapp tool - this means that development and deployment process must be integrated into a single pipeline. 

    

### 6.1. Configure and use git ALWAYS by using ssh identities
You probably have access to different corporate and public git repositories. Use your personal ssh identity file you use in GitHub to push to the QTO project. The following code snippet demonstrates how you could preserve your existing git configurations (even on corporate / intra boxes), but use ALWAYS the personal identity to push to the QTO.

    # create the company identity file
    ssh-keygen -t rsa -b 4096 -C "first.last@corp.com" -f ~/.ssh/id_rsa.corp.`hostname -s`
    
    ~/.ssh/id_rsa.corp.`hostname -s` 
    # copy paste this one into your githubs, private keys
    
    # set alias for the git command to avoid overtyping ...
    alias git='GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa.corp.`hostname -s` " git'
    
    # clone a repo 
    git clone git@git.in.corp.com:corp/project.git
    
    export git_msg="my commit msg with my corporate identity, explicitly provide author"
    git add --all ; git commit -m "$git_msg" --author "MeFirst MeLast <first.last@corp.com>"
    git push 
    
    # and verify 
    clear ; git log --pretty --format='%h %ae %<(15)%an ::: %s

### 6.2. Aim for traceability between user-stories, requirements, features and functionalities
Once the issues are defined and you start working on your own branch which is named by the issue-id aim to map one on one each test in your code with each listed requirement in confluence and / or JIRA. 

    

### 6.3. Zero tolerance for bugs, especially crashes
As soon as bugs are identified and reproduceable, register them as issues and resolve them with prio ( aka priority ) 1.
After resolution, think about the root cause of the bug, the mear fact that the bug occurred tells that something in the way of working has to be improved , what ?!
Bugs are like broken windows the more you have them the faster the value of your building will be down to zero. 

    

### 6.4. ALWAYS Start with a test unit creation
Do not ever never write code without starting first the unit test on how-to test the code. Period. 
This is he only way to avoid braking old functionalities when the application code base grows larger. 
Each time a new bug is found fix it by adding new Unit Test!

    

### 6.5. Branch for the current common releasable branch - for example v0.8.4
No code should be merged into the development branch without broad testing coverage and approval from the owner of the instance - as the owner of the instance is at the end responsible personally for the whole instance, since once a change has been merged to develop it must pass as quickly as possible to tst, prd and master.
Each developer committing to the development branch MUST rebase as frequently as possible from the dev branch to avoid time waste aligning the feature branches to the common dev branch.

    # put your product instance configuration files into the stash temporarily
    git stash 
    
    # check the current wip version of the qto application
    git checkout v0.8.4
    
    # create a new branch from the v0.8.3 branch AND set the correct name of the branch
    # by using the issues-id and use for the name of the branch the copy paste from the issue
    # name by replacing the spaces and other special chars with - dashes ... 
    git checkout -b v0.8.4-200402120006-fix-bug-for-wrong-order-in-env-file
    
    # apply back your configuration
    git stash pop
    
    # modify the code and strife to modify code ONLY related to THIS issue !!!
    # set the git msg 
    export git_msg="qto-200402120006 fix bug for wrong order in .env file"
    
    # push the changes ( you would have to have the git alias set !!!)
    git add --all ; git commit -m "$git_msg" --author "Yordan Georgiev <yordan.georgiev@gmail.com>" ; git push ;
    
    # have to set a new upstream when pushing for the first time 
    git push --set-upstream origin v0.8.4-fix-bug-for-wrong-order-in-env-file
    
    # set the 
    git stash
    git branch -a
    git checkout v0.8.4
    
    git pull
    
    git merge v0.8.3-200402120006-fix-bug-for-wrong-order-in-env-file -X theirs
    git push
    git stash pop
    git push 
    clear ; git log --pretty --format='%h %<(15)%ae %<(15)%an ::: %s'

### 6.6. Syncing changes with the original repo
If you have forked a GitHub repo you want to sync with you will need to  :
 - add it to your git remotes ( if it is not added yet ) 
 - add the upstream repository ( or update the url if was existing )
 - get the upstream changes to your local branch(es)
 - push to your remote remote branch(es)


    #use git remote -v to see the currently configured repositories you are working with:
    git remote -v
    
    #include your own repo:
    git remote set-url origin https://github.com/%YourName%/qto.git
    
    #add https://github.com/YordanGeorgiev/qto/ as an upstream repository:
    git remote add upstream https://github.com/YordanGeorgiev/qto/qto.git
    
    #in case you already have an upstream configured, you can update the URL instead of creating it:
    git remote set-url upstream https://github.com/YordanGeorgiev/qto.git
    
    #ensure that origin is set to your repo and upstream is set to the main QTO repo:
    git remote -v 
    
    #fetch all the changes from upstream to your local files:
    git fetch upstream
    
    #check that you are on the desired branch, usually it is master:
    git checkout master
    
    #merge the changes from the upstream/master into your local master branch. 
    #it is also possible to specify a different upstream branch other than master, for example upstream/v0.8.4:
    git merge upstream/master
    
    #push or force push to your Github master branch:
    git push origin master
    

### 6.7. Integration testing in the tst branch
The tst branch is dedicated for integration testing of all the tests, the deployment, performance testing and configuration changes. Should you need to perform bigger than a small hotfix changes you must branch the tst branch into a separate dev--feature branch and re-run the integration testing and approval all over. 
At the end all the integration tests should be behind this shell call. 

    bash src/bash/qto/qto.sh -a run-integration-tests

### 6.8. Production in the prd branch
The prd branch is the one deployed to the production environment. This code is NOT straight merged into the master branch , but after certain time depending on the dynamic of the tool with bugless operation merged. 

    

### 6.9. Deployment to the cloud
//

    

### 6.10. master branch - the single truth for current stable version of the software
Once the business has approved a new version - it should be moved to the master branch and all other branches including the separate feature branches MUST be REBASED ( and NOT MERGED !!! ) from the master branch to accommodate any hotfixes, configuration related adjustments or quick bug fixes detected in production only. 

    

## 7. SOURCE CODE STYLING
This section is going to be the one to be debated and hated the most ...

    

### 7.1. Spaces and not tabs


    

### 7.2. Perl source code styling


    

#### 7.2.1. Spacing after variable asignments
You might want to use spacing after variable assignments if you have a lot of variables assigned ... it improves the readability of the code ....

    

#### 7.2.2. Set 3 spaces for a tab
Why ????!!!!!
Because 2 is too little and 4 is too much and line legth of 80 to 100 is too small to be wasted or packed with too much stuff ... 
Also 3 is a magical number ...

    

#### 7.2.3. Empty lines
Empty lines improve readability, when used in a standard way: 
Use 2 empty lines between functions and 1 empty line between logical blocks within functions.

    

## 8. TESTING
Why the testing section is before the coding one ??!!!
Because in order for you to be able to add more functionalities to the qto application you MUST first understand how to ensure that you are not causing regression bugs - aka the application "works" according to one of the main principle - it must just work, no more and no less.

    

### 8.1. Running unit tests


     bash src/bash/qto/qto.sh -a run-unit-tests

### 8.2. Checking the perl syntax
Before running any tests check the perl syntax ... as follows:

    bash src/bash/qto/qto.sh -a check-perl-syntax
    # starts echoging something like this...
    ...
     ::: running: cd src/perl/qto ; perl -MCarp::Always -I /hos/opt/qto/qto.0.8.1.dev.ysg/src/perl/qto -I /hos/opt/qto/qto.0.8.1.dev.ysg/src/perl/qto/lib -wc "./t/lib/Qto/App/Utils/TestInitiator.t" ; cd -

### 8.3. Running functional tests


     bash src/bash/qto/qto.sh -a run-functional-tests

### 8.4. Running integration tests


     bash src/bash/qto/qto.sh -a run-integration-tests

### 8.5. User-Story creation
Use the following template while creating the user story:
As an &lt;&lt;role&gt;&gt;
In order to &lt;&lt;achieve something/ bring value by&gt;&gt; 
I want to to be able to &lt;&lt;action-description&gt;&gt; 

    

## 9. FEATURE IMPLEMENTATION WORKFLOW
This section describes the common workflow for implementing a feature. 
As in other places the main principle to follow is "use common sense" , thus try to follow this workflow for feature implementation, but challenge it as soon as it defies the common sense. 

    

### 9.1. Problem registration
Should you have problems or bugs, or even questions register them first into the qto application. Problems are often hint from the reality on the actual work, which has to be performed, yet problems are not yet issues. Issues are meant to be derived from problems in structured way, so that the deliverable of each issue must be testable and distinguishable, as well as the work.
The reason the problem registration is on top of this subsection is the fact that bugs and problems should be dealt with higher priority, to minimise the technical debt of the application.

    

### 9.2. Requirements creation
Depending on the size and agility of your organisation formal requirements exist.

    

### 9.3. Issue creation
Even if you do not have a defined documentation artefact - create a new issue, which could be the start for a an action affecting the run-state, configuration , data , features and functionalities or other aspects of the qto application. 
An issue could be a bug, a request for a feature or even simply an undefined combination of problems and solution which could quickly be formalised by defining a new requirement, another issue, feature-request

    

### 9.4. Feature branch creation
Create the feature branch by using the following naming convention:
 - dev--&lt;&lt;short-feature-title&gt;&gt;

    git branch -a
    * dev
    dev--qto-18050801-add-order-by-in-select-ctrlr
    master
    ...
    
    

### 9.5. Create a test-entry point
Even the smallest proof of concept needs a small test-entry point. Start always with the testing and the testing scalability in mind. 

    

### 9.6. Implementation of Proof of Concept ( optional )
Aim to create a small POC for the new concept, feature or functionality - for example a page having a lot of hardcoding, which constrains the scope for ONLY this new thing. 
POC small "projects" are extremely useful when new ui controls are to be integrated into the common base - check the public/poc directory for the the subdirectories containing the iterative approaches while introducing different controls into the project.
Strive however to use the same naming convention, and implement with future integrations within the end truly dynamic code. 

    

### 9.7. Prototype implementation ( optional )
The same instructions as the POC apply, but the prototype contains a certain and broader level of integration with the dynamic parts of the System.

    

### 9.8. Unit and / or integration test creation
Strive to create always unit and / or integration test(s).

    

### 9.9. Implementation 
Implement by quick unit test runs. Constantly improve both the code , configuration changes and the test code. Think about re-usability and scalability during implementation, but do not overgeneralise.

    

### 9.10. Deployment and test to the test environment
Deploy to the test environment a new instance with the current version as follows:

    # deploy to the tst environment
    bash src/bash/qto/qto.sh -a to-tst
    
    # go to the product instance dir of the tst env for this version
    cd ../qto.<<version>>.tst.<<owner>>
    bash src/bash/qto/qto.sh -a run-integration-tests
    bash src/bash/qto/qto.sh -a run-functional-tests

### 9.11. Deployment and test to the production environment
Repeat the same to the production environment. As the current version is usually work in progress your stable version will be one level below and thanks to the architecture of the tool you could test in the production environment ( as soon as you have proper configuration ).

    

### 9.12. Quality assurance iteration
This phase might be longer depending on the feature. Some of the features stay in quality assurance mode EVEN if they have been deployed to production.

    

### 9.13. DoD check-list walkthrough
Perform the DoD checklist as follows.

    

### 9.14. The feature or functionality current description is added in the docs
The feature or functionality current description is added in the Features and Functionalities document. Check also the end user guide - it might to be changed as well. It might pay off to revisit the ReadMe as well, which is the landing and more of a "selling" point.

    

#### 9.14.1. Regenerate the md docs


    # instead of the product instance dir you could also use different documents root 
    export docs_root_dir=/hos/opt/csitea/qto/qto.0.7.7.dev.ysg
    # Action !!!
    bash src/bash/qto/qto.sh -a generate-md-docs

#### 9.14.2. Regenerate the pdf docs
Regenerate the pdf docs by issuing the following one-liner

    # instead of the product instance dir you could also use different documents root 
    export docs_root_dir=/hos/opt/csitea/qto/qto.0.7.7.dev.ysg
    
    bash src/bash/qto/qto.sh -a generate-pdf-docs

#### 9.14.3. Regenerate the msft docs
Regenerate the Microsoft docx files by issuing the following shell one-liner:

    # instead of the product instance dir you could also use different documents root 
    export docs_root_dir=/hos/opt/csitea/qto/qto.0.7.7.dev.ysg
    # Action !!!
    bash src/bash/qto/qto.sh -a generate-msft-docs

### 9.15. The related requirement is added in the requirements document
The related requirement is added in the requirements document - there might be one or more requirements added. 

    

### 9.16. At least 2 times passed functional and js tests run 
Use the following shell actions ( Note that since v0.6.7 as authentication is required for most of the web-actions the QTO_ONGOING_TEST environmental variable has to be set to 1 to run those separately) :

    bash src/bash/qto/qto.sh -a run-js-tests
    bash src/bash/qto/qto.sh -a run-functional-tests

### 9.17. At least 2 times passed integration tests  in each environment instance
At least 2 times passed unit tests run in each environment instance - run the unit tests at least twice per environment. Should the run behave differently start all over from dev. Since v0.6.7 as authentication is required for most of the web-actions the QTO_ONGOING_TEST environmental variable has to be set to 1 to run those separately. 

    bash src/bash/qto/qto.sh -a run-integration-tests

### 9.18. Deployment to the test environment
Deploy to the test environment as shown in the code snippet below. Re-run the tests via the tests shell actions. 

    # deploy to the tst environment
    bash src/bash/qto/qto.sh -a to-tst
    
    # go to the product instance dir of the tst env for this version
    cd ../qto.<<version>>.tst.<<owner>>
    

### 9.19. Check that all the files in the deployment package are the same as those in the latest commit of the dev git branch. 
Deploy to the test environment as follows:

    # deploy to the tst environment
    bash src/bash/qto/qto.sh -a to-tst
    
    # go to the product instance dir of the tst env for this version
    cd ../qto.<<version>>.tst.<<owner>>
    

### 9.20. restart the application layer
Well just chain the both commands. 

    bash src/bash/qto/qto.sh -a mojo-morbo-stop ; bash src/bash/qto/qto.sh -a mojo-morbo-start

## 10. DEVBOX SETUP ( optional )
Every developer has his/her own development setup - this section is completely optional - your setup might be much more developed than the one suggested here ... You might find it 

    # run the automatic personal setup
    curl https://raw.githubusercontent.com/YordanGeorgiev/ysg-confs/master/src/bash/deployer/setup-bash-n-vim.sh | bash -s yordan.georgiev@gmail.com

### 10.1. The tmux terminal multiplexer
In this setup the tmux.conf contains all the instructions on the shortcut mappings, which enable quick navigation from one UI terminal window to multiple sessions with multiple windows etc. ...

    cat ~/.tmux.conf

### 10.2. The vim IDE
Once again we DO NOT encourage "religious wars", if you happen to be using or interested about the setup used for development, check the .vimrc at the root of the project, which will point you to all the plugins, shortcuts and settings used.

    # to check the syntax in the current file:
    :make
    
    # to check the syntax in the whole project from the proj root:
    bash ./src/bash/qto/qto.sh -a check-perl-syntax

## 11. DEBUGGING
Debugging is bad - it almost means that you have already lost the battle with the complexity of the code and MUST slow down to grasp what is actually happening ... 
But .. if you are already here than use the following hints ...

    

### 11.1. Enable debugging in Mojolicious
Set the env var(s) and restart morbo.
Check the following list of the Mojolicous env vars:
https://github.com/mojolicious/mojo/wiki/%25ENV

    # stop the application layer run-time if it is already running
    bash src/bash/qto/qto.sh -a mojo-morbo-stop
    
    # set the env var
    export MOJO_MODE=development
    # ... or any other of the variables above ...
    
    # restart the application layer 
    bash src/bash/qto/qto.sh -a mojo-morbo-start

### 11.2. Enable debugging in DBI
Set the DBI_TRACE env variable and restart the application layer. Check the dbitrace.log for your exact statement.

    # stop the application layer run-time if it is already running
    bash src/bash/qto/qto.sh -a mojo-morbo-stop
    
    # set the env var
    DBI_TRACE=1=dbitrace.log
    export DBI_TRACE
    
    # restart the application layer 
    bash src/bash/qto/qto.sh -a mojo-morbo-start

### 11.3. Debugging in the UI
The  mojo *html.ep DO contain a lot of JavaScript code, which IS RUN on the client AFTER it is run on the server side, thus the good old console.log or console.error work ... Quite often it makes sense to debug large JS objects, especially those related to VueJS.


    console.log(this.$parent)
    console.log("what exactly my parent control contains")
    console.log("todo:<<me>> remember to remove this ^^^")
    // ^^^ this one might seem like overkill , BUT you will be amazed
    // how-often you will have more than 5 console.log statements, which 
    // you would have to hunt down, after the completion of the feature by:
    find . -type f -name '*.html.ep' -exec grep -nHi console.log {} \;

### 11.4. Debugging css
Css editing IS time consuming activity. IMPORTANT !!! Chrome checkbox in the Networks "Disable cache" is buggy and unreliable - the ONLY way to clear the cache of a site you are performing css changes to actually see the changes is : 
 - F12 - to open DevTools
 - right-click on the reload , button and choose - "Clear cache and Hard Reload "
The other alternative is to open a new tab with the same url from inkognito mode ( which is also proven to be not 100% reliable ... )

    

## 12. SECURITY


    

### 12.1. Authentication
You might want to refresh the following security related links from time while reading this section:

http://self-issued.info/docs/draft-jones-json-web-token-06.html
https://metacpan.org/pod/Mojo::JWT
https://tools.ietf.org/html/rfc6749#section-1.5

    

#### 12.1.1. JWT based native authentication
Theory chk the following links:
http://self-issued.info/docs/draft-jones-json-web-token-06.html
https://metacpan.org/pod/Mojo::JWT
https://tools.ietf.org/html/rfc6749#section-1.5

    

#### 12.1.2. Session based native authentication
The session based authentication works basically as follows:
 - non-authenticated users requests a resource from the application layer
 - the application layer , runs the controller specified in the route
 - each controller is derived from the BasedController, which has the isAuthenticated metho
 - which returns 1 or 0 based on Mojo::Session stored data

So as of v0.7.8 - no app_roles, no permissions are implemented - the users are either authenticated or not. Once authenticated they can CRUD anything they have access to from the UI.

    

#### 12.1.3. RBAC based native authentication
The RBAC based native authentication works as follows:
- during start-up or meta-data reload the Guardian component saves the RBAC list into the Redis
- the User authenticates against the System via the login
- The System grants the list of app_roles to the JWT token of the user

    

### 12.2. Authorisation
As of v0.8.1 the Roles-Based Access Control List is being implemented. You might want to refresh your RBAC theoretical skills:
https://searchsecurity.techtarget.com/definition/role-based-access-control-RBAC

    

#### 12.2.1. Generic role-based access control list based authorisation
Start by defining your app_roles in the list/app_roles page. Keep the number of app_roles in the beginning to the absolute minimum - you could easily re-do the whole RBAC list re-population later on.
Who has access to what is defined in the following table: app_items_roles_permissions. 
You could initially load this table by running the following scripts below. 
https://stackoverflow.com/a/58009983/65706

    # populate the list of tables into the app_items table
    psql -d dev_qto < /src/sql/pgsql/scripts/admin/populate-app_items.sql
    
    # populate the items app_roles_permissions
    psql -d dev_qto < src/sql/pgsql/scripts/admin/populate-app_items_roles_permissions.sql

## 13. KNOWN ISSUES AND WORKAROUNDS


    

### 13.1. The RBAC based native authorisation
The RBAC based native authentication works as follows:
 - during start-up or meta-data reload the Guardian component saves the RBAC list into the Redis
 - the User requests a resource from the System
 - The Guardian component takes the role claims from the Users JWT
 - The Guardian component builds the role-page resource id and checks that it exists from the RBAC list in Redis
 - if the request role-page resources id exists the Guardian passes the User to fetch the resource
 - if the request role-page resource id DOES NOT exist : 
    -- the Guardian redirects the user to the login page if the user is not authenticated
    -- the Guardian redirect the user to the search / home pager if the user is authenticated

    

### 13.2. All tests fail with the 302 error
 This one is actually a bug ... all the tests not requiring non-authentication mode should set it in advance ...

    # disable authentication during testing
    export QTO_NO_AUTH=1
    
    # call the test once again
    perl src/perl/qto/t/lib/Qto/Controller/TestHiCreate.t

### 13.3. Morbo is stuck


    

#### 13.3.1. Probable root cause
This one occurs quite often , especially when the application layer is restarted, but the server not 

    # the error msg is 
     [INFO ] 2018.09.14-10:23:14 EEST [qto][@host-name] [4426] running action :: mojo-morbo-start:doMojoMorboStart
    (Not all processes could be identified, non-owned process info
     will not be shown, you would have to be root to see it all.)
    tcp        0      0 0.0.0.0:3001            0.0.0.0:*               LISTEN      6034/qto
    tcp        0      0 0.0.0.0:3002            0.0.0.0:*               LISTEN      7626/qto
    Can't create listen socket: Address already in use at /usr/local/share/perl/5.26.0/Mojo/IOLoop.pm line 130.
     [INFO ] 2018.09.14-10:23:16 EEST [qto][@host-name] [4426] STOP FOR qto RUN with:
     [INFO ] 2018.09.14-10:23:16 EEST [qto][@host-name] [4426] STOP FOR qto RUN: 0 0 # = STOP MAIN = qto
    qto-dev ysg@host-name [Fri Sep 14 10:23:16] [/vagrant/opt/csitea/qto/qto.0.4.9.dev.ysg] $

#### 13.3.2. Kill processes
List the running perl processes which run the morbo and kill the instances

    ps -ef | grep -i perl
    
    # be carefull what to kill 
    kill -9 <<proc-I-know-is-the-one-to-kill>>

#### 13.3.3. Problem description
This one occurs quite often , especially when the application layer is restarted, but the server not 

    # the error msg is 
     [INFO ] 2018.09.14-10:23:14 EEST [qto][@host-name] [4426] running action :: mojo-morbo-start:doMojoMorboStart
    (Not all processes could be identified, non-owned process info
     will not be shown, you would have to be root to see it all.)
    tcp        0      0 0.0.0.0:3001            0.0.0.0:*               LISTEN      6034/qto
    tcp        0      0 0.0.0.0:3002            0.0.0.0:*               LISTEN      7626/qto
    Can't create listen socket: Address already in use at /usr/local/share/perl/5.26.0/Mojo/IOLoop.pm line 130.
     [INFO ] 2018.09.14-10:23:16 EEST [qto][@host-name] [4426] STOP FOR qto RUN with:
     [INFO ] 2018.09.14-10:23:16 EEST [qto][@host-name] [4426] STOP FOR qto RUN: 0 0 # = STOP MAIN = qto
    qto-dev ysg@host-name [Fri Sep 14 10:23:16] [/vagrant/opt/csitea/qto/qto.0.4.9.dev.ysg] $

### 13.4. The page looks broken - probably the new css is not reloaded
This problem is quite oftenly experienced and a real time-burner, so keep those shortcuts below in mind. 
To apply the newest css do a hard reload in Chrome with the shortcut COMMAND + SHIFT + R.
The other option is to keep the SHIFT button and press the reload button the Chrome address bar ( this one has been buggy from time to time as well. ... )

    COMMAND + SHIFT + R
    SHIT + CLICK ON RELOAD BUTTON

### 13.5. The vue UI does not update properly 
Due to the vue reactivity system - basically the more the complex the ui control, the better to have some kind of id to set in the v-for ... 

    <div v-for="item in filteredItems" :key="item.id">
    
    // use also in every CRUD operation ...
    this.$forceUpdate()
    // or even 
    this.$parent.$forceUpdate()

### 13.6. NginX fails with 502 Bad Gateway error and probably crashes the site
Might be due to the following error found in the journal log: 
"nginx.service: Failed to parse PID from file /run/nginx.pid: Invalid argument"

    sudo mkdir /etc/systemd/system/nginx.service.d
    printf "[Service]\
    ExecStartPost=/bin/sleep 0.1\
    " | \
        sudo tee /etc/systemd/system/nginx.service.d/override.conf
    sudo systemctl daemon-reload
    sudo systemctl restart nginx

### 13.7. Why having all the hassle with this directory structure - is overkill ?!!
Every software project has a scope. Qto as a project aims to provide the fully vertically integrated code base for deployment, operation and maintenance, which is not possible without the use of multiple run-times within the project ( such as bash, perl, python, terraform, npm ... )
Having a project with a directory structure for a specific run-time enforcing that directory structure to all the other runtimes is a a mess.

    

### 13.8. The new entries in DropBox FK tables cannot be seen
I updated a FK table - the new entries are there. I can see from db that the correct entries are in the db , but I cannot still see the new value(s) in the drop down ... 
It is a Google Chrome specific cache bug ... Try first to hard reload and open the browser , Inspect ( DevTools has to be open ) right-click the Reload button on the address bar and choose "Hard Reload and empty cache" or CMD + Option + R shortcut combination. 
If that STILL does not work on the DevTools choose the Application menu, Storage , Local storage , right-click the local storage of the instance the problem occurs and choose clear local storage.

    

## 14. FAQ
This section contains the most probable frequently asked questions.

    

