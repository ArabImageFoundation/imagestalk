Technological choices have been made keeping the following few variables in mind:
 1. Well maintained and battle-tested libraries
 2. Single-purpose libraries, following the UNIX philosophy ("Do one thing and do it well")
 3. Flexible architecture that allows for quick (or as quick as possible) iterations
 4. Libraries that allow for Isomorphic coding (same code works anywhere). It's a Graal that is never actually attained, but the libraries chosen accomplish a great deal in accomodate for the possibility of compiling for desktop/mobile later.
 5. Simplicity: We currently have one maintainer, me, so it is paramount to keep the app maintainable

- #### Server:
    + [Node.js](https://nodejs.org)  
        `rationale:` *Node allows for fast iterations due to it's very flexible nature. Further, the Node ecosystem and cluture has strayed away from monolithic frameworks and embraces micro-modules that can be mixed and matches, allowing us to profit from well-maintained code while opening the door to infinite customization. Lastly, since Node runs javascript, which is the same coding language used in the browser, it is possible to share code between the two, cutting development time (apps that do that are called "isomorphic apps").*
        + **Routing** Custom server technology based on [express](expressjs.com)  
        `rationale:` *Express is the most widely used router in the Node ecosystem. It is well tested, well maintained, and used in production by a plethora of companies.*
        + **Static Assets Serving** Also express
        + **API** Custom-made server technology  
        `rationale:` *There is no module that allows for the type of API that I envision. They're all either overly complex (iterations are hard) or not enough (not useful).*
        + **Front-End Templating** [React](https://facebook.github.io/react/)  
        `rationale:` *Although React is complex, and documentation is severely crappy, it has many things going on for it. For once, it allows for declarative templating; without going too much into details, it basically means the application logic is much easier to read and reason about. Secondly, it can render on both the server and the browser, allowing for true isomorphism. Third, it's extremely performant, and Facebook keeps honing it. Fourth, it can compile to native interfaces for mobile devices. Lastly, it is very widely used, and if documentation is lacking right now, I do not doubt that by the time this project complete, it will be complete as well.*
        + **Models** Custom technology  
        `rationale:` *Sadly, there are no frameworks that provide models for react, so this will need to be built from scratch*
        + **Security & Authentication** Through third-party providers with [passportjs](http://passportjs.org/)  
        `rationale:` *Not storing user credentials on the server makes security less critical. Passport is a widely used library that allows to use almost all OAUTH providers (Google, Facebook, Twitter, etc)*
- #### Browser:
    + **UI**: [React](https://facebook.github.io/react/)  
    `rationale:` *Although React does not support internet explorer under version 8, I've decided to use it all the same for the reasons invoked above. Browser support can be achieved later, if desired. Further, it fills all the needs of a basic app (events, dynamic rendering, touch support...), allowing to bypass using jquery/zepto or similar.*
    + **Routing & Ajax Fetching**: Custom technology  
    `rationale:` *Many requesters exist, but none really fits with the server API. The few solutions that are flexible enough depend on jQuery, which I do not want to include to my dependencies.*
- #### Database:
    + [CouchDb](http://couchdb.apache.org/)  
    `rationale:`
        * Out of all document databases, CouchDb allows for most data consistency. Granted, it's sort of a hack; in order to never loose anything, couchdb actually never deletes anything. Any change is saved as a new *version*. Quirky, but works. The interesting side-effect is that all changes are logged, and any document can be rolled back to a previous version.
        * Using a document database allows us to iterate fast, and be flexible in the structure, at least for a start. A migration can be considered later.
        * CouchDb allows for 'painless' (sic) replication. It's not painless, but it's definitely easier than other databases.
        * CouchDb can be replicated in the browser through [PouchDb](http://pouchdb.com/), which would allow, in theory at least, intermittent connection to go unnoticed as the data is still available in the browser. Since replication is built-in, it is also possible, in theory at least, to sync both databases and get offline editing. PouchDb also works in Phonegap/Cordova, so it can be used as an embedded database for applications
        * CouchDb allows for binary storage, so images and all other assets can just be tucked there, which gives us one single repository to maintain (as opposed to synchronizing with a filesystem). Couch begins choking when it has to replicate a lot of large files, but we can change the architecture when we get there.