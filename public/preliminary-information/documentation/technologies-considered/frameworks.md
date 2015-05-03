A *framework* bundles back-end and front-end in a single coherent whole. By definition, it is easier to deal with than building from scratch; however, it often limits the customization.

### [Collective Access](http://www.collectiveaccess.org)
CollectiveAccess is free open-source software for managing and publishing museum and archival collections.

 - (+) Allows any sort of collection, adding fields is "easy"
 - (+) Runs on standard technology (PHP/MySQL)
 - (+) Complete solution, ready to work out of the box
 - (-) No easy export-import path from the current FAI database to CA
 - (-) Website is read-only (no user participation) and likely monolithic; customization is probably difficult
 - (-) User interface (archivists-facing interface) is complex and confusing
 - (-) Underused; User pool is small, as are examples and test cases. If help is needed, it will likely come in the form of paid consulting or development.

### [Drupal](http://www.drupal.org)
Drupal is an open source content management platform powering millions of websites and applications. It is built, used, and supported by an active and diverse community of people around the world.

 - (+) Allows any sort of object type. Adding fields is easy
 - (+) Runs on standard technology (PHP/Any database)
 - (+) A lot of tools are ready-made, and a lot of community-developed plugins exist to add almost any functionality one can think of
 - (+) Widely, widely used. Easy to find examples and use cases, easy to find advice. Easy also to hire someone to make changes later. Paid consulting is also available.
 - (-) A non-negligible effort has to be made to tie the different modules together so they can work as a coherent whole
 - (-) A stack of related technologies have to be installed on top of Drupal to keep a reliable performance, so server processing power/storage space has to be slightly above average

### [ICA-ATOM](https://www.ica-atom.org)

ICA-AtoM is web-based archival description software that is based on International Council on Archives ('ICA') standards. 'AtoM' is an acronymn for 'Access to Memory'.

- (+) Adheres to ICA Standards (is this necessary or even desirable?)
- (+) AGPL3 License, which would force us to be GPL-licensed. This might or might not be a problem
- (+) Widely used and works well
- (+) Supports translations out of the box.
- (-) Not easily customizable, in fact ATOM advises against customization (see [this](https://groups.google.com/forum/#!searchin/ica-atom-users/custom$20fields/ica-atom-users/OY7QYtJMyks/-CZ5YlcsLEkJ))
- (-) No REST interface (interoperability can be achieved through OAI harvesting, in their own words, [not very well tested or explored](https://groups.google.com/forum/#!msg/ica-atom-users/-Y3rcs56Qvo/MIYpTSpaXl4J))
- (-) Complex to use, even for a standard user. We might end up replacing a too complex solution that was not used because it required training with another too complex solution that will not be used because it requires training
