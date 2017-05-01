<?php
ini_set("soap.wsdl_cache_enabled", "0"); // disabling WSDL cache
$fecha = date("Y-m-d H:i:s");

class feWs{
   
  public $gbl_site = 'http://localhost/Infosys_spa/';
  public $preurl = 'http://localhost/Infosys_spa/core/index.php/';

  public function obtieneFolio($tipodocto) {


    $url = $this->preurl . 'facturas/folio_documento_electronico/' . $tipodocto . '/dte' ;
    function_exists('curl_version') or die('CURL support required');
    function_exists('json_encode') or die('JSON support required');

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_HEADER, FALSE);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
    $contenido=curl_exec($ch);

    $array_folio = json_decode( preg_replace('/[\x00-\x1F\x80-\xFF]/', '', $contenido));
    return $array_folio->folio;
  }
  
  
}
  
$server = new SoapServer("feWs.wsdl",array('encoding'=>'ISO-8859-1'));
$server->setClass('feWs');
$server->handle();