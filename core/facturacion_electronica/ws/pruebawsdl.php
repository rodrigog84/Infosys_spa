<?php


ini_set("soap.wsdl_cache_enabled", "0");
$client = new SoapClient('http://localhost/Infosys_spa/core/facturacion_electronica/ws/feWs.wsdl',array('login' => '111','password' => '222'));

var_dump($client); 

$detalledte = array();
$detalledte[0] = array(
				'codigos' => 1,
				'cantidads' => 1,
				'unidads' => 1,
				'nombres' => 1,
				'preciounits' => 1,
				'totals' => 1
					);

$detalledte[1] = array(
				'codigos' => 2,
				'cantidads' => 2,
				'unidads' => 2,
				'nombres' => 2,
				'preciounits' => 2,
				'totals' => 2
					);

$datos_dte = array(
				'tipocaf' => 1,
				'folio' => 1,
				'fecfactura' => 1,
				'condventa' => 1,
				'rutreceptor' => 1,
				'razonsocial' => 1,
				'giro' => 1,
				'total' => 1,
				'direccion' => 1,
				'comuna' => 1,
				'ciudad' => 1,
				'neto' => 1,
				'iva' => 1,
				'total' => 1,
				'detalledte' => $detalledte
			);



$folio = $client->creaDte($datos_dte);

var_dump($folio);