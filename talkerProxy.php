<?php

date_default_timezone_set('Asia/Tokyo');
mb_internal_encoding("UTF-8");
mb_regex_encoding('UTF-8');

$queryText = (isset($_POST['queryText']) && $_POST['queryText']) ? $_POST['queryText'] : 'undefined';

$url_replaced = $queryText;

if($url_replaced == 'undefined'){ print ''; exit; }

$url_replaced_decoded   = urldecode($url_replaced);

// 固有名詞置換
// Elysion関連
$url_replaced_decoded = preg_replace('/elysion/i',' えりゅしおん ',$url_replaced_decoded);

$url_replaced_decoded = preg_replace('/「/ui','・',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/」/ui','・',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/^：(¥d+) ¥((¥d+D%*¥d+).*/',' だいすろーる・$2・合計・$1 ',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/^：+/ui','',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/([^a-zA-Zａ-ｚＡ-Ｚ])[wｗ]+$/ui','$1・わら ',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/([^a-zA-Zａ-ｚＡ-Ｚ])[wｗ]{2,}/ui','$1・',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/[¥.。．・…]{2,}/ui','・',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/…/ui','・',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/(ftp|http|https)¥:¥/¥/.*/ui','・$1のurlです・',$url_replaced_decoded);

// 辞書系
$url_replaced_decoded = preg_replace('/↑/ui','・うえ・',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/↓/ui','・した・',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/←/ui','・ひだり・',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/→/ui','・みぎ・',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/欠片/ui','かけら',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/SANチェック/ui','さんちぇっく',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/ＳＡＮチェック/ui','さんちぇっく',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/百合展開/ui','きましたわー',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/百合/ui','ゆり',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/ktkr/ui','きたこれ',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/ｋｔｋｒ/ui','きたこれ',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/ksk/ui','かそく',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/ｋｓｋ/ui','かそく',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/晶石/ui','しょうせき',$url_replaced_decoded);

$fp = fopen('tts.txt', 'w');
fwrite($fp ,$url_replaced_decoded);
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

$context = stream_context_create($option);
$fp = fopen($data_url, 'r', false, $context);
fpassthru($fp);
fclose($fp);

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
