Two main models allow to describe hierarchical data in SQL: 

 - *Adjacency Lists*: Each node keeps a reference to it's parent, or, more uncommonly, each parent keeps a list of children (or both, but data is then de-normalized and should be maintained at the application level).
 - *Nested Sets*: each node sets "left" and "right" value to nodes to describe its "spatial limits" (using the term very liberally here). Thus a node that has "left:1" and "right:20" contains a node that has "left:2" and "right:4".
 
Adjacency lists are more pleasing because more easily readable for a human, however it can become quickly cumbersome if the tree is deep (many requests become necessary to retrieve the tree in full). Special care must be taken at the application level because deleting a root node will not necessarily delete the children, which can lead to orphan nodes and bad references.  


### references

 - [the seminal "Modeling Hierarchical Data in SQL" by Mike Hillier][ns1]
 - [Adjacency Lists vs Nested Sets][ns2] 
 
[ns1]:http://mikehillyer.com/articles/managing-hierarchical-data-in-mysql/
[ns2]:http://explainextended.com/2009/09/25/adjacency-list-vs-nested-sets-sql-server/

--------

However, in the case of FAI, we probably cannot rely on pure tree structures. It is very likely that relationships can go in multiple ways, and so we probably need a way to model Directed Graphs or Directed Acyclic Graphs (DG and DAG). DG are cumbersome to use, because relationships ("edges", in graph theory parlance) can "cycle", and so special care must be taken to not fall into loops. DAG are safe from loops, which means algorithms can be simplified, but care must be taken to not create a loop (since the algorithm wouldn't cater for it and might run indefinitely). Here are some papers:

 - [Graphs and Graph Algorithms in T-SQL][dag1]
 - [A Model to Represent Directed Acyclic Graphs (DAG) on SQL Databases][dag2]
 - [Graphs in the database: SQL meets social networks][dag3]

[dag1]:http://hansolav.net/sql/graphs.html
[dag2]:http://www.codeproject.com/KB/database/Modeling_DAGs_on_SQL_DBs.aspx?msg=3051183
[dag3]:http://techportal.inviqa.com/2009/09/07/graphs-in-the-database-sql-meets-social-networks/

Since manipulating DGs and DAGs by hand would be complex, I've been looking for an ORM to help alleviate the problem. An ORM does "Object Relational Mapping"; basically, abstracts complexity and facilitates communication with the database. Unsurprisingly, very few have tree representation, and none has graph representations.

  Name             | Technology  | Nested Sets  | AG  | DAG  | EAV      | Pure ORM  
  ---------------- | ----------- | ------------ | --- | ---- | -------- | --------- 
  [Propel][1]      | PHP         | [(✓)][2]     | (x) | (x)  | (x)      | (✓)       
  [DataMapper][3]  | PHP         | [(✓)][4]     | (x) | (x)  | (x)      | (✓)      
  [Doctrine][10]   | PHP         | [(✓)][11]    | (x) | (x)  | (x)      | (✓)    
  [Yii2][12]       | PHP         | [plugin][13] | (x) | (x)  | (x)      | (x)
  [FuelPHP][5]     | PHP         | [(✓)][6]     | (x) | (x)  | [(✓)][7] | no        
  [Laravel][8]     | PHP         | [plugin][9]  | (x) | (x)  | (x)      | (x)
 
[1]:http://propelorm.org/
[2]:http://propelorm.org/documentation/behaviors/nested-set.html
[3]:http://datamapper.wanwizard.eu/
[4]:http://datamapper.wanwizard.eu/pages/extensions/nestedsets.html
[5]:http://fuelphp.com
[6]:http://fuelphp.com/docs/packages/orm/model/nestedset.html
[7]:http://fuelphp.com/docs/packages/orm/eav.html
[8]:http://laravel.com/
[9]:http://etrepat.com/baum/
[10]:http://doctrine.readthedocs.org
[11]:http://doctrine.readthedocs.org/en/latest/en/manual/hierarchical-data.html
[12]:http://www.yiiframework.com/
[13]:http://www.yiiframework.com/extensions/?tag=nested+set