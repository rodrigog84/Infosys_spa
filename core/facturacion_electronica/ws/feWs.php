<?php

ini_set("soap.wsdl_cache_enabled", "0"); // disabling WSDL cache
$fecha = date("Y-m-d H:i:s");

class feWs{
   
  public $gbl_site = 'http://localhost/Infosys_spa/';
  public $preurl = 'http://localhost/Infosys_spa/core/index.php/';

  public function __construct(){
      $this->authenticate($_SERVER['PHP_AUTH_USER'], $_SERVER['PHP_AUTH_PW']);
  }



  /**
  * Function for authenticate users.
  * @param string $username The username.
  * @param string $password The user password.
  */

  public function authenticate($username, $password){

      if($username != "111") throw new SoapFault("Error ", 'El usuario no existe.');
      if($password != "222") throw new SoapFault("Error ", 'La contraseña es incorrecta.');
  }



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
  

  public function creaDte($dte) {
    //print_r($dte); exit;

    /*$url = $this->preurl . 'facturas/crea_factura_fe/' ;
    function_exists('curl_version') or die('CURL support required');
    function_exists('json_encode') or die('JSON support required');

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_HEADER, FALSE);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
    $contenido=curl_exec($ch);*/

    //$array_folio = json_decode( preg_replace('/[\x00-\x1F\x80-\xFF]/', '', $contenido));
    //return $array_folio->folio;
    return json_encode($dte);
  }


  
}
  
$server = new SoapServer("feWs.wsdl",array('encoding'=>'ISO-8859-1'));
$server->setClass('feWs');


/*function Authenticate($login) {
    if ($login->username === "111" && $login->password === "222") {
        return array('Authenticated'=>true);
    } else {
        return array('Authenticated'=>false);
    }
}
$server->addFunction("Authenticate");*/



$server->handle();