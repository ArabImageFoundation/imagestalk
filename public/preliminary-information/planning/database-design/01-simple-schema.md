Build a set of [denormalized](http://en.wikipedia.org/wiki/Denormalization) tables. *Denormalized* means data can get repeated in several places (for example, "country" for a photographer and "country" for a photo will be written twice as "Paris"). This schema is rigid; Photo types, for example, are enumerated by the software (instead of being added by the user), and adding a type later on will require the intervention of a professional.

- The benefits:
    - (+) Easier to grasp and to build
    - (+) Simple to debug
- The trade-offs:
    - (-) Options for the end-user are limited
    - (-) Granular searches are difficult, or impossible
    - (-) Some queries *may* be slower

---

the schema is available on [vertabelo](https://my.vertabelo.com/public-model-view/EleWQ4ntXidGPSKEFje2I4MoBXLFcNBauQNTG4eBcOlhVRkLM0jdZ4RADRnNAh30?x=1833&y=1922&zoom=0.45)

image representation

[![simple design](./simple.png)](./simple.png)

zoomable representation

[[vertabelo("EleWQ4ntXidGPSKEFje2I4MoBXLFcNBauQNTG4eBcOlhVRkLM0jdZ4RADRnNAh30?x=1833&y=1922&zoom=0.45")]]

---

## Creation code

[download](./simple.sql)


```sql
-- ################################################################ --
----------------------------------------------------------------------
----------------------------------------------------------------------
---------- TABLE STRUCTURE FOR ARAB IMAGE FOUNDATION -----------------
---- the following describes the different tables and their usage ----
----------------------------------------------------------------------
----  This version of the database schema is the COMPLEX version  ----
----              Highly denormalized and rigid                   ----
----------------------------------------------------------------------
----------------------------------------------------------------------
-- ################################################################ --


----------------------------------------------------------------------
-- table account:
CREATE TABLE account (
id SERIAL PRIMARY KEY NOT NULL,       -- unique identifier for rows
username text,                        -- username or email
password text,                        -- hashed password
role enum('admin','publisher','user'),-- permissions
);
----------------------------------------------------------------------
-- RELATIONSHIPS:
-- none
----------------------------------------------------------------------

----------------------------------------------------------------------
-- table box:
CREATE TABLE box (
id SERIAL PRIMARY KEY NOT NULL,-- unique identifier for rows
room text,                     -- room name
cupboard text,                 -- cupboard name
shelf text,                    -- shelf name
capacity text,                 -- capacity of the box
amount text,                   -- amount used
);
----------------------------------------------------------------------
-- RELATIONSHIPS:
-- a box may have MANY photos (but holds no reference to them)
-- a box may have MANY objects (but holds no reference to them)
----------------------------------------------------------------------

----------------------------------------------------------------------
-- table collection:
CREATE TABLE collection (
id SERIAL PRIMARY KEY NOT NULL,-- unique identifier for rows
name text,                     -- name of the collection
country text,                  -- country name
description text,              -- description of the collection
researcher text,               -- researcher's name
date_reception date,           -- reception date
contract text,                 -- contract text
contract_type text,            -- contract type
contract_date_start date NOT NULL DEFAULT current_timestamp,
                               -- contract starting date
contract_date_end date NOT NULL DEFAULT current_timestamp,        
                               -- contract ending date
percentage int,                -- revenue share
purchase_amount int,           -- how much was paid
remarks text,                  -- researcher's remarks
-- RELATIONSHIPS:
depositor_id int,              -- reference
);
----------------------------------------------------------------------
-- RELATIONSHIPS:
-- a collection may have ONE depositor
-- a collection may have MANY photos (but holds no reference to them)
-- a collection may have MANY objects (but holds no reference to them)
----------------------------------------------------------------------

----------------------------------------------------------------------
-- table depositor:
CREATE TABLE depositor (
id SERIAL PRIMARY KEY NOT NULL,-- unique identifier for rows
name_first text,               -- first name
name_last text,                -- last name
address1 text,                 -- address
address2 text,                 -- address
address_work text,             -- address
phone_fax text,                -- fax number
phone_mobile text,             -- mobile number
phone_home text,               -- home number
phone_work text,               -- work number
email text,                    -- email
);
----------------------------------------------------------------------
-- RELATIONSHIPS:
-- a depositor may have MANY collections (but holds no reference to them)
----------------------------------------------------------------------

----------------------------------------------------------------------
-- table object:
CREATE TABLE object (
id SERIAL PRIMARY KEY NOT NULL,-- unique identifier for rows
description int,               -- description of the object
creator text,                  -- name of the creator
date date,                     -- reception date
country text,                  -- country
city text,                     -- city
sublocation text,              -- region
keywords text,                 -- tags
condition text,                -- description of the condition
width int,                     -- width of the object
height int,                    -- height of the object
length int,                    -- length of the object
-- RELATIONSHIPS:
box_id int,                    -- reference
collection_id int,             -- reference
);
----------------------------------------------------------------------
-- RELATIONSHIPS:
-- an object may have ONE box
-- an object may have ONE collection
----------------------------------------------------------------------

-- table photo:
CREATE TABLE photo (
id SERIAL PRIMARY KEY NOT NULL,-- unique identifier for rows
width int,                     -- width of the photo
height int,                    -- height of the photo
inscriptions text,             -- inscriptions on the photo
condition text,                -- description of the condition
reference text,                -- reference ID
description text,              -- description of the photo
date date,                     -- reception date
country text,                  -- country
city text,                     -- city
sublocation text,              -- region
keywords text,                 -- tags
border_width int,              -- photo border width
border_height int,             -- photo border height
mount_width int,               -- photo mount width
mount_height int,              -- photo mount height
positive boolean,              -- positive or negative
process enum('silver gelatin','print'), -- process of the photo
genre enum('Group portrait', 'Still life', 'Photo journalism', 'Landscape'),
                               -- genre of the photo
support enum('Print','Glass plates','Film','Paper','Framed prints'),
                               -- support of the photo
-- RELATIONSHIPS:
photographer_id int,           -- reference
studio_id int,                 -- reference
box_id int,                    -- reference
collection_id int,             -- reference
);
----------------------------------------------------------------------
-- RELATIONSHIPS:
-- a photo may have ONE photographer
-- a photo may have ONE studio
-- a photo may have ONE box
-- a photo may have ONE collection
----------------------------------------------------------------------

----------------------------------------------------------------------
-- table photographer:
CREATE TABLE photographer (
id SERIAL PRIMARY KEY NOT NULL,-- unique identifier for rows
name text,                     -- name of the photographer
country text,                  -- country
city text,                     -- city
address text,                  -- address
phone text,                    -- phone number
fax text,                      -- fax number
mobile text,                   -- mobile number
professional boolean,          -- professional or amateur
date_birth date,               -- date of birth
date_death date,               -- date of death
biography text,                -- biography
biography_source text,         -- biography's source
-- RELATIONSHIPS:
studio_id int,                 -- reference
);
----------------------------------------------------------------------
-- RELATIONSHIPS:
-- a photographer may have ONE studio
-- a photographer may have MANY photos (but holds no reference to them)
----------------------------------------------------------------------

----------------------------------------------------------------------
-- table studio:
CREATE TABLE studio (
id SERIAL PRIMARY KEY NOT NULL,-- unique identifier for rows
name text,                     -- name of the studio
country text,                  -- country
city text,                     -- city
address text,                  -- address
phone text,                    -- phone number
fax text,                      -- fax number
mobile text,                   -- mobile number
biography text,                -- studio's biography
biography_source text,         -- biography's source
);
----------------------------------------------------------------------
-- RELATIONSHIPS:
-- a studio may have MANY photos (but holds no reference to them)
-- a studio may have MANY photographers (but holds no reference to them)
----------------------------------------------------------------------


-- ################################################################ --
----------------------------------------------------------------------
----------------------------------------------------------------------
--- ADDING IN RELATIONSHIPS
----------------------------------------------------------------------
----------------------------------------------------------------------

-- COLLECTION --------------------------------------------------------
ALTER TABLE collection ADD CONSTRAINT collection_depositor_fk 
FOREIGN KEY (depositor_id)
REFERENCES depositor (id)
NOT DEFERRABLE 
INITIALLY IMMEDIATE 
;

-- OBJECT ------------------------------------------------------------
ALTER TABLE object ADD CONSTRAINT object_box_fk 
FOREIGN KEY (box_id)
REFERENCES box (id)
NOT DEFERRABLE 
INITIALLY IMMEDIATE 
;

ALTER TABLE object ADD CONSTRAINT object_collection_fk 
FOREIGN KEY (collection_id)
REFERENCES collection (id)
NOT DEFERRABLE 
INITIALLY IMMEDIATE 
;

-- PHOTO -------------------------------------------------------------
ALTER TABLE photo ADD CONSTRAINT photo_box_fk 
FOREIGN KEY (box_id)
REFERENCES box (id)
NOT DEFERRABLE 
INITIALLY IMMEDIATE 
;

ALTER TABLE photo ADD CONSTRAINT photo_collection_fk 
FOREIGN KEY (collection_id)
REFERENCES collection (id)
NOT DEFERRABLE 
INITIALLY IMMEDIATE 
;

ALTER TABLE photo ADD CONSTRAINT photo_photographer_fk 
FOREIGN KEY (photographer_id)
REFERENCES photographer (id)
NOT DEFERRABLE 
INITIALLY IMMEDIATE 
;

ALTER TABLE photo ADD CONSTRAINT photo_studio_fk 
FOREIGN KEY (studio_id)
REFERENCES studio (id)
NOT DEFERRABLE 
INITIALLY IMMEDIATE 
;

-- PHOTOGRAPHER ------------------------------------------------------
ALTER TABLE photographer ADD CONSTRAINT photographer_studio_fk 
FOREIGN KEY (studio_id)
REFERENCES studio (id)
NOT DEFERRABLE 
INITIALLY IMMEDIATE 
;
```

