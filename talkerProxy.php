<?php

date_default_timezone_set('Asia/Tokyo');
mb_internal_encoding("UTF-8");
mb_regex_encoding('UTF-8');

$queryText = (isset($_POST['queryText']) && $_POST['queryText']) ? $_POST['queryText'] : 'undefined';

$url_replaced = $queryText;

if($url_replaced == 'undefined'){ print ''; exit; }

$url_replaced_decoded = urldecode($url_replaced);

// くまかばさん感謝！でも、なぜかさくらのFreeBSDのPHPでは preg ではなく ereg しか動かなかった！

// 固有名詞置換
// Elysion関連
$url_replaced_decoded = ereg_replace('elysion',' えりゅしおん ',$url_replaced_decoded);

$url_replaced_decoded = ereg_replace('「','・',$url_replaced_decoded);
$url_replaced_decoded = ereg_replace('」','・',$url_replaced_decoded);
$url_replaced_decoded = ereg_replace('^：(\d+) \((\d+D%*\d+).*',' だいすろーる・$2・合計・$1 ',$url_replaced_decoded);
$url_replaced_decoded = ereg_replace('^：+','',$url_replaced_decoded);
$url_replaced_decoded = ereg_replace('([^a-zA-Zａ-ｚＡ-Ｚ])[wｗ]+$','$1・わら ',$url_replaced_decoded);
$url_replaced_decoded = ereg_replace('([^a-zA-Zａ-ｚＡ-Ｚ])[wｗ]{2,}','$1・',$url_replaced_decoded);
$url_replaced_decoded = ereg_replace('[\.。．・…]{2,}','・',$url_replaced_decoded);
$url_replaced_decoded = ereg_replace('…','・',$url_replaced_decoded);
$url_replaced_decoded = ereg_replace('(ftp|http|https)\:\/\/.*','・$1のurlです・',$url_replaced_decoded);

// 辞書系
$url_replaced_decoded = ereg_replace('↑','・うえ・',$url_replaced_decoded);
$url_replaced_decoded = ereg_replace('↓','・した・',$url_replaced_decoded);
$url_replaced_decoded = ereg_replace('←','・ひだり・',$url_replaced_decoded);
$url_replaced_decoded = ereg_replace('→','・みぎ・',$url_replaced_decoded);
$url_replaced_decoded = ereg_replace('欠片','かけら',$url_replaced_decoded);
$url_replaced_decoded = ereg_replace('SANチェック','さんちぇっく',$url_replaced_decoded);
$url_replaced_decoded = ereg_replace('ＳＡＮチェック','さんちぇっく',$url_replaced_decoded);
$url_replaced_decoded = ereg_replace('百合展開','きましたわー',$url_replaced_decoded);
$url_replaced_decoded = ereg_replace('百合','ゆり',$url_replaced_decoded);
$url_replaced_decoded = ereg_replace('ktkr','きたこれ',$url_replaced_decoded);
$url_replaced_decoded = ereg_replace('ｋｔｋｒ','きたこれ',$url_replaced_decoded);
$url_replaced_decoded = ereg_replace('ksk','かそく',$url_replaced_decoded);
$url_replaced_decoded = ereg_replace('ｋｓｋ','かそく',$url_replaced_decoded);
$url_replaced_decoded = ereg_replace('晶石','しょうせき',$url_replaced_decoded);

$fp = fopen('tts.txt', 'w+');
fwrite($fp, $url_replaced_decoded);
fclose($fp);

$referer = $_SERVER["HTTP_REFERER"];
$tts_url = ereg_replace('DodontoF\.swf', '', $referer);
$webif_url = ereg_replace('\.swf', 'Server.rb',$referer);

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
$fp = @fopen($tts_url, 'r', false, $context);
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
