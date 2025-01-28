<?php

if (!defined('traidnt')) {
    die("Error: 404 Not Found");
}



class DB
{
    /**
     * global variables
     */
    var $dbhost;
    var $dblogin;
    var $dbpass;
    var $dbname;
    var $dblink;
    var $queryid;
    var $error = array();
    var $record = array();
    var $totalrecords;
    var $last_insert_id;
    var $previd = 0;
    var $transactions_capable = false;
    var $begin_work = false;



    function get_dbhost()
    {
        return $this->dbhost;

    } // end function

    function get_dblogin()
    {
        return $this->dblogin;

    } // end function

    function get_dbpass()
    {
        return $this->dbpass;

    } // end function

    function get_dbname()
    {
        return $this->dbname;

    } // end function

    function set_dbhost($value)
    {
        return $this->dbhost = $value;

    } // end function

    function set_dblogin($value)
    {
        return $this->dblogin = $value;

    } // end function

    function set_dbpass($value)
    {
        return $this->dbpass = $value;

    } // end function

    function set_dbname($value)
    {
        return $this->dbname = $value;

    } // end function

    function get_errors()
    {
        return $this->error;

    } // end function

    /**
     * End of the Get and Set methods
     */


    function DB($dblogin, $dbpass, $dbname, $dbhost )
    {
        $this->set_dblogin($dblogin);
        $this->set_dbpass($dbpass);
        $this->set_dbname($dbname);

        if ($dbhost != null) {
            $this->set_dbhost($dbhost);
        }

    } // end function


    function connect()
    {
        $this->dblink = @mysql_pconnect($this->dbhost, $this->dblogin, $this->dbpass)or die (mysql_error());

        if (!$this->dblink) {
            $this->return_error('ÛíÑ ŞÇÏÑ Úáí ÇáÇÊÕÇá ÈŞÇÚÏå ÇáÈíÇäÇÊ');
        }

        $t = @mysql_select_db($this->dbname, $this->dblink);

        if (!$t) {
            $this->return_error('ÛíÑ ŞÇÏÑ Úáí ÇáÇÊÕÇá ÈŞÇÚÏå ÇáÈíÇäÇÊ');
        }

        if ($this->serverHasTransaction()) {
            $this->transactions_capable = true;
        }

        return $this->dblink;

    } // end function


    function disconnect()
    {
        $test = @mysql_close($this->dblink);

        if (!$test) {
            $this->return_error('ÛíÑ ŞÇÏÑ Úáí ÇÛáÇŞ ÇáÇÊÕÇá');
        }

        unset($this->dblink);

    } // end function


    function return_error($message)
    {
        return $this->error[] = $message.' '.mysql_error().'.';

    } // end function


    function showErrors()
    {
        if ($this->hasErrors()) {
            reset($this->error);

            $errcount = count($this->error);    //count the number of error messages

            echo "<p><b>'$errcount'</b>ÈÑÌÇÁ ãÑÇÌÚå ÇáÇÎØÇÁ ÇáÊÇáíÉ ÚÏÏ ÇáÇÎØÇÁ </p>\n";

            // print all the error messages.
            while (list($key, $val) = each($this->error)) {
                echo "+ $val<br>\n";
            }

            $this->resetErrors();
        }

    } // end function


    function hasErrors()
    {
        if (count($this->error) > 0) {
            return true;
        } else {
            return false;
        }

    } // end function


    function resetErrors()
    {
        if ($this->hasErrors()) {
            unset($this->error);
            $this->error = array();
        }

    } // end function


    function query($sql)
    {
        if (empty($this->dblink)) {
            // check to see if there is an open connection. If not, create one.
            $this->connect();
        }

        $this->queryid = @mysql_query($sql, $this->dblink);

        if (!$this->queryid) {
            if ($this->begin_work) {
                $this->rollbackTransaction();
            }

            $this->return_error('<b>' . $sql . '</b>ÛíÑ ŞÇÏÑ Úáí ÊäİíĞ ÇáÇÓÊÚáÇã ÇáÊÇáí :.');
        }

        $this->previd = 0;

        return $this->queryid;

    } // end function


    function fetchRow()
    {
        if (isset($this->queryid)) {
            $this->previd++;
            return $this->record = @mysql_fetch_array($this->queryid);
        } else {
            $this->return_error('ÇáÇÓÊÚáÇã ÛíÑ ãÊæİÑ');
        }

    } // end function


    function moveFirst()
    {
        if (isset($this->queryid)) {
            $t = @mysql_data_seek($this->queryid, 0);

            if ($t) {
                $this->previd = 0;
                return $this->fetchRow();
            } else {
                $this->return_error('ÛíÑ ŞÇÏÑ Úáí ÇáäŞá');
            }
        } else {
            $this->return_error('áÇ íæÌÏ ÇÓÊÚáÇã');
        }

    } // end function


    function moveLast()
    {
        if (isset($this->queryid)) {
            $this->previd = $this->resultCount()-1;

            $t = @mysql_data_seek($this->queryid, $this->previd);

            if ($t) {
                return $this->fetchRow();
            } else {
                $this->return_error('ÛíÑ ŞÇÏÑ Úáí ÇáäŞá');
            }
        } else {
            $this->return_error('áÇ íæÌÏ ÇÓÊÚáÇã');
        }

    } // end function


    function moveNext()
    {
        return $this->fetchRow();

    } // end function


    function movePrev()
    {
        if (isset($this->queryid)) {
            if ($this->previd > 1) {
                $this->previd--;

                $t = @mysql_data_seek($this->queryid, --$this->previd);

                if ($t) {
                    return $this->fetchRow();
                } else {
                    $this->return_error('ÛíÑ ŞÇÏÑ Úáí ÇáäŞá');
                }
            } else {
                $this->return_error('ÛíÑ ŞÇÏÑ Úáí ÇíÌÇÏ ÇáÌÏæá');
            }
        } else {
            $this->return_error('áÇ íæÌÏ ÇÓÊÚáÇã');
        }

    } // end function



    function fetchLastInsertId()
    {
        $this->last_insert_id = @mysql_insert_id($this->dblink);

        if (!$this->last_insert_id) {
            $this->return_error('ÛíÑ ŞÇÏÑ Úáí ÌáÈ ÇáÇí Ïí');
        }

        return $this->last_insert_id;

    } // end function


    function resultCount()
    {
        $this->totalrecords = @mysql_num_rows($this->queryid);

        if (!$this->totalrecords) {
            $this->return_error('ÛíÑ ŞÇÏÑ Úáí ÍÓÇÈ ÚÏÏ ÇáäÊÇÆÌ');
        }

        return $this->totalrecords;

    } // end function


    function resultExist()
    {
        if (isset($this->queryid) && ($this->resultCount() > 0)) {
            return true;
        }

        return false;

    } // end function


    function clear($result = 0)
    {
        if ($result != 0) {
            $t = @mysql_free_result($result);

            if (!$t) {
                $this->return_error('ÛíÑ ŞÇÏÑ Úáí ÊİÑíÛ ÇáĞÇßÑÉ');
            }
        } else {
            if (isset($this->queryid)) {
                $t = @mysql_free_result($this->queryid);

                if (!$t) {
                    $this->return_error('ÛíÑ ŞÇÏÑ Úáí ÊİÑíÛ ÇáĞÇßÑÉ');
                }
            } else {
                $this->return_error('áã ÊŞã ÈÇÎÊíÇÑ ÇÓÊÚáÇã áíÊã ÊİÑíÛå');
            }
        }

    } // end function


    function serverHasTransaction()
    {
        $this->query('SHOW VARIABLES');

        if ($this->resultExist()) {
            while ($this->fetchRow()) {
                if ($this->record['Variable_name'] == 'have_bdb' && $this->record['Value'] == 'YES') {
                    $this->transactions_capable = true;
                    return true;
                }

                if ($this->record['Variable_name'] == 'have_gemini' && $this->record['Value'] == 'YES') {
                    $this->transactions_capable = true;
                    return true;
                }

                if ($this->record['Variable_name'] == 'have_innodb' && $this->record['Value'] == 'YES') {
                    $this->transactions_capable = true;
                    return true;
                }
            }
        }

        return false;

    } // end function


    function beginTransaction()
    {
        if ($this->transactions_capable) {
            $this->query('BEGIN');
            $this->begin_work = true;
        }

    } // end function


    function commitTransaction()
    {
        if ($this->transactions_capable) {
            if ($this->begin_work) {
                $this->query('COMMIT');
                $this->begin_work = false;
            }
        }
    }


    function rollbackTransaction()
    {
        if ($this->transactions_capable) {
            if ($this->begin_work) {
                $this->query('ROLLBACK');
                $this->begin_work = false;
            }
        }

    } // end function

} // end class

?>
