<?php
/**
 * Created by IntelliJ IDEA.
 * User: hani
 * Date: 2018/11/15
 * Time: 1:50
 */
// php pharvalid.php phar名　でレスポンス。
for(;;) {

	$filename = $argv[1];
	if (!isset($filename)) {
		echo "Eneedarg";
		break;
	}

	if (!file_exists($filename)) {
		echo "Efilenotfound";
		break;
	}

	if (!Phar::isValidPharFilename($filename)){
		echo "EisValidPharFilename:false";
		break;
	}

	try {
		$p = new Phar($filename, 0, "mochikomi.phar");
		$hash = $p->getSignature()["hash"];
		echo "##hash##".$p->getSignature()["hash"]."##hash##";
		break;
	}catch (Exception $e){
		echo "Epharstructureerror";
		break;
	}

	break;

}
exit();