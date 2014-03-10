<?php

date_default_timezone_set('Asia/Tokyo');
mb_internal_encoding("UTF-8");
mb_regex_encoding('UTF-8');

$queryText = (isset($_POST['queryText']) && $_POST['queryText']) ? $_POST['queryText'] : 'undefined';

$url_replaced = $queryText;

if($url_replaced == 'undefined'){ print ''; exit; }

$url_replaced_decoded = urldecode($url_replaced);

$fp = fopen('tts.txt', 'w+');
fwrite($fp, $url_replaced_decoded);
fclose($fp);

$referer = $_SERVER["HTTP_REFERER"];
$tts_url = preg_replace('/DodontoF¥.swf/ui', '', $referer);
$webif_url = preg_replace('/¥.swf/ui', 'Server.rb',$referer);

$data = array(
    'webif' => 'createTTS',
    'input_file' => 'tts.txt',
    'output_file' => 'tts.wav',
);
$headers = array(
    'User-Agent: Mozilla/5.5'
);
$options = array('http' => array(
    'method' => 'POST',
    'content' => http_build_query($data),
    'header' => implode("¥r¥n", $headers),
));
$contents = file_get_contents($webif_url, false, stream_context_create($options));

$data_url = $tts_url . "tts.wav";

$options = array('http' => array(
    'method' => 'GET',
    'content' => http_build_query($data),
    'header' => implode("¥r¥n", $headers),
));

//print "$url\n";
$fp = @fopen($url, 'r', false, $context);
if($fp){
	fpassthru($fp);
	fclose($fp);
}

$data = array(
    'webif' => 'deleteTTS',
    'target_file' => 'tts.txt',
);

$options = array('http' => array(
    'method' => 'POST',
    'content' => http_build_query($data),
    'header' => implode("¥r¥n", $headers),
));

$contents = file_get_contents($webif_url, false, stream_context_create($options));

$data = array(
    'webif' => 'deleteTTS',
    'target_file' => 'tts.wav',
);

$options = array('http' => array(
    'method' => 'POST',
    'content' => http_build_query($data),
    'header' => implode("¥r¥n", $headers),
));

$contents = file_get_contents($webif_url, false, stream_context_create($options));

?>
