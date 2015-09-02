#Features
- Support for images, videos and audio files
- Different access levels, between administrator, staff/member, registered user and anonymous user
- Bilinguality, both English and Arabic


#Technologies
##Options
###1. Server
This is the engine that will power the website and AIF interface. The options are too numerous to list even in a book, but the technologies that Synclop is considering are:

 - **PHP** – one of the oldest, most widely used technologies of the Web. It powers more or less half the websites, if not much more.
     + (+) Veteran. Everyone knows how to use it, countless examples for any situation you might think of.
     + (+) Portable, will work on any platform, including shared hosts.
 - **Node.js** – the rising hip young language. It has been picked up quickly by a huge lot of companies small and big and is spreading like wildfire.
     + (+) Unparalleled speed, so very useful for, say, processing images.
     + (+) Unparalleled ease of use and speed of development.
     + (-) Doesn't work on most shared hosts.
     + (-) Difficult to find programmers that have experience with it.

###2. Hosting platforms

This is where the website will reside, and they can be roughly categorized as follows:
 
  - **Shared Hosting** – this is the least costly solution. The server is shared between many users. There is a terrible loss in performance, but as most websites don't require much, in a lot of cases, this is enough. However, special solutions cannot be installed on shared hosts (typically), which means losing quite a good amount of flexibility.
  - **Private Dedicated Managed Server** - this is the most costly solution, but the most flexible too. As the name implies, a machine is dedicated to your website only.
  - **Private Dedicated Self-Managed Server** - this is the same as above, but slightly less costly, as you are supposed to manage the server yourself. Any problem that arises is yours to fix (unless it's a hardware problem). Which means you have to hire your own IT, but having someone on a retainer fee might be enough.
  - **Private Virtual Managed Server** - this is a mid-way between shared hosting and private servers. It's a private server, but in the cloud, and distributed over multiple PCs. The cost is also in the middle between a shared host and a private server.
  - **Private Virtual Self-Managed Server** - as you can guess, this is a virtual private server you manage yourself.
  - **Cloud Platform** - this is the equivalent of a VPS (Virtual Private Server), but it scales up automatically with your requirements, so it can end up being much stronger than a dedicated server. However, the pricing scheme is often complex, very low as long when your requirements are low, but climbing up exponentially as your requirements grow.

###3. Database
####Types of databases
Before going forward, it might be good to define a few words to make the following easier to understand:

 - [**Relational Databases**](en.wikipedia.org/wiki/Relational_database) store data in tables. It might help to visualize them as Excel sheets. Data in relational databases is *normalized* and *structured*. Relational databases also have developed a set of features that allow them to guarantee writes; in other words, in case of failure, the data stays uncorrupted. This set of features, referred to as [ACID](http://en.wikipedia.org/wiki/ACID) (Atomicity, Consistency, Isolation, Durability), guarantees that database transactions are processed reliably.
 - [**SQL**](http://en.wikipedia.org/wiki/SQL) stands for "Structured Query Language". It refers to the language that is used in the earliest databases to instruct the database how to store or retrieve data. By extension, it has become synonymous with "relational databases".
 - [**NoSQL**](en.wikipedia.org/wiki/NoSQL) refers to a new wave of databases that are non-relational. Some of them *do* use SQL language, so the appellation is often a misnomer, and should be understood as "not relational", and not as "not using SQL". NoSQL databases include, but are not limited to:
     + [**Document databases**](http://en.wikipedia.org/wiki/Document-oriented_database) that store information as a tree; a good visualization is a file system (folders containing other folders containing files). Document databases are specially useful for nested data, for speed, and for flexibility (since the data is, by design, not normalized, it's easy to add properties to any object). They have a reputation of being ACID-adverse, but huge technological improvements have been changing this in the last year.
     + [**Graph databases**](http://en.wikipedia.org/wiki/Graph_database) that establish links between things. This is specially useful for arbitrarily linking two objects ("nodes", in graph parlance) with a link ("edge") specifying a certain relation. They are widely used in social networks (X is "friends" with Y, A is "going out with" B). The landscape of Graph databases is mostly bare, with only a few dominating ones.
     + [**Key-Value Store**](http://en.wikipedia.org/wiki/Key-value_database) – very simple databases that store every piece of data under a key. Imagine an excel sheet with only two columns, one of which is an identity field you can't fiddle with. The extreme simplification allows for extreme speeds.

In other words;

 - **Relational databases** express data as "X *is* made of A, B, and C", such as "a book *is* made of title, number of pages, and author". They have been in use for years and most problems that might arise have been already solved.
 - **Document databases** express data as "X *contains* A, B, and C", such as "Contact *has* an address, the address *has* a street, a city, and a state". They are new, and hard problems are still arising nowadays.
 - **Graph databases** express data as "X *is in relation with* A, B, and C *and the quality of their relation is Y*", such as "Alice *is friends with* Bob and Bob *is a member of* the local chess club". Graph databases are complex and as a result, very few open-source solutions are available today.

Finally, to make things a bit more complex, some databases are *mixed*. **OrientDb** is a graph database that incorporates some relational features. **PostgreSQL** is a relational database, but as of it's latest version can also store and search "documents".

In the case of the highly relational data we are dealing with, a graph database would make a lot of sense (photo X is "in" album Y, and is "defined by" terms A,B,and C), but choosing a graph database would mean doing away with ready-made solutions, as well as sacrificing somewhat future maintainability (most people have not even *heard* of noSQL databases, let alone graph databases).

A database system stores and retrieves pieces of data. On its own, it does nothing; an application has to be built around it.

#####Comparison of graph databases

  name                            | Company                   | Language          | License                                           | Graph Model                                                               | Backend                                                                       | API                                                           | Query Methods                                                                         | Consistency                                                           | Visualizer                                                                                | Scaling                                                                                   | Latest Version                            
  ------------------------------- | -----------------------   | ----------------  | ------------------------------------------------  | ------------------------------------------------------------------------  | ----------------------------------------------------------------------------- | ------------------------------------------------------------- | ----------------------------------------------------------------------------------    | --------------------------------------------------------------------  | ----------------------------------------------------------------------------------------  | ----------------------------------------------------------------------------------------  | ------------------------------------------ 
  [ArangoDB][g1]                  | ArangoDB GmbH             | C/C++             | Apache 2                                          | Property Graph                                                            | native C/C++                                                                  | Java, Ruby, JavaScript, Perl, .NET, LINQ, WebServices / REST  | Graph Traversals via JavaScript, Gremlin, AQL                                         | MVCC/ACID                                                             | Builtin Graph Explorer                                                                    |                                                                                           | 2.4.4 (2015)                              
  [AllegroGraph][g2]              | Franz Inc.                | C++/Lisp          | commercial & Free Edition                         | RDF, XML                                                                  | native C++/Common Lisp                                                        | Java, Python, Lisp, Ruby, Perl, C#, WebServices / Rest        | SPARQL, Prolog                                                                        | ACID                                                                  | Gruff                                                                                     | Benchmarks                                                                                | 4.13 (Feb 2014)                           
  [Apache Giraph][g3]             | Apache                    | Java              | Apache 2                                          | Vertex centric. Supports directed, weighted, multigraph                   | Based on Google Pregel's paper                                                | Java                                                          | Java with map reduce/hadoop jobs                                                      |                                                                       |                                                                                           | Distributed. Trillion of nodes possible                                                   |                                           
  [Sparksee(DEX)][g4]             | Sparsity Technologies     | Java, Core C++    | commercial & free for Research and development    | Labeled and directed attributed multigraph                                | bitmap based highly compressed native graph storage, native C++ query engine  | Java, C++, .NET                                               | Blueprints, Java, C++, .NET native APIs                                               | ACID[g17]                                                             |                                                                                           | Throughput scaling through Horizontal replication and High Availability                   | 4.7 (2012)                                
  [FlockDB][g5]                   | Twitter                   | Java              | Apache 2                                          | adjacency list of a directed graph                                        |                                                                               | Java, Ruby via Thrift                                         |                                                                                       |                                                                       |                                                                                           |                                                                                           | 1.8.15 (2012) but last commit at 04/2012  
  [GraphBase][g6]                 | FactNexus Pty Ltd         | Java              | commercial                                        | property-graph                                                            |                                                                               | Java                                                          |                                                                                       |                                                                       | GraphPad, BoundsPad, ...                                                                  |                                                                                           |                                           
  [GraphPack][g7]                 | Amit Portnoy              | Java              | Apache 2                                          | property-graph                                                            | In-memory, JDO                                                                | Java                                                          | PackCypher (Inspired by Cypher)                                                       |                                                                       |                                                                                           | Completely decentralized (no central authority- infinite scale- limited functionality)    | Experimental (2012)                       
  [HyperGraphDB][g8]              | kobrix.com                | Java              | LGPL                                              | Object-oriented multi-relational labeled hypergraph                       | custom                                                                        | Java                                                          |                                                                                       | MVCC/STM                                                              |                                                                                           |                                                                                           | 1.2 (2012)                                
  [InfiniteGraph][g9]             | Objectivity Inc.          | Java, Core C++    | commercial                                        | Labeled and directed multi-property-graph                                 | Objectivity/DB                                                                | Java                                                          | Java, Blueprints                                                                      | ACID. There is also a parallel, loosely synchronized batch loader.    | Graph browser for developers. Plugins to allow use of external libraries.                 | Distributed. Petabytes possible                                                           | 3.0 (2012?)                              
  [InfoGrid][g10]                 | NetMesh Inc.              | Java              | AGPL, commercial                                  | dynamically typed, object-oriented graph. multigraphs, semantic models    |                                                                               |                                                               |                                                                                       |                                                                       |                                                                                           |                                                                                           | 2.9.5 (2011)                              
  [Neo4j][g11]                    | Neo Technology, Inc       | Java              | GPL, AGPL, commercial                             | property-graph                                                            | native graph storage with native graph processing engine                      | Java, REST, JavaScript (Node.js), PHP, .NET, Django, Clojure  | Cypher query language, Native Java APIs, Traverser API, REST, Blueprints, Gremlin     | ACID                                                                  |                                                                                           | MySQL style master/slave replication                                                      | 1.8.2 (2013/02/27)                        
  [Oracle Spatial and Graph][g12] | Oracle                    | Java, PL/SQL      | Oracle                                            | RDF graph; Network Data Model property graph                              | Oracle Database                                                               | Apache  Jena, PL/SQL; Java                                    | SPARQL, SQL with graph extensions; Java API                                           | ACID                                                                  | all tools which are SPARQL-compliant; Apache Jena-based; XML & JSON-based or SQL-based    | Scales from PC to Oracle Exadata; Supports Oracle Real Application Clusters               | 11.2 (2012)                               
  [Oracle NoSQL Database EE][g13] | Oracle                    | Java              | Oracle                                            | RDF graph                                                                 | Oracle NoSQL Database                                                         | Java (Apache Jena)                                            | SPARQL                                                                                | ACID; Configurable consistency & durability                           | SPARQL-compliant tools; Apache Jena-based tools; XML & JSON-based tools                   |                                                                                           | 2.0.39 (2013)                             
  [OrientDB][g14]                 | NuvolaBase Ltd            | Java              | Apache 2                                          | multi property-graph                                                      | custom on disk or in memory                                                   | Java, JS, .NET, PHP, REST, Python                             | Traverser API, Blueprints, Rexster, Gremlin, Own SQL-like Query Language              | ACID, MVCC                                                            | OrientDB Studio                                                                           | Multi Master                                                                              | 1.3 (2012)                                
  [Steffi DB][g15]                | EURA NOVA                 | Java              | Apache 2                                          |                                                                           | In Memory                                                                     |                                                               |                                                                                       |                                                                       |                                                                                           |                                                                                           | ??                                           
  [Titan][g16]                    | thinkaurelius.com         | Java              | Apache 2                                          | property-graph                                                            | Cassandra, HBase, Berkeley DB                                                 | Java, Gremlin                                                 | Blueprints, Rexster, Gremlin, SPARQL                                                  | ACID or Eventually Consistent                                         |                                                                                           | Multi-master                                                                              | 0.2 (2012)                                

[g1]:https://www.arangodb.com/
[g2]:http://franz.com/agraph/allegrograph/
[g3]:http://giraph.apache.org/
[g4]:http://www.sparsity-technologies.com/
[g5]:https://github.com/twitter/flockdb
[g6]:http://graphbase.net/
[g7]:https://code.google.com/p/graphpack/
[g8]:http://www.hypergraphdb.org/index
[g9]:http://www.objectivity.com/infinitegraph
[g10]:http://infogrid.org
[g11]:http://neo4j.com/
[g12]:http://www.oracle.com/technetwork/database/options/spatialandgraph/overview/index.html
[g13]:http://www.oracle.com/us/products/database/nosql/overview/index.html
[g14]:http://www.orientechnologies.com
[g15]:http://steffi.io
[g16]:http://thinkaurelius.github.io/titan/
[g17]:http://sparsity-technologies.com/dex_releases

#####Hierarchical data in SQL
Two main models allow to describe hierarchical data in SQL: 

 - *Adjacency Lists* – each node keeps a reference to it's parent, or, more uncommonly, each parent keeps a list of children (or both, but data is then de-normalized and should be maintained at the application level).
 - *Nested Sets* – each node sets "left" and "right" value to nodes to describe its "spatial limits" (using the term very liberally here). Thus a node that has "left:1" and "right:20" contains a node that has "left:2" and "right:4".
 
Adjacency lists are more pleasing because more easily readable for a human, however it can become quickly cumbersome if the tree is deep (many requests become necessary to retrieve the tree in full). Special care must be taken at the application level because deleting a root node will not necessarily delete the children, which can lead to orphan nodes and bad references.  

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

¹ *Recursive Queries – allowed by some databases, and may alleviate some limitations of adjacency lists. It becomes more possible to find ancestors/descendants.*

² *Flat Table – a modification of the Adjacency List that adds a Level and Rank (e.g. ordering) column to each record. Move and Delete become more expensive, but ancestry and descendants become easy.*

³ *Multiple Lineage Columns – one column for each lineage level, refers to all the parents up to the root. Cheap ancestors, descendants, level, cheap insert, delete, move of the leaves, but expensive insert, delete, move of the internal nodes, and hierarchy becomes extremely limited of course.*

⁴ *Left/right columns are floating point decimals. Fixes some of the problems, but adds complexity at the application level.*

--

In other words;

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

However, in the case of the AIF, we probably cannot rely on pure tree structures. It is very likely that relationships can go in multiple ways, and so we probably need a way to model Directed Graphs or Directed Acyclic Graphs (DG and DAG). DG are cumbersome to use, because relationships ("edges", in graph theory parlance) can "cycle", and so special care must be taken to not fall into loops. DAG are safe from loops, which means algorithms can be simplified, but care must be taken to not create a loop (since the algorithm wouldn't cater for it and might run indefinitely). More readings about this in the references below.

Since manipulating DGs and DAGs by hand would be complex, I've been looking for an ORM to help alleviate the problem. An ORM does "Object Relational Mapping"; basically, abstracts complexity and facilitates communication with the database. Unsurprisingly, very few have tree representation, and none has graph representations.

  Name             | Technology  | Nested Sets  | AG  | DAG  | EAV      | Pure ORM  
  ---------------- | ----------- | ------------ | --- | ---- | -------- | --------- 
  [Propel][1]      | PHP         | [(✓)][2]     | (x) | (x)  | (x)      | (✓)       
  [DataMapper][3]  | PHP         | [(✓)][4]     | (x) | (x)  | (x)      | (✓)      
  [Doctrine][10]   | PHP         | [(✓)][11]    | (x) | (x)  | (x)      | (✓)    
  [Yii2][12]       | PHP         | [Plugin][13] | (x) | (x)  | (x)      | (x)
  [FuelPHP][5]     | PHP         | [(✓)][6]     | (x) | (x)  | [(✓)][7] | no        
  [Laravel][8]     | PHP         | [Plugin][9]  | (x) | (x)  | (x)      | (x)
 
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

--

Here are some other references for additional readings:

  - [Graphs and Graph Algorithms in T-SQL][dag1]
  - [A Model to Represent Directed Acyclic Graphs (DAG) on SQL Databases][dag2]
  - [Graphs in the database: SQL meets social networks][dag3]
  - [The seminal "Modeling Hierarchical Data in SQL" by Mike Hillier][ns1]
  - [Adjacency Lists vs Nested Sets][ns2] 
  - [Models for Hierarchical Data][ns3] by Bill Karwin, with a lengthy example about closure tables.
  - [Storing Hierarchical Data Materialized Path][ns4]
  - [My Take on Trees in SQL][ns5] by Depesz, focuses on Closure Tables
  - Frank Martinez proposes a mix of [Materialized Path + Nested Sets][ns6]. It seems like over-engineering to me, but interesting nonetheless.
  - [StackOverflow][ns8] has a comprehensive list of pros and cos in the questions [What Are The Options For Storing Hierarchical Data In A Relational Database?][ns7]
  - [Essay on SQL Trees][ns9] by Vadim Tropashko
  - [Huge List of References][ns10]

[dag1]:http://hansolav.net/sql/graphs.html
[dag2]:http://www.codeproject.com/KB/database/Modeling_DAGs_on_SQL_DBs.aspx?msg=3051183
[dag3]:http://techportal.inviqa.com/2009/09/07/graphs-in-the-database-sql-meets-social-networks/
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

####Database solutions to consider
- [**Neo4j**](http://neo4j.com/)
    - (+) Used in production by large companies (eBay, Wallmart...)
    - (+) Very flexible
    - (-) No ACID transactions (database is not 100% reliable)
    - (-) GPL License (might stand in the way of open-sourcing the product)
    - (-) No clear pricing, and no clustering in the free version (divide the database on several PCs when it's too big)
- [**OrientDb**](http://www.orientechnologies.com/orientdb/)
    - (+) Reliable and stable
    - (+) Has ACID transactions (very few noSQL databases have that)
    - (+) Apache licensing (Open-source friendly license)
    - (+) Has classical relational features
    - (+) Free version has all we need
    - (-) Runs on a java virtual machine (might be taxing on resources)
- [**PostgreSQL**](http://www.postgresql.org/)
    - (+) Relational + document database
    - (+) Has ACID transactions
    - (+) Very liberal license 
    - (+) Completely free
    - (-) Not a graph database
- [**CouchDB**](couchdb.apache.org/)
    - (+) Document database
    - (+) Trades ACID for versioning (keeps track of every change)
    - (+) Easy replication
    - (+) [Iris Couch](https://www.iriscouch.com)
    - (-) Not a graph database


For more information, below are some references:

  - [Managing Many to Many Relationships][o1] on Join-Fu
  - [Dave's Guide to EAV][o2] (and comments)
  - [Querying Adjacency Lists in PostgreSQL][o3]
  - [Database Schema for Tags][o4]
  - [Resource Description Framework][o5]

[o1]:http://www.joinfu.com/2005/12/managing-many-to-many-relationships-in-mysql-part-1/comment-page-1/
[o2]:http://weblogs.sqlteam.com/davidm/articles/12117.aspx
[o3]:http://dba.stackexchange.com/questions/35305/multiple-parents-and-multiple-children-in-product-categories
[o4]:http://tagging.pui.ch/post/37027745720/tags-database-schemas
[o5]:http://en.wikipedia.org/wiki/Resource_Description_Framework

###4. Frameworks
A *framework* bundles back-end and front-end in a single coherent whole. By definition, it is easier to deal with than building from scratch; however, it often limits the customization.

- [**Collective Access**](http://www.collectiveaccess.org)

	CollectiveAccess is free open-source software for managing and publishing museum and archival collections.

	- (+) Allows any sort of collection, adding fields is "easy".
	- (+) Runs on standard technology (PHP/MySQL).
	- (+) Complete solution, ready to work out of the box.
	- (-) No easy export-import path from the current FAI database to CA.
	- (-) Website is read-only (no user participation) and likely monolithic; customization is probably difficult.
 	- (-) User interface (archivists-facing interface) is complex and confusing.
	- (-) Underused; User pool is small, as are examples and test cases. If help is needed, it will likely come in the form of paid consulting or development.

- [**Drupal**](http://www.drupal.org)

	Drupal is an open-source content management platform powering millions of websites and applications. It is built, used, and supported by an active and diverse community of people around the world.

	- (+) Allows any sort of object type. Adding fields is easy.
	- (+) Runs on standard technology (PHP/any database).
	- (+) A lot of tools are ready-made, and a lot of community-developed plugins exist to add almost any functionality one can think of.
	- (+) Widely, widely used. Easy to find examples and use cases, easy to find advice. Easy also to hire someone to make changes later. Paid consulting is also available.
	- (-) A non-negligible effort has to be made to tie the different modules together so they can work as a coherent whole.
	- (-) A stack of related technologies have to be installed on top of Drupal to keep a reliable performance, so server processing power/storage space has to be slightly above average.

- [**ICA-ATOM**](https://www.ica-atom.org)

	ICA-AtoM is web-based archival description software that is based on International Council on Archives ('ICA') standards. 'AtoM' is an acronymn for 'Access to Memory'.

	- (+) Adheres to ICA Standards (is this necessary or even desirable?)
	- (+) AGPL3 License, which would force us to be GPL-licensed. This might or might not be a problem.
	- (+) Widely used and works well.
	- (+) Supports translations out of the box.
	- (-) Not easily customizable, in fact ATOM advises against customization. (See [this](https://groups.google.com/forum/#!searchin/ica-atom-users/custom$20fields/ica-atom-users/OY7QYtJMyks/-CZ5YlcsLEkJ).)
	- (-) No REST interface (interoperability can be achieved through OAI harvesting, in their own words, [not very well tested or explored](https://groups.google.com/forum/#!msg/ica-atom-users/-Y3rcs56Qvo/MIYpTSpaXl4J).)
	- (-) Complex to use, even for a standard user. We might end up replacing a too complex solution that was not used because it required training with another too complex solution that will not be used because it requires training.

##Decisions
Technological choices have been made keeping the following few variables in mind:

 1. Well maintained and battle-tested libraries.
 2. Single-purpose libraries, following the UNIX philosophy. ("Do one thing and do it well.")
 3. Flexible architecture that allows for quick (or as quick as possible) iterations.
 4. Libraries that allow for Isomorphic coding (same code works anywhere). It's a Graal that is never actually attained, but the libraries chosen accomplish a great deal in accomodate for the possibility of compiling for desktop/mobile later.
 5. Simplicity: We currently have one maintainer, me, so it is paramount to keep the app maintainable.

###1. Server
- [Node.js](https://nodejs.org)  
`rationale:` *Node allows for fast iterations due to it's very flexible nature. Further, the Node ecosystem and cluture has strayed away from monolithic frameworks and embraces micro-modules that can be mixed and matches, allowing us to profit from well-maintained code while opening the door to infinite customization. Lastly, since Node runs javascript, which is the same coding language used in the browser, it is possible to share code between the two, cutting development time (apps that do that are called "isomorphic apps").*

- **Routing** Custom server technology based on [express](expressjs.com)  
`rationale:` *Express is the most widely used router in the Node ecosystem. It is well tested, well maintained, and used in production by a plethora of companies.*

- **Static Assets Serving** Also express.

- **API** Custom-made server technology  
`rationale:` *There is no module that allows for the type of API that I envision. They're all either overly complex (iterations are hard) or not enough (not useful).*

- **Front-End Templating** [React](https://facebook.github.io/react/)  
`rationale:` *Although React is complex, and documentation is severely crappy, it has many things going on for it. For once, it allows for declarative templating; without going too much into details, it basically means the application logic is much easier to read and reason about. Secondly, it can render on both the server and the browser, allowing for true isomorphism. Third, it's extremely performant, and Facebook keeps honing it. Fourth, it can compile to native interfaces for mobile devices. Lastly, it is very widely used, and if documentation is lacking right now, I do not doubt that by the time this project complete, it will be complete as well.*

- **Models** Custom technology  
`rationale:` *Sadly, there are no frameworks that provide models for react, so this will need to be built from scratch.*

- **Security & Authentication** Through third-party providers with [passportjs](http://passportjs.org/).  
`rationale:` *Not storing user credentials on the server makes security less critical. Passport is a widely used library that allows to use almost all OAUTH providers (Google, Facebook, Twitter, etc.)*

###2. Browser
- **UI**: [React](https://facebook.github.io/react/)  
`rationale:` *Although React does not support internet explorer under version 8, I've decided to use it all the same for the reasons invoked above. Browser support can be achieved later, if desired. Further, it fills all the needs of a basic app (events, dynamic rendering, touch support...), allowing to bypass using jquery/zepto or similar.*

- **Routing & Ajax Fetching**: Custom technology  
`rationale:` *Many requesters exist, but none really fits with the server API. The few solutions that are flexible enough depend on jQuery, which I do not want to include to my dependencies.*

###3. Database
- [CouchDb](http://couchdb.apache.org/)  
`rationale:`

  * Out of all document databases, CouchDb allows for most data consistency. Granted, it's sort of a hack; in order to never loose anything, couchdb actually never deletes anything. Any change is saved as a new *version*. Quirky, but works. The interesting side-effect is that all changes are logged, and any document can be rolled back to a previous version.

  * Using a document database allows us to iterate fast, and be flexible in the structure, at least for a start. A migration can be considered later.

  * CouchDb allows for 'painless' (sic) replication. It's not painless, but it's definitely easier than other databases.

  * CouchDb can be replicated in the browser through [PouchDb](http://pouchdb.com/), which would allow, in theory at least, intermittent connection to go unnoticed as the data is still available in the browser. Since replication is built-in, it is also possible, in theory at least, to sync both databases and get offline editing. PouchDb also works in Phonegap/Cordova, so it can be used as an embedded database for applications.

  * CouchDb allows for binary storage, so images and all other assets can just be tucked there, which gives us one single repository to maintain (as opposed to synchronizing with a filesystem). Couch begins choking when it has to replicate a lot of large files, but we can change the architecture when we get there.

#Storage
##Options
Here are the most prevalent options. Prices assume a need for 4 TB, and up to 10,000 requests per month (which we suppose here amounts to 20 GB of bandwidth per month.)

 Provider               | Storage | Requests | Bandwidth | total | Server | Redundancy | Image Processing 
 ---------------------- | ------- | -------- | --------- | ----- | ------ | ---------- | ---------------- 
 [Amazon S3][p1]        |   94$   |   0.004$ |   1.8$    |   96$ |   (✓)  |     (✓)    |       (x)        
 [Amazon Glacier][p3]   |   40$   |   000$   |   000$    |   40$ |   (x)  |     (✓)    |       (x)        
 [Dropbox Business][p4] |   75$   |   000$   |   000$    |   75$ |   (x)  |     (✓)    |       (x)       
 [Joyent Manta][p5]     |  144$   |   0.004$ |   0.120$  |  145$ |   (✓)  |     (x)    |       (✓)        
 [Joyent Manta+][p5]    |  288$   |   0.004$ |   0.120$  |  289$ |   (✓)  |     (✓)    |       (✓)        
 [MediaFire][p2]        |   89$   |   000$   |   000$    |   89$ |   (✓)  |     (✓)    |       (x)        
 [Google Drive][p8]     |   99$   |   000$   |   000$    |   99$ |   (✓)  |     (✓)    |       (x)        
 [Microsoft Azure][p9]  |   94$   |   000$   |   000$    |   94$ |   (x)  |     (✓)    |       (x)        
 [So You Start][p10]*   |   69$   |   000$   |   000$    |   69$ |   (✓)  |     (x)    |       (x)        
 [BlackBlaze][p11]      |    5$   |   000$   |   000$    |    5$ |   (x)  |     (x)    |       (x)        
 [Your-Server][p7]*     |   30$   |   000$   |   000$    |   30$ |   (✓)  |     (✓)    |       (x)        
 [Mega][p14]            |   30$   |   000$   |   000$    |   30$ |   (✓)  |     (✓)    |       (x)        
 [Box][p8]              |   51$   |   000$   |   000$    |   51$ |   (✓)  |     (✓)    |       (x)        
 [ImageFly][p12]        |  000$   |   000$   |   150$    |  150$ |   (✓)  |     (x)    |       (✓)        

<small>* = self managed</small>

- **Additional notes**:

	- [**Dropbox for Business**][p4] has a bandwidth hard limit of 200 GB/day.

	- [**Google Drive**][p8] has a bandwidth hard limit of 1 GB/day.

	- [**ImageFly**][p12] creates versions of the images automatically, has a CDN.

- ****Honorable mentions****:

	- [**DreamHost**][p5] has a 35$ plan, but limited to 2 TB. It has a 20 TB plan, at 300$.

	- [**Cloudinary**](http://cloudinary.com/pricing) free for 2 GB storage, 5 GB bandwidth.

	- [**ShrinkRay**](https://shrinkray.io/) optimizes automatically images in a GitHub repo.

	- [**Dropbox Pro**](https://www.dropbox.com/business/pricing) at 10$/m, but only 1 TB of space.

	- [**Iris Couch**](https://www.iriscouch.com/service) bundles a CouchDB database, but at 1$/GB. No other fees though.
 
[p1]:http://aws.amazon.com/s3/pricing/ 
[p2]:https://www.mediafire.com/upgrade/#space
[p3]:http://aws.amazon.com/glacier/
[p4]:https://www.dropbox.com/business/pricing
[p5]:https://www.joyent.com/object-storage/pricing
[p6]:https://www.dreamhost.com/cloud/storage/
[p7]:https://robot.your-server.de/order/market/country/OTHER
[p8]:https://www.box.com/pricing/
[p9]:http://azure.microsoft.com/en-gb/pricing/details/storage/
[p10]:http://www.soyoustart.com/us/disk/
[p11]:https://www.backblaze.com/
[p12]:http://imagefly.io/
[p14]:http://

##Decisions
*To be discussed.*