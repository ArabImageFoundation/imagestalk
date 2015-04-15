Two main models allow to describe hierarchical data in SQL: 

 - *Adjacency Lists*: Each node keeps a reference to it's parent, or, more uncommonly, each parent keeps a list of children (or both, but data is then de-normalized and should be maintained at the application level).
 - *Nested Sets*: each node sets "left" and "right" value to nodes to describe its "spatial limits" (using the term very liberally here). Thus a node that has "left:1" and "right:20" contains a node that has "left:2" and "right:4".
 
Adjacency lists are more pleasing because more easily readable for a human, however it can become quickly cumbersome if the tree is deep (many requests become necessary to retrieve the tree in full). Special care must be taken at the application level because deleting a root node will not necessarily delete the children, which can lead to orphan nodes and bad references.  

## Quick Recap

|                       | Adjacency List                  | Materialized Path   | Nested Sets                      | Closure Table                          |
|-----------------------|---------------------------------|---------------------|----------------------------------|----------------------------------------|
| Summary               | parent_id=x                     | x/y/z/...           | x< id < y                        | x.parent_id,x.child_id references y.id |
| Implementation        | [####]                          | [###]               | [#]                              | [##]                                   |
| Create                | [####]                          | [####]              | [#]                              | [####]                                 |
| Insert                | [####]                          | [####]              | [.]                              | [####]                                 |
| Move                  | [####]                          | [###]               | [#]                              | [###]                                  |
| Delete                | [####]                          | [##]                | [#]                              | [####]                                 |
| Select one            | [####]                          | [####]              | [##]                             | [####]                                 |
| Select Parent         | [####]                          | [##]                | [##]                             | [####]                                 |
| Select Child          | [####]                          | [#####]             | [##]                             | [####]                                 |
| Alter                 | [##]                            | [####]              | [.]                              | [##]                                   |
| Node Location         | [###]                           | [##]                | [####]                           | [##]                                   |
| Ancestors             | [###]                           | [###]               | [#####]                          | [####]                                 |
| Descendants           | [###]                           | [#####]             | [#####]                          | [####]                                 |
| Sorting by hierarchy  | [##]                            | [##]                | [##]                             | [#]                                    |
| Depth                 | [####]                          | [##]                | [###]                            | [#####]                                |
| performance           | [##]                            | [##]                | [###]                            | [####]                                 |
| Referential Integrity | [####]                          | [#]                 | [##]                             | [#####]                                |
| Synonyms              |                                 | Lineage Column      | Modifier Preorder Tree Traversal | Bridge Table                           |
| Variants              | Recusive queries¹, Flat Table²  | Multiple Columns³   | Nested Intervals⁴                |                                        |


- ¹ Recursive Queries: Allowed by some databases, and may alleviate some limitations of adjacency lists. It becomes more possible to find ancestors/descendants.  
- ² Flat Table: A modification of the Adjacency List that adds a Level and Rank (e.g. ordering) column to each record. Move and Delete become more expensive, but ancestry and descendants become easy.   
- ³ Multiple Lineage Columns: one column for each lineage level, refers to all the parents up to the root. Cheap ancestors, descendants, level, cheap insert, delete, move of the leaves, but expensive insert, delete, move of the internal nodes, and hierarchy becomes extremely limited of course.  
- ⁴ left/right columns are floating point decimals. Fixes some of the problems, but adds complexity at the application level  

## SUMMARY

- **Adjacency List** is good at reads and writes, but not very good at deep hierarchy. Since each node only holds a reference to one parent, in order to traverse the tree in any direction, recursive queries must be used. Thus, it is better used for data sets where only one level retrieval up or down is needed. It's benefit is the schema simplicity. Usage:
    + Organisation hierarchy
    + Threaded discussion
- **Materialized Path** is better at maintaining hierarchy, but only towards lower levels. It's very easy to get all the descendants of a node, but very hard to get it's ancestors. Thus it's ideal for top-down tree traversal. Usage:
    + File System
- **Nested Sets** is great at describing everything a parent contains, but not very good at traversing hierarchies, and pretty much sucks ass if it needs to be changed. Thus, Nested Sets are ideal for data that changes very little or never, and when you need to know what children are contained in a parent without necessarily needing the know their exact spot in the descendance. Usage:
    + Nested Tags or categories (if the tags don't move too much)
    + Locations
- **Closure Table** could be considered a special case of Adjacency list and Materialized path. It is average for everything, and doesn't have a huge impact performance, wether on reads, writes or deletes. It could potentially be used to create a graph (so hierarchy is not necessarily tree-like). This flexibility comes at the cost of a more complex schema (though not much more complex than Nested Sets). Usage
    + Nested tags or categories
    + Graph-type data


---

## References

 - [the seminal "Modeling Hierarchical Data in SQL" by Mike Hillier][ns1]
 - [Adjacency Lists vs Nested Sets][ns2] 
 - [Models for Hierarchical Data][ns3] by Bill Karwin, with a lengthy example about closure tables
 - [Storing Hierarchical Data Materialized Path][ns4]
 - [My Take on Trees in SQL][ns5] by Depesz, focuses on Closure Tables
 - Frank Martinez proposes a mix of [Materialized Path + Nested Sets]. Seems like over-engineering to me, but interesting nonetheless
 - [StackOverflow][ns8] has a comprehensive list of pros and cos in the questions ["What are the Options for Storing Hierarchical Data in a Relational Database?"][ns7].
 - An [Essay on SQL Trees][ns9] by Vadim Tropashko
 - A [Huge List of References][ns10]
 
[ns1]:http://mikehillyer.com/articles/managing-hierarchical-data-in-mysql/
[ns2]:http://explainextended.com/2009/09/25/adjacency-list-vs-nested-sets-sql-server/
[ns3]:http://www.slideshare.net/billkarwin/models-for-hierarchical-data
[ns4]:https://bojanz.wordpress.com/2014/04/25/storing-hierarchical-data-materialized-path/
[ns5]:http://www.depesz.com/2008/04/11/my-take-on-trees-in-sql/
[ns6]:http://www.ibstaff.net/fmartinez/?p=18
[ns7]:http://stackoverflow.com/questions/4048151/what-are-the-options-for-storing-hierarchical-data-in-a-relational-database
[ns8]:http://stackoverflow.com
[ns9]:https://vadimtropashko.files.wordpress.com/2011/07/ch5.pdf
[ns10]:http://troels.arvin.dk/db/rdbms/links/#hierarchical

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