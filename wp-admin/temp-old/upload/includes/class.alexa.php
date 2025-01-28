<?

class alexa {

    var $xml;
    var $values;
    var $alexa_address;

    function alexa($alexa_address,$domain) {
        $this->alexa_address = $alexa_address;
        $this->xml = $this->get_data($domain);
        $this->set();
    }

    function get_data($domain) {
        $url = $this->alexa_address.'http://'.$domain;
        $xml = @simplexml_load_file($url);
        return $xml;
    }

    function set() {
        $this->values['rank'] = ($this->xml->SD->POPULARITY['TEXT'] ? number_format($this->xml->SD->POPULARITY['TEXT']) : 0);
    }

    function get($value) {
        return (isset($this->values[$value]) ? $this->values[$value] : '"'.$value.'" does not exist.');
    }
}

?>