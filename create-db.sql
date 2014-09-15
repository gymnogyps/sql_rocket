-- 
-- vim:tabstop=3
--
-- $Id: create-db.sql,v 1.1 2014/09/15 18:20:18 condor Exp condor $
--
-- File      : create-db.sql
-- Purpose   : create a sqlite3 database that should (hopefully) not fail due 
--             to anomolies
-- Algorithm :  
-- Date      : 9/15/14
-- Author    : Joseph Pesco

-- NOTES     : 1. the KEY columns must be integers or they will not increment
--             2. lower case with underscore seems to be how Oracle does names
--                (mysql workbench uses this nameing convention in the samples)
-- ----------------------------------------------------------------------------

PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS `container` (
	`container_id` INTEGER NOT NULL ,
	`creation_ts` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`label` TEXT NOT NULL,
	`describtion` TEXT NOT NULL,
	PRIMARY KEY (`container_id`)
);

CREATE TABLE IF NOT EXISTS `element` (
	`element_id` INTEGER NOT NULL ,
	`element_container_id` INTEGER NOT NULL,
	`creation_ts` INTEGER NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`content` text NOT NULL,
	PRIMARY KEY (`element_id`),
	CONSTRAINT `element_1` FOREIGN KEY (`element_container_id`) REFERENCES `container` (`container_id`)
);

INSERT OR IGNORE INTO `container` (`container_id`, `label`, `describtion`) VALUES 
			( 1, 'First Normal Form', 'A brief describtion of first normal form gleened from Wikipedia');

INSERT OR IGNORE  INTO `element` ( `element_container_id`, `content` ) VALUES 
			( 1,  "There's no top-to-bottom ordering to the rows." ),
			( 1, "There's no left-to-right ordering to the columns."),  
			( 1, "There are no duplicate rows." ), 
			( 1, "Every row-and-column intersection contains exactly one value from the applicable domain (and nothing else)." ), 
			( 1, "All columns are regular [i.e. rows have no hidden components such as row IDs, object IDs, or hidden timestamps].");


INSERT OR IGNORE INTO `container` (`container_id`, `label`, `describtion`) VALUES 
			( 2, 'First Normal Form', 'First Normal Form from SQL for Dummies');

INSERT OR IGNORE  INTO `element` ( `element_container_id`, `content` ) VALUES 
			( 2,  "The table is two-dimensional, with rows and columns." ),
			( 2, "Each row contains data that pertains to some thing or portion of a thing."),  
			( 2, "Each column contains data for a single attribute of the thing it’s describing." ), 
			( 2, "Each cell (intersection of a row and a column) of the table must have only a single value." ), 
			( 2, "Entries in any column must all be of the same kind."), 
  			( 2, "Each column must have a unique name."),
			( 2, "No two columns may be identical."),
			( 2, "The order of the columns and the order of the rows are not significant.");

