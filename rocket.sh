#!/bin/bash

# vim:tabstop=3

# $Id: rocket.sh,v 1.1 2014/09/15 18:05:50 condor Exp condor $

# File    	: sql_rocket.sh
# Purpose 	: Wrapper for the sqlite3 executable.
# Algorithm	: Validate the existance of the dabase and test if the SQL 
#				  commands exist in a file, or on the command line to detirmine 
#				  the proper method of calling the database's command line tool.   
# Date    	: 9/15/14
# Author  	: Joseph Pesco
#
# To Do     : 1. Test for the proper number of command line arguments 
#             2. Make sure the sql processor is installed.  

process_sql () {
   local BUGGY=1						# 0 no debug output, 1 enable debug output
   local SQLPROCESSOR=sqlite3		#  `-line' is one of several  pretty outputs
   local TARGET="${1}"				# 
   local db=rocket.db				# for this demonstration db resides locally

   (($BUGGY)) && {
      echo "DEBUG, line $LINENO, $FUNCNAME"
      echo "DEBUG, line $LINENO,  \$SQLPROCESSOR                       : $SQLPROCESSOR"
      echo "DEBUG, line $LINENO,  \$#           (number of parameters) : $#"
      echo "DEBUG, line $LINENO, \$TARGET (sql statement, or sql file) : $TARGET"
   }

   if [ -f "${TARGET}" ]; then

      (($BUGGY)) && echo "DEBUG, line $LINENO, processing an sql file" 
      # The user gave a file name on the command line.
		${SQLPROCESSOR}  ${db} < ${TARGET}
   elif [ -n "${TARGET}" ]; then

		# Watch this: turning off filename globbing by issuing `set -f'
		# (on the command line before working with this script) 
		# allows us to neglect the quotes! We'll have to stuff the 
		# intire command line into the variable though:
		# TARGET="${@};" 
		# (($BUGGY)) && echo "DEBUG, line $LINENO, \$TARGET:  ${TARGET}"

		(($BUGGY)) && echo "DEBUG, line $LINENO, processing a cl sql statement"
		# The user gave a sql statement on the command line. 
		echo "${TARGET}" | ${SQLPROCESSOR} ${db} 
   else

		echo "ERROR: Command line is incorrct."
	fi 

}

process_sql "$@"

# $Log: rocket.sh,v $
# Revision 1.1  2014/09/15 18:05:50  condor
# Initial revision
#
