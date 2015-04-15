-- ################################################################ --
----------------------------------------------------------------------
----------------------------------------------------------------------
---------- TABLE STRUCTURE FOR ARAB IMAGE FOUNDATION -----------------
---- the following describes the different tables and their usage ----
----------------------------------------------------------------------
----  This version of the database schema is the COMPLEX version  ----
----            Highly normalized and customizable                ----
----------------------------------------------------------------------
----------------------------------------------------------------------
-- ################################################################ --




-- ################################################################ --
----------------------------------------------------------------------
----------------------------------------------------------------------
---- PHYSICAL ASSETS -------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------

----------------------------------------------------------------------
-- table box: references all the boxes in the archive
DROP TABLE box CASCADE;
CREATE TABLE box(
id SERIAL PRIMARY KEY NOT NULL, -- unique identifier for rows
capacity INT NOT NULL,          -- how much can that box contain
amount INT NOT NULL DEFAULT 0,  -- how much more photos can fit
room TEXT,                      -- in which room the box is
cupboard TEXT,                  -- in which cupboard
shelf TEXT                      -- on which shelf
);
----------------------------------------------------------------------
-- RELATIONSHIPS:
-- a box may have MANY assets (but it holds no reference to them)
----------------------------------------------------------------------

----------------------------------------------------------------------
-- table asset: references all assets (photos and objects)
DROP TABLE asset CASCADE;
CREATE TABLE asset(
id SERIAL PRIMARY KEY NOT NULL, -- unique identifier for rows
width INT,             -- width of the asset
height INT,            -- height of the asset  
inscriptions TEXT,     -- description of the inscriptions
condition TEXT,        -- description of the condition
-- RELATIONSHIPS:
box_id INT,            -- in which box that asset is
creator_id INT,        -- reference
collection_id INT      -- reference
);

----------------------------------------------------------------------
-- RELATIONSHIP TABLE
-- table asset_notes: join table to hold references to all the notes
-- associated with an asset
DROP TABLE asset_notes CASCADE;
CREATE TABLE asset_notes (
asset_id INT NOT NULL,    -- reference
note_id INT NOT NULL,     -- reference
PRIMARY KEY (asset_id,note_id)
);
----------------------------------------------------------------------
-- RELATIONSHIPS:
-- an asset may have ONE box
-- an asset may have ONE creator which is an entity
-- an asset may have MANY notes associated
-- an asset may have ONE collections associated
----------------------------------------------------------------------

----------------------------------------------------------------------
-- table object: holds references to all the objects
DROP TABLE object CASCADE;
CREATE TABLE object(
id SERIAL PRIMARY KEY NOT NULL, -- unique identifier for rows
length INT,                     -- length of the object
-- INHERITANCE:
asset_id INT,
-- RELATIONSHIPS:
objectType_id INT -- reference
);
----------------------------------------------------------------------
-- ENUMERATION TABLE
-- table objectType: one of the following: 
-- Album, Box, ...
DROP TABLE objectType CASCADE;
CREATE TABLE objectType (
id SERIAL PRIMARY KEY NOT NULL, -- unique identifier for rows
name TEXT,                      -- what type of object
description TEXT                -- description of the type
);
----------------------------------------------------------------------
-- RELATIONSHIPS:
-- an object IS of one type objectType
-- an object may have MANY associated photos (but it holds no reference to them)
-- an object IS an asset
----------------------------------------------------------------------

----------------------------------------------------------------------
-- table photo: every photo in the database
-- differently sized photos are to be handled at application level,
-- for example by appending _sizeX to the file name
-- this table inherits all properties from the asset table
DROP TABLE photo CASCADE;
CREATE TABLE photo (
id SERIAL PRIMARY KEY NOT NULL, -- unique identifier for rows
border_width INT,               -- width of the border
border_height INT,              -- height of the border
mount_width INT,                -- width of the mount
mount_height INT,               -- height of the mount
date DATE,                      -- date of reception
reference TEXT,                 -- auto-generated reference id
legacy_reference TEXT,          -- old reference id that pre-exists
positive BOOLEAN,               -- positive or negative
-- INHERITANCE:
asset_id INT,                   -- reference
-- RELATIONSHIPS:
photoProcess_id INT,            -- reference
photoSupport_id INT,            -- reference
photoGenre_id INT,              -- reference
photoReproduction_id INT,       -- reference
location_id INT,                -- reference
studio_id INT,                  -- reference
object_id INT                   -- reference
);
----------------------------------------------------------------------
-- ENUMERATION TABLE
-- table photoSupport: one of the following: 
-- Print, Glass plates, Film, Paper, Framed prints
DROP TABLE photoSupport CASCADE;
CREATE TABLE photoSupport (
id SERIAL PRIMARY KEY NOT NULL, -- unique identifier for rows
name TEXT,                      -- the type of support
description TEXT                -- optional description of the type
);
----------------------------------------------------------------------
-- ENUMERATION TABLE
-- table photoProcess: process of the photos, such as silver gelatin 
-- or print
DROP TABLE photoProcess CASCADE;
CREATE TABLE photoProcess (
id SERIAL PRIMARY KEY NOT NULL, -- unique identifier for rows
name TEXT,                      -- the type of process
description TEXT                -- optional description of the type
);
----------------------------------------------------------------------
-- ENUMERATION TABLE
-- table photoReproduction: Contact-printed, Reproduced on slides,
-- Scanned...
DROP TABLE photoReproduction CASCADE;
CREATE TABLE photoReproduction (
id SERIAL PRIMARY KEY NOT NULL, -- unique identifier for rows
name TEXT,                      -- type of reproduction
description TEXT                -- optional description of the type
);
----------------------------------------------------------------------
-- ENUMERATION TABLE
-- table photoGenre: Portrait, Group portrait, Still life, Photo
-- journalism, Landscape, etc.
-- ?? isn't this better used as tags?
DROP TABLE photoGenre CASCADE;
CREATE TABLE photoGenre (
id SERIAL PRIMARY KEY NOT NULL, -- unique identifier for rows
name TEXT,                      -- genre of the photo
description TEXT                -- optional description of the genre
);
----------------------------------------------------------------------
-- RELATIONSHIPS:
-- a photo IS of one of the photoSupport
-- a photo IS of one of the photoProcesses
-- a photo IS of one of the photoReproductions
-- a photo IS of one of the genres
-- a photo may have ONE location
-- a photo may have ONE object associated
-- a photo may have MANY images files associated (but it holds no reference to them)
-- a photo IS an asset
----------------------------------------------------------------------




-- ################################################################ --
----------------------------------------------------------------------
----------------------------------------------------------------------
---- FILES AND IMAGES ------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------

----------------------------------------------------------------------
-- table file: holds references to every file on disk
DROP TABLE file CASCADE;
CREATE TABLE file (
id SERIAL PRIMARY KEY NOT NULL, -- unique identifier for rows
path TEXT,                      -- path of the file on disk
extension TEXT                  -- extension of the file, (pdf, jpg...)
);
----------------------------------------------------------------------

----------------------------------------------------------------------
-- table image: holds references to every image on disk
-- including avatars, photos, etc
-- this table inherits all properties from the file table
DROP TABLE image CASCADE;
CREATE TABLE image (
id SERIAL PRIMARY KEY NOT NULL, -- unique identifier for rows
description TEXT,               -- caption or short description
-- INHERITANCE:
file_id INT,                    -- reference
-- RELATIONSHIPS:
type_id INT,                    -- reference
photo_id INT                    -- reference
);
----------------------------------------------------------------------
-- RELATIONSHIP TABLE
-- table imageType: describes what an image is, photo, avatar, etc...
DROP TABLE imageType CASCADE;
CREATE TABLE imageType (
id SERIAL PRIMARY KEY NOT NULL, -- unique identifier for rows
name TEXT,                      -- the type
description TEXT                -- optional description of the type
);
----------------------------------------------------------------------
-- RELATIONSHIPS:
-- an image IS of any imageType
-- an image IS a file
-- an image may be associated with ONE photo (as a scanned image)
-- an image may be associated with MANY entities (as avatar) (but it holds no reference to them)
-- an image may be associated with MANY contracts (as a scanned image) (but it holds no reference to them)
----------------------------------------------------------------------




-- ################################################################ --
----------------------------------------------------------------------
----------------------------------------------------------------------
---- METADATA
----------------------------------------------------------------------
----------------------------------------------------------------------

----------------------------------------------------------------------
-- table note: used for comments, notes, descriptions, pages...
DROP TABLE note CASCADE;
CREATE TABLE note (
id SERIAL PRIMARY KEY NOT NULL,-- unique identifier for rows
text TEXT,                    -- the note's TEXT, in markdown format
html TEXT,                    -- the generated html
date DATE,                    -- time the note was created or modified
-- RELATIONSHIPS:
account_id INT                -- who created that note
);
----------------------------------------------------------------------
-- RELATIONSHIPS:
-- a note HAS one associated account (who created it)
-- a note may be associated with MANY collections (but it holds no reference to them)
-- a note may be associated with MANY assets (but it holds no reference to them)
----------------------------------------------------------------------

----------------------------------------------------------------------
-- table biography: holds biographies for people and organisations
-- this table inherits all properties from the note table
DROP TABLE biography CASCADE;
CREATE TABLE biography (
id SERIAL PRIMARY KEY NOT NULL, -- unique identifier for rows
source TEXT,-- who's the source for the bio (should that be a person?)
-- INHERITANCE:
note_id INT
);
----------------------------------------------------------------------
-- RELATIONSHIPS:
-- a biography IS a note
-- a biography may be associated with ONE entities (but it holds no reference to them)
----------------------------------------------------------------------

----------------------------------------------------------------------
-- table log: this holds every operation done by any user
-- useful for accountability and detecting where and when an error
-- could have been made
DROP TABLE log CASCADE;
CREATE TABLE log (
id SERIAL PRIMARY KEY NOT NULL,-- unique identifier for rows
action TEXT,           -- which type of action like delete, or create
location TEXT,         -- in which table was the operation effectuated
-- RELATIONSHIPS:
account_id INT -- who was logged
);
----------------------------------------------------------------------
-- RELATIONSHIPS:
-- a log entry HAS one associated account
-- (the person who did the action)
----------------------------------------------------------------------




-- ################################################################ --
----------------------------------------------------------------------
----------------------------------------------------------------------
--- PEOPLE AND ORGANISATIONS
----------------------------------------------------------------------
----------------------------------------------------------------------

----------------------------------------------------------------------
-- table entity: this is the base object type from which
-- people and organisations derive.
-- Note that this table doesn't contain phone numbers, as a person
-- or an organisation might have different phone numbers
-- in different countries; thus, phone numbers are associated with
-- locations
DROP TABLE entity CASCADE;
CREATE TABLE entity (
id SERIAL PRIMARY KEY NOT NULL,      -- unique identifier for rows
name TEXT,                           -- the name of the entity
email_work TEXT,                     -- primary email of the entity
-- RELATIONSHIPS:
image_id INT,                        -- avatar or logo
biography_id INT,                    -- references the biography note
entityType_id INT                    -- entity type
);
----------------------------------------------------------------------
-- ENUMERATION TABLE
-- table entityType:  describes the different types of
-- entities, like studio, or NGO
DROP TABLE entityType CASCADE;
CREATE TABLE entityType (
id SERIAL PRIMARY KEY NOT NULL, -- unique identifier for rows
name TEXT,                      -- the type
description TEXT                -- optional description of the type
);
----------------------------------------------------------------------
-- RELATIONSHIPS:
-- an entity may have ONE associated image
-- an entity may have ONE associated biography
-- an entity IS of one of the many entityTypes
-- an entity may have MANY locations (but it holds no reference to them)
-- an entity may be associated with MANY contracts (but it holds no reference to them)
-- an entity may be associated with MANY accounts (but it holds no reference to them)
----------------------------------------------------------------------

----------------------------------------------------------------------
-- table person: 
-- this table inherits all properties from the entity table
DROP TABLE person CASCADE;
CREATE TABLE person (
id SERIAL PRIMARY KEY NOT NULL, -- unique identifier for rows
name_last TEXT,                 -- last name
name_middle TEXT,               -- middle name
email_home TEXT,                -- home email
date_birth DATE,                -- date of birth
date_death DATE,                -- date of death
-- INHERITANCE:
entity_id INT                   -- reference
);
----------------------------------------------------------------------
-- RELATIONSHIPS:
-- a person IS an entity
-- a person may be associated with MANY organisations (but it holds no reference to them)
----------------------------------------------------------------------

----------------------------------------------------------------------
-- table photographer: holds references to photographers
-- this table inherits all properties from the person table
DROP TABLE photographer CASCADE;
CREATE TABLE photographer (
id SERIAL PRIMARY KEY NOT NULL, -- unique identifier for rows
professional BOOLEAN,           -- if it's a professional or not
-- INHERITANCE:
person_id INT                   -- reference
);
----------------------------------------------------------------------
-- RELATIONSHIPS:
-- a photographer IS a person
----------------------------------------------------------------------

----------------------------------------------------------------------
-- table organisation: holds references to all organisations,
-- companies, studios, and so on
-- this table inherits all properties from the entity table
DROP TABLE organisation CASCADE;
CREATE TABLE organisation(
id SERIAL PRIMARY KEY NOT NULL, -- unique identifier for rows
-- INHERITANCE:
entity_id INT                   -- reference
);
----------------------------------------------------------------------
-- RELATIONSHIP TABLE
-- table organisation_persons: join table to list the contacts per
-- organisation. 
DROP TABLE organisation_persons CASCADE;
CREATE TABLE organisation_persons (
title TEXT,                             -- secretary, CEO, and so on
-- RELATIONSHIPS:
organisation_id INT NOT NULL,           -- organisation
person_id INT NOT NULL,                 -- contact
PRIMARY KEY (organisation_id,person_id)
);
----------------------------------------------------------------------
-- RELATIONSHIPS:
-- an organisation IS an entity
-- an organisation may have MANY related contacts (persons)
----------------------------------------------------------------------




-- ################################################################ --
----------------------------------------------------------------------
----------------------------------------------------------------------
---- GEOGRAPHY
----------------------------------------------------------------------
----------------------------------------------------------------------

----------------------------------------------------------------------
-- table location: Holds all locations, for photos, people,
-- organisations, and so on
DROP TABLE location CASCADE;
CREATE TABLE location (
id SERIAL PRIMARY KEY NOT NULL,    -- unique identifier for rows
name TEXT,                         -- X's home or Unicef's LB branch
country TEXT,                      -- Which country
city TEXT,                         -- Which City
zip TEXT,                          -- Zip code
address TEXT,                      -- Address
longitude INT,                     -- Longitude
latitude INT                       -- Latitude
);
----------------------------------------------------------------------
-- RELATIONSHIPS:
-- a location may be associated with MANY entities (as an entity_location) (but it holds no reference to them)
-- a location may be associated with MANY contracts (but it holds no reference to them)
-- a location may be associated with MANY photos (but it holds no reference to them)
----------------------------------------------------------------------

----------------------------------------------------------------------
-- table entityLocation: join references of the locations for an
-- entity. A table is necessary because an entity might have more than
-- one location. A person might have home Paris and home Beirut,
-- An organisation might have more than one office.
-- Phone numbers are subsequently associated with locations, not
-- individuals
DROP TABLE entityLocation CASCADE;
CREATE TABLE entityLocation (
id SERIAL PRIMARY KEY NOT NULL,    -- unique identifier for rows
phone_mobile TEXT,                 -- mobile phone number
phone_work TEXT,                   -- work phone number
phone_fax TEXT,                    -- fax phone number
phone_home TEXT,                   -- home phone
-- INHERITANCE:
location_id INT,
-- RELATIONSHIPS:
entity_id INT                      -- reference
);
----------------------------------------------------------------------
-- RELATIONSHIPS:
-- an entityLocation IS a location
-- an entityLocation may have ONE associated entity
----------------------------------------------------------------------




-- ################################################################ --
----------------------------------------------------------------------
----------------------------------------------------------------------
---- COLLECTIONS
----------------------------------------------------------------------
----------------------------------------------------------------------

----------------------------------------------------------------------
-- table collection: Holds references to all collections
DROP TABLE collection CASCADE;
CREATE TABLE collection (
id SERIAL PRIMARY KEY NOT NULL,   -- unique identifier for rows
name TEXT,                        -- name of the collection
owner INT,                        -- who owns the collection
date DATE NOT NULL DEFAULT current_timestamp -- reception date
-- RELATIONSHIPS:
location_id INT,                  -- collection' location
depositor INT,                    -- who deposited it
researcher INT,                   -- who took care of it
contract_id INT                   -- what contract binds it
);
----------------------------------------------------------------------
-- table collection_notes: All notes associated with a particular
-- collection
DROP TABLE collection_notes CASCADE;
CREATE TABLE collection_notes (
collection_id INT NOT NULL,         -- reference
note_id INT NOT NULL,               -- reference
PRIMARY KEY (collection_id,note_id)
);
----------------------------------------------------------------------
-- RELATIONSHIPS:
-- a collection may have ONE location
-- a collection may have ONE depositor (entity)
-- a collection may have ONE researcher (entity)
-- a collection may be associated with ONE contract
-- a collection may have MANY assets (but it holds no reference to them)
-- a collection may have MANY notes
----------------------------------------------------------------------




-- ################################################################ --
----------------------------------------------------------------------
----------------------------------------------------------------------
---- ACCOUNTS & PERMISSIONS
----------------------------------------------------------------------
----------------------------------------------------------------------

----------------------------------------------------------------------
-- table account: holds all accounts
DROP TABLE account CASCADE;
CREATE TABLE account (
id SERIAL PRIMARY KEY NOT NULL,      -- unique identifier for rows
username TEXT UNIQUE NOT NULL,       -- email or username
password TEXT NOT NULL,              -- hashed password
-- RELATIONSHIPS:
entity_id INT                        -- reference
);
----------------------------------------------------------------------
-- RELATIONSHIP TABLE
-- table account_roles: join table to associate roles with accounts
DROP TABLE account_roles CASCADE;
CREATE TABLE account_roles (
account_id INT NOT NULL,           -- reference
role_id INT NOT NULL,              -- reference
PRIMARY KEY (account_id,role_id)
);
----------------------------------------------------------------------
-- RELATIONSHIP TABLE
-- table account_permissions: join table to associate permissions
-- with accounts. For example a user might have subscriber role
-- but be exceptionally allowed to edit notes
DROP TABLE account_permissions CASCADE;
CREATE TABLE account_permissions (
account_id INT NOT NULL,                 -- reference
permission_id INT NOT NULL,              -- reference
PRIMARY KEY (account_id,permission_id)
);
-- RELATIONSHIPS:
-- an account may be associated with ONE entity
-- (a person or organisation)
-- an account may have MANY roles
-- an account may have MANY permissions
-- an account may be associated with MANY notes (but it holds no reference to them)
----------------------------------------------------------------------

----------------------------------------------------------------------
-- table role: Holds all the roles of the accounts
-- A role can be admin, subscriber, etc
DROP TABLE role CASCADE;
CREATE TABLE role (
id SERIAL PRIMARY KEY NOT NULL,      -- unique identifier for rows
name TEXT
);
----------------------------------------------------------------------
-- RELATIONSHIP TABLE
-- table role_permissions: join table to associate permissions with
-- roles
DROP TABLE role_permissions CASCADE;
CREATE TABLE role_permissions (
role_id INT NOT NULL,                 -- reference
permission_id INT NOT NULL,           -- reference
PRIMARY KEY (role_id,permission_id)
);
----------------------------------------------------------------------
-- RELATIONSHIPS:
-- a role may have MANY permissions
-- a role may be associated with MANY accounts (but it holds no reference to them)
----------------------------------------------------------------------

----------------------------------------------------------------------
-- table permission: access control table that lists permissions
-- a permission could be can edit photos, can add user
DROP TABLE permission CASCADE;
CREATE TABLE permission (
id SERIAL PRIMARY KEY NOT NULL,-- unique identifier for rows
name TEXT,                  -- name of the permission
location TEXT               -- permission applies to a particular item
);
----------------------------------------------------------------------
-- RELATIONSHIPS:
-- a permission may be associated with MANY roles (but it holds no reference to them)
-- a permission may be associated with MANY accounts (but it holds no reference to them)
----------------------------------------------------------------------




-- ################################################################ --
----------------------------------------------------------------------
----------------------------------------------------------------------
--- CONTRACTS
----------------------------------------------------------------------
----------------------------------------------------------------------

----------------------------------------------------------------------
-- table contract: holds all the contracts
DROP TABLE contract CASCADE;
CREATE TABLE contract (
id SERIAL PRIMARY KEY NOT NULL, -- unique identifier for rows
title TEXT,                     -- title of the contract
TEXT TEXT,                      -- text of the contract
date_beginning DATE 
NOT NULL DEFAULT current_timestamp,-- when does the contract start
date_end DATE
NOT NULL DEFAULT current_timestamp,-- when does the contract end
percentage INT NOT NULL,           -- revenue share
purchase_amount INT NOT NULL,      -- how much was paid
-- RELATIONSHIPS:
entity_id INT                   -- who signed the contract
);
----------------------------------------------------------------------
-- RELATIONSHIP TABLE
-- table contract_images: holds all images associated with a contract
-- NOTE: these are NOT the photos delivered; they are scans of the
-- contract itself
DROP TABLE contract_images CASCADE;
CREATE TABLE contract_images(
contract_id INT NOT NULL,               -- reference
image_id INT NOT NULL,                  -- reference
PRIMARY KEY (contract_id,image_id)
);
----------------------------------------------------------------------
-- RELATIONSHIPS:
-- a contract may have MANY images (scanned images of the contract)
-- a contract may have ONE associated entity (who signed it)
-- a contract may be associated with MANY collections (but it holds no reference to them)
----------------------------------------------------------------------




-- ################################################################ --
----------------------------------------------------------------------
----------------------------------------------------------------------
--- ADDING IN RELATIONSHIPS
----------------------------------------------------------------------
----------------------------------------------------------------------

-- ASSET -------------------------------------------------------------
ALTER TABLE asset 
ADD CONSTRAINT asset_box_fk
FOREIGN KEY (box_id)
REFERENCES box(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

ALTER TABLE asset 
ADD CONSTRAINT asset_creator_fk
FOREIGN KEY (creator_id)
REFERENCES entity(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

ALTER TABLE asset 
ADD CONSTRAINT asset_collection_fk
FOREIGN KEY (collection_id)
REFERENCES collection(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

-- ASSET NOTES -------------------------------------------------------
ALTER TABLE asset_notes 
ADD CONSTRAINT asset_notes_asset_fk
FOREIGN KEY (asset_id)
REFERENCES asset(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

ALTER TABLE asset_notes 
ADD CONSTRAINT asset_notes_note_fk
FOREIGN KEY (note_id)
REFERENCES note(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

-- OBJECT ------------------------------------------------------------
ALTER TABLE object 
ADD CONSTRAINT object_asset_fk
FOREIGN KEY (asset_id)
REFERENCES asset(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

ALTER TABLE object 
ADD CONSTRAINT object_objecType_fk
FOREIGN KEY (objectType_id)
REFERENCES objectType(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

-- PHOTO -------------------------------------------------------------
ALTER TABLE photo 
ADD CONSTRAINT photo_photoProcess_fk
FOREIGN KEY (photoProcess_id)
REFERENCES photoProcess(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

ALTER TABLE photo 
ADD CONSTRAINT photo_photoSupport_fk
FOREIGN KEY (photoSupport_id)
REFERENCES photoSupport(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

ALTER TABLE photo 
ADD CONSTRAINT photo_photoGenre_fk
FOREIGN KEY (photoGenre_id)
REFERENCES photoGenre(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

ALTER TABLE photo 
ADD CONSTRAINT photo_photoReproduction_fk
FOREIGN KEY (photoReproduction_id)
REFERENCES photoReproduction(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

ALTER TABLE photo 
ADD CONSTRAINT photo_location_fk
FOREIGN KEY (location_id)
REFERENCES location(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

ALTER TABLE photo 
ADD CONSTRAINT photo_studio_fk
FOREIGN KEY (studio_id)
REFERENCES entity(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

ALTER TABLE photo 
ADD CONSTRAINT photo_object_fk
FOREIGN KEY (object_id)
REFERENCES object(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

ALTER TABLE photo 
ADD CONSTRAINT photo_asset_fk
FOREIGN KEY (asset_id)
REFERENCES asset(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

-- IMAGE -------------------------------------------------------------
ALTER TABLE image 
ADD CONSTRAINT image_file_fk
FOREIGN KEY (file_id)
REFERENCES file(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

ALTER TABLE image 
ADD CONSTRAINT image_type_fk
FOREIGN KEY (type_id)
REFERENCES imageType(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

ALTER TABLE image 
ADD CONSTRAINT image_photo_fk
FOREIGN KEY (photo_id)
REFERENCES photo(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

-- NOTE --------------------------------------------------------------
ALTER TABLE note 
ADD CONSTRAINT note_account_fk
FOREIGN KEY (account_id)
REFERENCES account(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

-- BIOGRAPHY ---------------------------------------------------------
ALTER TABLE biography 
ADD CONSTRAINT biography_note_fk
FOREIGN KEY (note_id)
REFERENCES note(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

-- LOG ---------------------------------------------------------------
ALTER TABLE log 
ADD CONSTRAINT log_account_fk
FOREIGN KEY (account_id)
REFERENCES account(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

-- ENTITY ------------------------------------------------------------
ALTER TABLE entity 
ADD CONSTRAINT entity_image_fk
FOREIGN KEY (image_id)
REFERENCES image(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

ALTER TABLE entity 
ADD CONSTRAINT entity_biography_fk
FOREIGN KEY (biography_id)
REFERENCES biography(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

ALTER TABLE entity 
ADD CONSTRAINT entity_entityType_fk
FOREIGN KEY (entityType_id)
REFERENCES entityType(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

-- PERSON ------------------------------------------------------------
ALTER TABLE person 
ADD CONSTRAINT person_entity_fk
FOREIGN KEY (entity_id)
REFERENCES entity(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

-- PHOTOGRAPHER ------------------------------------------------------
ALTER TABLE photographer 
ADD CONSTRAINT photographer_person_fk
FOREIGN KEY (person_id)
REFERENCES person(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

-- ORGANISATION ------------------------------------------------------
ALTER TABLE organisation 
ADD CONSTRAINT organisation_entity_fk
FOREIGN KEY (entity_id)
REFERENCES entity(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

-- ENTITYLOCATION ----------------------------------------------------
ALTER TABLE entityLocation 
ADD CONSTRAINT entityLocation_entity_fk
FOREIGN KEY (entity_id)
REFERENCES entity(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

ALTER TABLE entityLocation 
ADD CONSTRAINT entityLocation_location_fk
FOREIGN KEY (location_id)
REFERENCES location(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

-- ORGANISATION PEOPLE -----------------------------------------------
ALTER TABLE organisation_persons 
ADD CONSTRAINT organisation_persons_organisation_fk
FOREIGN KEY (organisation_id)
REFERENCES organisation(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

ALTER TABLE organisation_persons 
ADD CONSTRAINT organisation_persons_person_fk
FOREIGN KEY (person_id)
REFERENCES person(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

-- COLLECTION --------------------------------------------------------
ALTER TABLE collection 
ADD CONSTRAINT collection_owner_fk
FOREIGN KEY (owner)
REFERENCES entity(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

ALTER TABLE collection 
ADD CONSTRAINT collection_location_fk
FOREIGN KEY (location_id)
REFERENCES location(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

ALTER TABLE collection 
ADD CONSTRAINT collection_depositor_fk
FOREIGN KEY (depositor)
REFERENCES entity(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

ALTER TABLE collection 
ADD CONSTRAINT collection_researcher_fk
FOREIGN KEY (researcher)
REFERENCES entity(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

ALTER TABLE collection 
ADD CONSTRAINT collection_contract_fk
FOREIGN KEY (contract_id)
REFERENCES contract(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

-- COLLECTION NOTES --------------------------------------------------
ALTER TABLE collection_notes 
ADD CONSTRAINT collection_notes_collection_fk
FOREIGN KEY (collection_id)
REFERENCES collection(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

ALTER TABLE collection_notes 
ADD CONSTRAINT collection_notes_note_fk
FOREIGN KEY (note_id)
REFERENCES note(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

-- ACCOUNT -----------------------------------------------------------
ALTER TABLE account 
ADD CONSTRAINT account_entity_fk
FOREIGN KEY (entity_id)
REFERENCES entity(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

-- ACCOUNT ROLES -----------------------------------------------------
ALTER TABLE account_roles 
ADD CONSTRAINT account_roles_account_fk
FOREIGN KEY (account_id)
REFERENCES account(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

ALTER TABLE account_roles 
ADD CONSTRAINT account_roles_role_fk
FOREIGN KEY (role_id)
REFERENCES role(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

-- ROLE PERMISSIONS --------------------------------------------------
ALTER TABLE role_permissions 
ADD CONSTRAINT role_permissions_role_fk
FOREIGN KEY (role_id)
REFERENCES role(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

ALTER TABLE role_permissions 
ADD CONSTRAINT role_permissions_permission_fk
FOREIGN KEY (permission_id)
REFERENCES permission(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

-- ACCOUNT PERMISSIONS -----------------------------------------------
ALTER TABLE account_permissions 
ADD CONSTRAINT account_permissions_account_fk
FOREIGN KEY (account_id)
REFERENCES account(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

ALTER TABLE account_permissions 
ADD CONSTRAINT account_permissions_permission_fk
FOREIGN KEY (permission_id)
REFERENCES permission(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

-- CONTRACT ----------------------------------------------------------
ALTER TABLE contract 
ADD CONSTRAINT contract_entity_fk
FOREIGN KEY (entity_id)
REFERENCES entity(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

-- CONTRACT IMAGES ---------------------------------------------------
ALTER TABLE contract_images 
ADD CONSTRAINT contract_images_contract_fk
FOREIGN KEY (contract_id)
REFERENCES contract(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;

ALTER TABLE contract_images
ADD CONSTRAINT contract_images_image_fk
FOREIGN KEY (image_id)
REFERENCES image(id)
NOT DEFERRABLE
INITIALLY IMMEDIATE
;